package com.lms.controller;

import com.lms.dto.lesson.*;
import com.lms.entity.User;
import com.lms.service.LessonService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/courses/{courseId}/chapters/{chapterId}/lessons")
@RequiredArgsConstructor
public class LessonController {

    private final LessonService lessonService;

    /**
     * NOTE: This mapping must come BEFORE /{lessonId} so Spring MVC matches the literal
     * "reorder" segment before treating it as a path variable.
     * TEACHER (own course) or ADMIN only.
     */
    @PatchMapping("/reorder")
    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    public ResponseEntity<List<LessonResponse>> reorder(
            @PathVariable Long courseId,
            @PathVariable Long chapterId,
            @Valid @RequestBody ReorderLessonsRequest req,
            Authentication authentication
    ) {
        User teacher = requireUser(authentication);
        return ResponseEntity.ok(lessonService.reorderLessons(courseId, chapterId, req, teacher));
    }

    /** Authenticated; student requires APPROVED enrollment. */
    @GetMapping("/{lessonId}")
    public ResponseEntity<LessonDetailResponse> detail(
            @PathVariable Long courseId,
            @PathVariable Long chapterId,
            @PathVariable Long lessonId,
            Authentication authentication
    ) {
        User currentUser = requireUser(authentication);
        return ResponseEntity.ok(lessonService.getLessonDetail(courseId, chapterId, lessonId, currentUser));
    }

    /** TEACHER (own course) or ADMIN. */
    @PostMapping
    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    public ResponseEntity<LessonDetailResponse> create(
            @PathVariable Long courseId,
            @PathVariable Long chapterId,
            @Valid @RequestBody CreateLessonRequest req,
            Authentication authentication
    ) {
        User teacher = requireUser(authentication);
        var lesson = lessonService.createLesson(courseId, chapterId, req, teacher);
        return ResponseEntity.ok(LessonDetailResponse.fromEntity(lesson, List.of()));
    }

    /** TEACHER (own course) or ADMIN. */
    @PatchMapping("/{lessonId}")
    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    public ResponseEntity<LessonResponse> update(
            @PathVariable Long courseId,
            @PathVariable Long chapterId,
            @PathVariable Long lessonId,
            @Valid @RequestBody UpdateLessonRequest req,
            Authentication authentication
    ) {
        User teacher = requireUser(authentication);
        var updated = lessonService.updateLesson(courseId, chapterId, lessonId, req, teacher);
        return ResponseEntity.ok(LessonResponse.fromEntityFull(updated));
    }

    /** TEACHER (own course) or ADMIN — soft delete. */
    @DeleteMapping("/{lessonId}")
    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    public ResponseEntity<Void> delete(
            @PathVariable Long courseId,
            @PathVariable Long chapterId,
            @PathVariable Long lessonId,
            Authentication authentication
    ) {
        User teacher = requireUser(authentication);
        lessonService.softDeleteLesson(courseId, chapterId, lessonId, teacher);
        return ResponseEntity.noContent().build();
    }

    // ──────────────────────────────────────────────────────────────
    private User requireUser(Authentication auth) {
        if (auth != null && auth.getPrincipal() instanceof User u) return u;
        throw new SecurityException("Unauthorized");
    }
}
