package com.lms.service;

import com.lms.dto.chapter.*;
import com.lms.dto.lesson.LessonResponse;
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
public class ChapterService {

    private final ChapterRepository chapterRepository;
    private final LessonRepository  lessonRepository;
    private final CourseService     courseService;

    // ──────────────────────────────────────────────────────────────
    // Retrieval
    // ──────────────────────────────────────────────────────────────

    /**
     * Lists all chapters of a course, with lessons nested inside each chapter.
     * Access-aware: unauthenticated/unenrolled users get lesson preview only.
     */
    @Transactional(readOnly = true)
    public List<ChapterResponse> listChapters(Long courseId, User currentUser, boolean fullAccess) {
        Course course = courseService.getCourseOrThrow(courseId);
        List<Chapter> chapters = chapterRepository.findAllByCourseOrderByOrderIndexAsc(course);

        return chapters.stream().map(chapter -> {
            List<LessonResponse> lessons = lessonRepository
                    .findAllByChapterOrderByOrderIndexAsc(chapter)
                    .stream()
                    .map(l -> fullAccess
                            ? LessonResponse.fromEntityFull(l)
                            : LessonResponse.fromEntityPreview(l))
                    .toList();
            return ChapterResponse.fromEntity(chapter, lessons);
        }).toList();
    }

    // ──────────────────────────────────────────────────────────────
    // Mutation (Teacher / Admin)
    // ──────────────────────────────────────────────────────────────

    @Transactional
    public ChapterResponse createChapter(Long courseId, CreateChapterRequest req, User teacher) {
        Course course = courseService.getCourseOrThrow(courseId);
        checkTeacherWriteAccess(course, teacher);

        int nextOrder = chapterRepository.findMaxOrderIndexByCourse(course) + 1;

        Chapter chapter = Chapter.builder()
                .course(course)
                .title(req.getTitle())
                .description(req.getDescription())
                .avatarUrl(req.getAvatarUrl())
                .orderIndex(nextOrder)
                .build();

        return ChapterResponse.fromEntity(chapterRepository.save(chapter));
    }

    @Transactional
    public ChapterResponse updateChapter(Long courseId, Long chapterId,
                                         UpdateChapterRequest req, User teacher) {
        Course course   = courseService.getCourseOrThrow(courseId);
        Chapter chapter = getChapterOrThrow(chapterId, course);
        checkTeacherWriteAccess(course, teacher);

        if (req.getTitle() != null)       chapter.setTitle(req.getTitle());
        if (req.getDescription() != null) chapter.setDescription(req.getDescription());
        if (req.getAvatarUrl() != null)   chapter.setAvatarUrl(req.getAvatarUrl());

        return ChapterResponse.fromEntity(chapterRepository.save(chapter));
    }

    @Transactional
    public void deleteChapter(Long courseId, Long chapterId, User teacher) {
        Course course   = courseService.getCourseOrThrow(courseId);
        Chapter chapter = getChapterOrThrow(chapterId, course);
        checkTeacherWriteAccess(course, teacher);

        // Soft-delete all lessons inside this chapter first
        List<Lesson> lessons = lessonRepository.findAllByChapterOrderByOrderIndexAsc(chapter);
        LocalDateTime now = LocalDateTime.now();
        lessons.forEach(l -> l.setDeletedAt(now));
        lessonRepository.saveAll(lessons);

        // Soft-delete the chapter itself
        chapter.setDeletedAt(now);
        chapterRepository.save(chapter);
    }

    /**
     * Batch-update order_index for chapters.
     */
    @Transactional
    public List<ChapterResponse> reorderChapters(Long courseId,
                                                  ReorderChaptersRequest req,
                                                  User teacher) {
        Course course = courseService.getCourseOrThrow(courseId);
        checkTeacherWriteAccess(course, teacher);

        List<Chapter> allChapters = chapterRepository.findAllByCourseOrderByOrderIndexAsc(course);
        Map<Long, Chapter> chapterMap = allChapters.stream()
                .collect(Collectors.toMap(Chapter::getId, Function.identity()));

        for (ReorderChaptersRequest.ReorderItem item : req.getItems()) {
            Chapter c = chapterMap.get(item.getChapterId());
            if (c == null) throw new ResourceNotFoundException("Chapter", item.getChapterId());
            c.setOrderIndex(item.getOrderIndex());
        }
        chapterRepository.saveAll(chapterMap.values());

        return chapterRepository.findAllByCourseOrderByOrderIndexAsc(course)
                .stream()
                .map(ChapterResponse::fromEntity)
                .toList();
    }

    // ──────────────────────────────────────────────────────────────
    // Helpers
    // ──────────────────────────────────────────────────────────────

    public Chapter getChapterOrThrow(Long chapterId, Course course) {
        return chapterRepository.findByIdAndCourse(chapterId, course)
                .orElseThrow(() -> new ResourceNotFoundException("Chapter", chapterId));
    }

    private void checkTeacherWriteAccess(Course course, User user) {
        if (user.getRole() == User.Role.ADMIN) return;
        if (user.getRole() == User.Role.TEACHER
                && course.getTeacher().getId().equals(user.getId())) return;
        throw new SecurityException("Access denied: you do not own this course");
    }
}
