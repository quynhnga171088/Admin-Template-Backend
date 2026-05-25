package com.lms.repository;

import com.lms.entity.Chapter;
import com.lms.entity.Course;
import com.lms.entity.Lesson;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface LessonRepository extends JpaRepository<Lesson, Long> {

    // ─── Chapter-scoped (primary) ──────────────────────────────────────────────

    List<Lesson> findAllByChapterOrderByOrderIndexAsc(Chapter chapter);

    Optional<Lesson> findByIdAndChapter(Long id, Chapter chapter);

    @Query("SELECT COALESCE(MAX(l.orderIndex), -1) FROM Lesson l WHERE l.chapter = :chapter")
    int findMaxOrderIndexByChapter(@Param("chapter") Chapter chapter);

    long countByChapter(Chapter chapter);

    List<Lesson> findAllByChapterIn(List<Chapter> chapters);

    // ─── Course-scoped (via chapter navigation) — used by existing services ───

    /** Count all non-deleted lessons belonging to a course (via chapters). */
    @Query("SELECT COUNT(l) FROM Lesson l WHERE l.chapter.course = :course AND l.deletedAt IS NULL")
    long countByCourse(@Param("course") Course course);

    /** All non-deleted lessons of a course ordered by chapter order then lesson order. */
    @Query("SELECT l FROM Lesson l WHERE l.chapter.course = :course AND l.deletedAt IS NULL " +
           "ORDER BY l.chapter.orderIndex ASC, l.orderIndex ASC")
    List<Lesson> findAllByCourseOrderByOrderIndexAsc(@Param("course") Course course);
}

