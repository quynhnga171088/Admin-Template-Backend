package com.lms.dto.product;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import org.springframework.data.domain.Page;

import java.util.List;

/**
 * Generic pagination response wrapper.
 *
 * <p>Provides a cleaner, frontend-friendly structure compared to Spring Data's
 * raw {@link Page} object, which includes many internal fields not needed by clients.
 *
 * @param <T> type of the content items
 */
@Getter
@Builder
@AllArgsConstructor
public class PagedResponse<T> {

    /** The list of records on this page. */
    private List<T> content;

    /** Zero-based current page index. */
    private int page;

    /** Number of records per page (requested size). */
    private int size;

    /** Total number of records matching the filter (across all pages). */
    private long totalElements;

    /** Total number of pages available. */
    private int totalPages;

    /** Whether this is the first page. */
    private boolean first;

    /** Whether this is the last page. */
    private boolean last;

    /** Number of records actually returned on this page (may be less than size on last page). */
    private int numberOfElements;

    /**
     * Convenience factory method: wraps a Spring Data {@link Page} into this DTO.
     *
     * @param page Spring Data Page result
     * @param <T>  content type
     * @return a {@link PagedResponse} built from the given page
     */
    public static <T> PagedResponse<T> of(Page<T> page) {
        return PagedResponse.<T>builder()
                .content(page.getContent())
                .page(page.getNumber())
                .size(page.getSize())
                .totalElements(page.getTotalElements())
                .totalPages(page.getTotalPages())
                .first(page.isFirst())
                .last(page.isLast())
                .numberOfElements(page.getNumberOfElements())
                .build();
    }
}
