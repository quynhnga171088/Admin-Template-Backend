package com.lms.repository;

import com.lms.entity.Lesson;
import com.lms.entity.Section;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface SectionRepository extends JpaRepository<Section, Long> {

    List<Section> findAllByLessonOrderByOrderIndexAsc(Lesson lesson);

    Optional<Section> findByIdAndLesson(Long id, Lesson lesson);

    @Query("SELECT COALESCE(MAX(s.orderIndex), 0) FROM Section s WHERE s.lesson = :lesson AND s.deletedAt IS NULL")
    int findMaxOrderIndexByLesson(@Param("lesson") Lesson lesson);
}
