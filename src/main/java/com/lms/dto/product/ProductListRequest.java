package com.lms.dto.product;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.domain.Sort;

/**
 * Request parameters for GET /products.
 * Bound via @ModelAttribute so all fields map directly from query params.
 *
 * <pre>
 * GET /products?search=apple&page=0&size=20&sortBy=price&sortDir=asc
 * </pre>
 */
@Getter
@Setter
public class ProductListRequest {

    /** Keyword to search in name, sku, or brand. */
    private String search;

    /** Zero-based page index. Default: 0 */
    private int page = 0;

    /** Number of records per page. Default: 20 */
    private int size = 20;
    
    /** Keyword for special search: 'in-stock' | 'low-stock' | 'out-of-stock' */
    private String status;
    
    private String categoryKey;

    /**
     * Primary sort field (camelCase or snake_case).
     * Accepted values: id, sku, name, brand, price, stock, rating,
     * warehouse, releaseDate / release_date,
     * createdAt / created_at, updatedAt / updated_at.
     * Default: createdAt
     */
    private String sortBy = "createdAt";

    /**
     * Sort direction for the primary field.
     * Accepted: asc | desc (case-insensitive). Default: desc
     */
    private String sortDir = "desc";
}
