package com.lms.repository;

import com.lms.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {

    /**
     * Paginated list with optional keyword search — native query required because
     * PostgreSQL does not allow comparing custom enum types with character varying
     * without an explicit CAST.
     *
     * @param search     keyword filter matched against name, sku, and brand (null/blank → no filter)
     * @param status     case-insensitive exact filter on {@code p.status}
     *                   (null/blank → no filter). Frontend may send uppercase
     *                   values (e.g. "IN-STOCK") while the DB stores lowercase
     *                   (e.g. "in-stock"), hence the case-insensitive comparison.
     * @param categoryKey case-insensitive exact filter on {@code p.category_key}
     *                    (null/blank → no filter)
     */
    @Query(value = """
            SELECT *
            FROM api.products p
            WHERE (CAST(:search AS text) IS NULL
                   OR LOWER(p.name)  LIKE LOWER(CONCAT('%', CAST(:search AS text), '%'))
                   OR LOWER(p.sku)   LIKE LOWER(CONCAT('%', CAST(:search AS text), '%'))
                   OR LOWER(p.brand) LIKE LOWER(CONCAT('%', CAST(:search AS text), '%')))
              AND (CAST(:status AS text) IS NULL
                   OR CAST(:status AS text) = ''
                   OR LOWER(CAST(p.status AS text)) = LOWER(CAST(:status AS text)))
              AND (CAST(:categoryKey AS text) IS NULL
                   OR CAST(:categoryKey AS text) = ''
                   OR LOWER(CAST(p.category_key AS text)) = LOWER(CAST(:categoryKey AS text)))
            """,
            countQuery = """
            SELECT COUNT(*)
            FROM api.products p
            WHERE (CAST(:search AS text) IS NULL
                   OR LOWER(p.name)  LIKE LOWER(CONCAT('%', CAST(:search AS text), '%'))
                   OR LOWER(p.sku)   LIKE LOWER(CONCAT('%', CAST(:search AS text), '%'))
                   OR LOWER(p.brand) LIKE LOWER(CONCAT('%', CAST(:search AS text), '%')))
              AND (CAST(:status AS text) IS NULL
                   OR CAST(:status AS text) = ''
                   OR LOWER(CAST(p.status AS text)) = LOWER(CAST(:status AS text)))
              AND (CAST(:categoryKey AS text) IS NULL
                   OR CAST(:categoryKey AS text) = ''
                   OR LOWER(CAST(p.category_key AS text)) = LOWER(CAST(:categoryKey AS text)))
            """,
            nativeQuery = true)
    Page<Product> findAllWithFilters(
            @Param("search") String search,
            @Param("status") String status,
            @Param("categoryKey") String categoryKey,
            Pageable pageable
    );
}
