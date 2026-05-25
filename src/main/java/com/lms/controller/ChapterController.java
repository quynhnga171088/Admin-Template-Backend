package com.lms.controller;

import com.lms.dto.chapter.*;
import com.lms.entity.User;
import com.lms.repository.EnrollmentRepository;
import com.lms.service.ChapterService;
import com.lms.service.CourseService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/courses/{courseId}/chapters")
@RequiredArgsConstructor
public class ChapterController {

    private final ChapterService       chapterService;
    private final CourseService        courseService;
    private final EnrollmentRepository enrollmentRepository;

    /**
     * Public (preview) for unauthenticated / unenrolled users.
     * Full lesson data for enrolled students, teachers, admins.
     */
    @GetMapping
    public ResponseEntity<List<ChapterResponse>> list(
            @PathVariable Long courseId,
            Authentication authentication
    ) {
        User currentUser = extractUser(authentication);
        boolean fullAccess = hasFullAccess(courseId, currentUser);
        return ResponseEntity.ok(chapterService.listChapters(courseId, currentUser, fullAccess));
    }

    /** TEACHER (own course) or ADMIN — create a chapter. */
    @PostMapping
    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    public ResponseEntity<ChapterResponse> create(
            @PathVariable Long courseId,
            @Valid @RequestBody CreateChapterRequest req,
            Authentication authentication
    ) {
        User teacher = requireUser(authentication);
        return ResponseEntity.ok(chapterService.createChapter(courseId, req, teacher));
    }

    /**
     * NOTE: This mapping must come BEFORE /{chapterId} so Spring MVC matches
     * the literal "reorder" segment before treating it as a path variable.
     */
    @PatchMapping("/reorder")
    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    public ResponseEntity<List<ChapterResponse>> reorder(
            @PathVariable Long courseId,
            @Valid @RequestBody ReorderChaptersRequest req,
            Authentication authentication
    ) {
        User teacher = requireUser(authentication);
        return ResponseEntity.ok(chapterService.reorderChapters(courseId, req, teacher));
    }

    /** TEACHER (own course) or ADMIN — update chapter title. */
    @PatchMapping("/{chapterId}")
    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    public ResponseEntity<ChapterResponse> update(
            @PathVariable Long courseId,
            @PathVariable Long chapterId,
            @Valid @RequestBody UpdateChapterRequest req,
            Authentication authentication
    ) {
        User teacher = requireUser(authentication);
        return ResponseEntity.ok(chapterService.updateChapter(courseId, chapterId, req, teacher));
    }

    /** TEACHER (own course) or ADMIN — soft delete chapter + its lessons. */
    @DeleteMapping("/{chapterId}")
    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    public ResponseEntity<Void> delete(
            @PathVariable Long courseId,
            @PathVariable Long chapterId,
            Authentication authentication
    ) {
        User teacher = requireUser(authentication);
        chapterService.deleteChapter(courseId, chapterId, teacher);
        return ResponseEntity.noContent().build();
    }

    // ──────────────────────────────────────────────────────────────

    private User extractUser(Authentication auth) {
        if (auth != null && auth.getPrincipal() instanceof User u) return u;
        return null;
    }

    private User requireUser(Authentication auth) {
        if (auth != null && auth.getPrincipal() instanceof User u) return u;
        throw new SecurityException("Unauthorized");
    }

    private boolean hasFullAccess(Long courseId, User user) {
        if (user == null) return false;
        if (user.getRole() == User.Role.ADMIN || user.getRole() == User.Role.TEACHER) return true;
        var course = courseService.getCourseOrThrow(courseId);
        return enrollmentRepository.existsByStudentAndCourseAndStatusIn(
                user, course, List.of(com.lms.entity.Enrollment.Status.APPROVED));
    }
}
