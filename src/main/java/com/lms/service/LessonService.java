package com.lms.service;

import com.lms.dto.lesson.*;
import com.lms.dto.section.SectionResponse;
import com.lms.entity.*;
import com.lms.exception.ResourceNotFoundException;
import com.lms.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class LessonService {

    private final LessonRepository    lessonRepository;
    private final SectionRepository   sectionRepository;
    private final CourseService       courseService;
    private final ChapterService      chapterService;

    // ──────────────────────────────────────────────────────────────
    // Mutation (Teacher / Admin)
    // ──────────────────────────────────────────────────────────────

    @Transactional
    public LessonResponse createLesson(Long courseId, Long chapterId,
                                       CreateLessonRequest req, User teacher) {
        Course course   = courseService.getCourseOrThrow(courseId);
        Chapter chapter = chapterService.getChapterOrThrow(chapterId, course);
        checkTeacherWriteAccess(course, teacher);

        int nextOrder = lessonRepository.findMaxOrderIndexByChapter(chapter) + 1;

        Lesson lesson = Lesson.builder()
                .chapter(chapter)
                .title(req.getTitle())
                .description(req.getDescription())
                .avatarUrl(req.getAvatarUrl())
                .orderIndex(nextOrder)
                .build();

        Lesson saved = lessonRepository.save(lesson);
        return LessonResponse.fromEntity(saved);
    }

    @Transactional
    public LessonResponse updateLesson(Long courseId, Long chapterId, Long lessonId,
                                       UpdateLessonRequest req, User teacher) {
        Course course   = courseService.getCourseOrThrow(courseId);
        Chapter chapter = chapterService.getChapterOrThrow(chapterId, course);
        Lesson lesson   = getLessonOrThrow(lessonId, chapter);
        checkTeacherWriteAccess(course, teacher);

        if (req.getTitle() != null)       lesson.setTitle(req.getTitle());
        if (req.getDescription() != null) lesson.setDescription(req.getDescription());
        if (req.getAvatarUrl() != null)   lesson.setAvatarUrl(req.getAvatarUrl());

        Lesson saved = lessonRepository.save(lesson);

        List<SectionResponse> sections = sectionRepository
                .findAllByLessonOrderByOrderIndexAsc(saved)
                .stream().map(SectionResponse::fromEntity).toList();

        return LessonResponse.fromEntity(saved, sections);
    }

    @Transactional
    public void softDeleteLesson(Long courseId, Long chapterId, Long lessonId, User teacher) {
        Course course   = courseService.getCourseOrThrow(courseId);
        Chapter chapter = chapterService.getChapterOrThrow(chapterId, course);
        Lesson lesson   = getLessonOrThrow(lessonId, chapter);
        checkTeacherWriteAccess(course, teacher);

        // Soft-delete all sections inside this lesson first
        List<Section> sections = sectionRepository.findAllByLessonOrderByOrderIndexAsc(lesson);
        LocalDateTime now = LocalDateTime.now();
        sections.forEach(s -> s.setDeletedAt(now));
        sectionRepository.saveAll(sections);

        lesson.setDeletedAt(now);
        lessonRepository.save(lesson);
    }

    /**
     * Batch-update order_index for lessons within a chapter.
     */
    @Transactional
    public List<LessonResponse> reorderLessons(Long courseId, Long chapterId,
                                                ReorderLessonsRequest req, User teacher) {
        Course course   = courseService.getCourseOrThrow(courseId);
        Chapter chapter = chapterService.getChapterOrThrow(chapterId, course);
        checkTeacherWriteAccess(course, teacher);

        List<Lesson> allLessons = lessonRepository.findAllByChapterOrderByOrderIndexAsc(chapter);
        Map<Long, Lesson> lessonMap = allLessons.stream()
                .collect(Collectors.toMap(Lesson::getId, Function.identity()));

        for (ReorderLessonsRequest.ReorderItem item : req.getItems()) {
            Lesson l = lessonMap.get(item.getLessonId());
            if (l == null) throw new ResourceNotFoundException("Lesson", item.getLessonId());
            l.setOrderIndex(item.getOrderIndex());
        }
        lessonRepository.saveAll(lessonMap.values());

        return lessonRepository.findAllByChapterOrderByOrderIndexAsc(chapter)
                .stream().map(LessonResponse::fromEntity).toList();
    }

    // ──────────────────────────────────────────────────────────────
    // Helpers
    // ──────────────────────────────────────────────────────────────

    public Lesson getLessonOrThrow(Long lessonId, Chapter chapter) {
        return lessonRepository.findByIdAndChapter(lessonId, chapter)
                .orElseThrow(() -> new ResourceNotFoundException("Lesson", lessonId));
    }

    private void checkTeacherWriteAccess(Course course, User user) {
        if (user.getRole() == User.Role.ADMIN) return;
        if (user.getRole() == User.Role.TEACHER
                && course.getTeacher().getId().equals(user.getId())) return;
        throw new SecurityException("Access denied: you do not own this course");
    }
}
