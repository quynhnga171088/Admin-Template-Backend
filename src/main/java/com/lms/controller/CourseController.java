package com.lms.controller;

import com.lms.dto.course.*;
import com.lms.entity.Course;
import com.lms.entity.User;
import com.lms.service.CourseService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/courses")
@RequiredArgsConstructor
public class CourseController {

    private final CourseService courseService;

    /** Public. Returns paginated list. Authenticated STUDENTs also get enrollmentStatus per course. */
    @GetMapping
    public ResponseEntity<Page<CourseResponse>> list(
            @RequestParam(required = false) Course.Status status,
            @RequestParam(required = false) String search,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(defaultValue = "createdAt") String sortBy,
            Authentication authentication
    ) {
        log.debug("[list] status={}, search='{}', page={}, size={}, sortBy={}, caller={}",
                status, search, page, size, sortBy,
                authentication != null ? authentication.getName() : "anonymous");
        try {
            Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, sortBy));
            User currentUser = extractUser(authentication);
            Page<CourseResponse> result = courseService.listCourses(status, search, currentUser, pageable);
            log.debug("[list] returned {} / {} courses", result.getNumberOfElements(), result.getTotalElements());
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            log.error("[list] Exception — status={}, search='{}', page={}, size={}, sortBy={}: {} — {}",
                    status, search, page, size, sortBy,
                    e.getClass().getSimpleName(), e.getMessage(), e);
            throw e;
        }
    }

    /** Public. Detail with lesson list (access-level aware). Accepts both numeric ID and slug. */
    @GetMapping("/{slugOrId}")
    public ResponseEntity<CourseDetailResponse> detail(
            @PathVariable String slugOrId,
            Authentication authentication
    ) {
        User currentUser = extractUser(authentication);
        return ResponseEntity.ok(courseService.getCourseDetail(slugOrId, currentUser));
    }

    /** TEACHER or ADMIN can create courses. */
    @PostMapping
    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    public ResponseEntity<CourseResponse> create(
            @Valid @RequestBody CreateCourseRequest req,
            Authentication authentication
    ) {
        User creator = requireUser(authentication);
        Course course = courseService.createCourse(req, creator);
        long lessonCount = 0;
        return ResponseEntity.ok(CourseResponse.fromEntity(course, lessonCount, null));
    }

    /** TEACHER (own course) or ADMIN (any course). */
    @PatchMapping("/{id}")
    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    public ResponseEntity<CourseResponse> update(
            @PathVariable Long id,
            @Valid @RequestBody UpdateCourseRequest req,
            Authentication authentication
    ) {
        User currentUser = requireUser(authentication);
        Course updated = courseService.updateCourse(id, req, currentUser);
        long lessonCount = 0;
        return ResponseEntity.ok(CourseResponse.fromEntity(updated, lessonCount, null));
    }

    /** ADMIN only. Soft-delete (DRAFT, no enrollments). */
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Void> delete(@PathVariable Long id, Authentication authentication) {
        User admin = requireUser(authentication);
        courseService.softDeleteCourse(id, admin);
        return ResponseEntity.noContent().build();
    }

    /** TEACHER (own course) or ADMIN — list enrolled students with progress %. */
    @GetMapping("/{id}/students")
    @PreAuthorize("hasAnyRole('TEACHER','ADMIN')")
    public ResponseEntity<List<StudentWithProgressResponse>> students(
            @PathVariable Long id,
            Authentication authentication
    ) {
        User currentUser = requireUser(authentication);
        return ResponseEntity.ok(courseService.getStudentsWithProgress(id, currentUser));
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
}
