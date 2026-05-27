package com.lms.service;

import com.lms.dto.section.*;
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
public class SectionService {

    private final SectionRepository sectionRepository;
    private final LessonRepository  lessonRepository;
    private final CourseService     courseService;
    private final ChapterService    chapterService;
    private final LessonService     lessonService;

    // ──────────────────────────────────────────────────────────────
    // Mutation (Teacher / Admin)
    // ──────────────────────────────────────────────────────────────

    @Transactional
    public SectionResponse createSection(Long courseId, Long chapterId, Long lessonId,
                                         CreateSectionRequest req, User teacher) {
        Course course   = courseService.getCourseOrThrow(courseId);
        Chapter chapter = chapterService.getChapterOrThrow(chapterId, course);
        Lesson lesson   = lessonService.getLessonOrThrow(lessonId, chapter);
        checkTeacherWriteAccess(course, teacher);
        validateSectionRequest(req.getType(), req.getVideoUrl(), req.getTextContent());

        int nextOrder = sectionRepository.findMaxOrderIndexByLesson(lesson) + 1;

        Section section = Section.builder()
                .lesson(lesson)
                .title(req.getTitle())
                .description(req.getDescription())
                .type(req.getType())
                .status(req.getStatus() != null ? req.getStatus() : Section.Status.PUBLISHED)
                .videoUrl(req.getVideoUrl())
                .textContent(req.getTextContent())
                .orderIndex(nextOrder)
                .build();

        return SectionResponse.fromEntity(sectionRepository.save(section));
    }

    @Transactional
    public SectionResponse updateSection(Long courseId, Long chapterId, Long lessonId,
                                         Long sectionId, UpdateSectionRequest req, User teacher) {
        Course course   = courseService.getCourseOrThrow(courseId);
        Chapter chapter = chapterService.getChapterOrThrow(chapterId, course);
        Lesson lesson   = lessonService.getLessonOrThrow(lessonId, chapter);
        Section section = getSectionOrThrow(sectionId, lesson);
        checkTeacherWriteAccess(course, teacher);

        if (req.getTitle() != null)       section.setTitle(req.getTitle());
        if (req.getDescription() != null) section.setDescription(req.getDescription());
        if (req.getType() != null)        section.setType(req.getType());
        if (req.getStatus() != null)      section.setStatus(req.getStatus());
        if (req.getVideoUrl() != null)    section.setVideoUrl(req.getVideoUrl());
        if (req.getTextContent() != null) section.setTextContent(req.getTextContent());

        return SectionResponse.fromEntity(sectionRepository.save(section));
    }

    @Transactional
    public void softDeleteSection(Long courseId, Long chapterId, Long lessonId,
                                  Long sectionId, User teacher) {
        Course course   = courseService.getCourseOrThrow(courseId);
        Chapter chapter = chapterService.getChapterOrThrow(chapterId, course);
        Lesson lesson   = lessonService.getLessonOrThrow(lessonId, chapter);
        Section section = getSectionOrThrow(sectionId, lesson);
        checkTeacherWriteAccess(course, teacher);

        section.setDeletedAt(LocalDateTime.now());
        sectionRepository.save(section);
    }

    /**
     * Batch-update order_index for sections within a lesson.
     */
    @Transactional
    public List<SectionResponse> reorderSections(Long courseId, Long chapterId, Long lessonId,
                                                  ReorderSectionsRequest req, User teacher) {
        Course course   = courseService.getCourseOrThrow(courseId);
        Chapter chapter = chapterService.getChapterOrThrow(chapterId, course);
        Lesson lesson   = lessonService.getLessonOrThrow(lessonId, chapter);
        checkTeacherWriteAccess(course, teacher);

        List<Section> allSections = sectionRepository.findAllByLessonOrderByOrderIndexAsc(lesson);
        Map<Long, Section> sectionMap = allSections.stream()
                .collect(Collectors.toMap(Section::getId, Function.identity()));

        for (ReorderSectionsRequest.ReorderItem item : req.getItems()) {
            Section s = sectionMap.get(item.getSectionId());
            if (s == null) throw new ResourceNotFoundException("Section", item.getSectionId());
            s.setOrderIndex(item.getOrderIndex());
        }
        sectionRepository.saveAll(sectionMap.values());

        return sectionRepository.findAllByLessonOrderByOrderIndexAsc(lesson)
                .stream().map(SectionResponse::fromEntity).toList();
    }

    // ──────────────────────────────────────────────────────────────
    // Helpers
    // ──────────────────────────────────────────────────────────────

    public Section getSectionOrThrow(Long sectionId, Lesson lesson) {
        return sectionRepository.findByIdAndLesson(sectionId, lesson)
                .orElseThrow(() -> new ResourceNotFoundException("Section", sectionId));
    }

    private void validateSectionRequest(Section.Type type, String videoUrl, String textContent) {
        if (type == Section.Type.VIDEO && (videoUrl == null || videoUrl.isBlank())) {
            throw new IllegalArgumentException("videoUrl is required for VIDEO sections");
        }
        if (type == Section.Type.TEXT && (textContent == null || textContent.isBlank())) {
            throw new IllegalArgumentException("textContent is required for TEXT sections");
        }
    }

    private void checkTeacherWriteAccess(Course course, User user) {
        if (user.getRole() == User.Role.ADMIN) return;
        if (user.getRole() == User.Role.TEACHER
                && course.getTeacher().getId().equals(user.getId())) return;
        throw new SecurityException("Access denied: you do not own this course");
    }
}
