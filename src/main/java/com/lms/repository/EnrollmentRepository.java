package com.lms.repository;

import com.lms.entity.Course;
import com.lms.entity.Enrollment;
import com.lms.entity.User;
import jakarta.persistence.criteria.Predicate;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Repository
public interface EnrollmentRepository extends JpaRepository<Enrollment, Long>, JpaSpecificationExecutor<Enrollment> {

    /** Dynamic filter specification — avoids passing null enum to PostgreSQL prepared statement. */
    static Specification<Enrollment> withFilters(Enrollment.Status status, Long courseId, Long studentId) {
        return (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();
            if (status != null) {
                predicates.add(cb.equal(root.get("status"), status));
            }
            if (courseId != null) {
                predicates.add(cb.equal(root.get("course").get("id"), courseId));
            }
            if (studentId != null) {
                predicates.add(cb.equal(root.get("student").get("id"), studentId));
            }
            return cb.and(predicates.toArray(new Predicate[0]));
        };
    }

    Optional<Enrollment> findByStudentAndCourseAndStatusIn(User student, Course course, List<Enrollment.Status> statuses);

    boolean existsByStudentAndCourseAndStatusIn(User student, Course course, List<Enrollment.Status> statuses);

    Optional<Enrollment> findByStudentAndCourseAndStatus(User student, Course course, Enrollment.Status status);

    Page<Enrollment> findAllByStudent(User student, Pageable pageable);

    // findAllWithFilters removed — use Specification<Enrollment> withFilters(...) + findAll(Specification, Pageable) instead
    // to avoid PostgreSQL "could not determine data type of parameter $1" error with null enum params.

    @Query("""
            SELECT e FROM Enrollment e
            JOIN FETCH e.student
            WHERE e.course = :course AND e.status = 'APPROVED'
            """)
    List<Enrollment> findApprovedStudentsByCourse(@Param("course") Course course);

    @Query("""
            SELECT e FROM Enrollment e
            JOIN FETCH e.course
            WHERE e.student = :student
            ORDER BY e.createdAt DESC
            """)
    List<Enrollment> findRecentByStudent(@Param("student") User student, Pageable pageable);

    /**
     * Batch-check enrollment status for multiple courses (used in course listing to append enrollmentStatus).
     */
    @Query("""
            SELECT e FROM Enrollment e
            WHERE e.student = :student AND e.course.id IN :courseIds
            """)
    List<Enrollment> findAllByStudentAndCourseIds(@Param("student") User student,
                                                   @Param("courseIds") java.util.List<Long> courseIds);

    long countByStatus(Enrollment.Status status);

    long countByCourse(Course course);

    /** Returns [courseId, courseTitle, courseSlug, courseThumbnailUrl, count] for top courses by enrollment */
    @Query("""
            SELECT e.course.id, e.course.title, e.course.slug, e.course.thumbnailUrl, COUNT(e)
            FROM Enrollment e
            GROUP BY e.course.id, e.course.title, e.course.slug, e.course.thumbnailUrl
            ORDER BY COUNT(e) DESC
            """)
    List<Object[]> findTopCoursesByEnrollmentCount(Pageable pageable);

    /** Returns [year, month, count] for enrollments of a course, grouped by month */
    @Query(value = """
            SELECT EXTRACT(YEAR FROM created_at)::int  AS year,
                   EXTRACT(MONTH FROM created_at)::int AS month,
                   COUNT(*)::int                       AS cnt
            FROM enrollments
            WHERE course_id = :courseId
              AND created_at >= :from
            GROUP BY 1, 2
            ORDER BY 1, 2
            """, nativeQuery = true)
    List<Object[]> countEnrollmentsByMonth(@Param("courseId") Long courseId,
                                           @Param("from") java.time.LocalDateTime from);

    List<Enrollment> findAllByStudent(User student);
}
