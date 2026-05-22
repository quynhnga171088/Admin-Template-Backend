package com.lms.repository;

import com.lms.entity.Course;
import org.springframework.data.jpa.domain.Specification;

public class CourseSpecification {

    private CourseSpecification() {}

    /**
     * Builds a Specification for filtering courses.
     * - status: optional, exact match
     * - search: optional, case-insensitive LIKE on title and shortDescription
     * - deletedAt IS NULL is handled by @Where on the entity
     */
    public static Specification<Course> withFilters(Course.Status status, String search) {
        return Specification
                .where(hasStatus(status))
                .and(matchesSearch(search));
    }

    private static Specification<Course> hasStatus(Course.Status status) {
        if (status == null) return null;
        return (root, query, cb) -> cb.equal(root.get("status"), status);
    }

    private static Specification<Course> matchesSearch(String search) {
        if (search == null || search.isBlank()) return null;
        String pattern = "%" + search.trim().toLowerCase() + "%";
        return (root, query, cb) -> cb.or(
                cb.like(cb.lower(root.get("title")),            pattern),
                cb.like(cb.lower(root.get("shortDescription")), pattern)
        );
    }
}
