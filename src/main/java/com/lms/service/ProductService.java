package com.lms.service;

import com.lms.dto.product.ProductResponse;
import com.lms.entity.Product;
import com.lms.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductRepository productRepository;

    /**
     * Returns a paginated, filtered list of products.
     *
     * <p>
     * Enum parameters are converted to their DB string values before being
     * passed to the native query (which uses explicit PostgreSQL CAST).
     *
     * <p>
     * The {@code sortBy} field name is expected in camelCase (e.g. "createdAt")
     * and is automatically converted to snake_case (e.g. "created_at") to match
     * the physical column names used in the native query.
     *
     * @param search   optional keyword matched against name or brand
     * @param status   optional filter by {@link Product.ProductStatus}
     * @param category optional filter by {@link Product.ProductCategory}
     * @param pageable pagination settings — sort property must be a camelCase
     *                 entity field name
     */
    @Transactional(readOnly = true)
    public Page<ProductResponse> listProducts(String search, String status, String categoryKey, Pageable pageable) {
        String searchStr = (search != null && !search.isBlank()) ? search : null;

        // Native query uses physical column names (snake_case), so remap sort
        // properties
        Pageable nativePageable = remapSort(pageable);

        Page<Product> page = productRepository.findAllWithFilters(searchStr, status, categoryKey, nativePageable);

        return page.map(ProductResponse::fromEntity);
    }

    // ── Helpers ──────────────────────────────────────────────────────────────

    /**
     * Converts each sort property from camelCase (Java field name) to snake_case
     * (SQL column name) so the ORDER BY clause appended by Spring Data to the
     * native query uses valid PostgreSQL column names.
     *
     * <p>
     * Examples: {@code createdAt → created_at}, {@code releaseDate → release_date}.
     */
    private Pageable remapSort(Pageable pageable) {
        Sort mappedSort = Sort.by(
                pageable.getSort().stream()
                        .map(order -> order.getDirection() == Sort.Direction.ASC
                                ? Sort.Order.asc(toSnakeCase(order.getProperty()))
                                : Sort.Order.desc(toSnakeCase(order.getProperty())))
                        .toList());
        return PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), mappedSort);
    }

    /** Converts camelCase to snake_case, e.g. {@code createdAt → created_at}. */
    private String toSnakeCase(String camelCase) {
        return camelCase.replaceAll("([A-Z])", "_$1").toLowerCase();
    }
}
