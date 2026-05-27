package com.lms.controller;

import com.lms.dto.section.*;
import com.lms.entity.User;
import com.lms.service.SectionService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/courses/{courseId}/chapters/{chapterId}/lessons/{lessonId}/sections")
@RequiredArgsConstructor
public class SectionController {

    private final SectionService sectionService;

    /**
     * NOTE: This mapping must come BEFORE /{sectionId} so Spring MVC matches the literal
     * "reorder" segment before treating it as a path variable.
     */
    @PatchMapping("/reorder")
    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    public ResponseEntity<List<SectionResponse>> reorder(
            @PathVariable Long courseId,
            @PathVariable Long chapterId,
            @PathVariable Long lessonId,
            @Valid @RequestBody ReorderSectionsRequest req,
            Authentication authentication
    ) {
        User teacher = requireUser(authentication);
        return ResponseEntity.ok(
                sectionService.reorderSections(courseId, chapterId, lessonId, req, teacher));
    }

    /** TEACHER (own course) or ADMIN — create a section. */
    @PostMapping
    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    public ResponseEntity<SectionResponse> create(
            @PathVariable Long courseId,
            @PathVariable Long chapterId,
            @PathVariable Long lessonId,
            @Valid @RequestBody CreateSectionRequest req,
            Authentication authentication
    ) {
        User teacher = requireUser(authentication);
        return ResponseEntity.ok(
                sectionService.createSection(courseId, chapterId, lessonId, req, teacher));
    }

    /** TEACHER (own course) or ADMIN — update a section. */
    @PatchMapping("/{sectionId}")
    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    public ResponseEntity<SectionResponse> update(
            @PathVariable Long courseId,
            @PathVariable Long chapterId,
            @PathVariable Long lessonId,
            @PathVariable Long sectionId,
            @Valid @RequestBody UpdateSectionRequest req,
            Authentication authentication
    ) {
        User teacher = requireUser(authentication);
        return ResponseEntity.ok(
                sectionService.updateSection(courseId, chapterId, lessonId, sectionId, req, teacher));
    }

    /** TEACHER (own course) or ADMIN — soft delete a section. */
    @DeleteMapping("/{sectionId}")
    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    public ResponseEntity<Void> delete(
            @PathVariable Long courseId,
            @PathVariable Long chapterId,
            @PathVariable Long lessonId,
            @PathVariable Long sectionId,
            Authentication authentication
    ) {
        User teacher = requireUser(authentication);
        sectionService.softDeleteSection(courseId, chapterId, lessonId, sectionId, teacher);
        return ResponseEntity.noContent().build();
    }

    // ──────────────────────────────────────────────────────────────
    private User requireUser(Authentication auth) {
        if (auth != null && auth.getPrincipal() instanceof User u) return u;
        throw new SecurityException("Unauthorized");
    }
}
