package com.lms.repository;

import com.lms.entity.Chapter;
import com.lms.entity.Course;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ChapterRepository extends JpaRepository<Chapter, Long> {

    List<Chapter> findAllByCourseOrderByOrderIndexAsc(Course course);

    Optional<Chapter> findByIdAndCourse(Long id, Course course);

    @Query("SELECT COALESCE(MAX(c.orderIndex), -1) FROM Chapter c WHERE c.course = :course")
    int findMaxOrderIndexByCourse(@Param("course") Course course);
}
