package com.lms.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.OffsetDateTime;

@Entity
@Table(name = "products", schema = "api")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Product {

    // ── Enums ────────────────────────────────────────────────────────────────

    /**
     * Maps to PostgreSQL enum type: api.product_category
     * Uses lowercase names to match DB enum literals exactly.
     */
    public enum ProductCategory {
        camera, console, drone, headphone, keyboard,
        laptop, monitor, mouse, printer, router,
        smartphone, smartwatch, speaker, tablet, tv;
    }

    /**
     * Maps to PostgreSQL enum type: api.product_status
     * Values contain hyphens (e.g. "in-stock") → requires a custom converter.
     */
    public enum ProductStatus {
        IN_STOCK("in-stock"),
        LOW_STOCK("low-stock"),
        OUT_OF_STOCK("out-of-stock");

        private final String dbValue;

        ProductStatus(String dbValue) {
            this.dbValue = dbValue;
        }

        public String getDbValue() {
            return dbValue;
        }

        public static ProductStatus fromDbValue(String value) {
            for (ProductStatus s : values()) {
                if (s.dbValue.equals(value)) return s;
            }
            throw new IllegalArgumentException("Unknown product_status value: " + value);
        }
    }

    // ── Converters ───────────────────────────────────────────────────────────

    /**
     * Converts ProductCategory enum ↔ varchar in DB.
     * Needed because PostgreSQL JDBC reports enum columns as Types#VARCHAR,
     * which conflicts with @JdbcTypeCode(SqlTypes.NAMED_ENUM) schema validation.
     */
    @Converter(autoApply = false)
    public static class ProductCategoryConverter
            implements AttributeConverter<ProductCategory, String> {

        @Override
        public String convertToDatabaseColumn(ProductCategory attribute) {
            return attribute == null ? null : attribute.name();
        }

        @Override
        public ProductCategory convertToEntityAttribute(String dbData) {
            return dbData == null ? null : ProductCategory.valueOf(dbData);
        }
    }

    /**
     * Converts ProductStatus enum ↔ varchar in DB.
     * Needed because status values contain hyphens which are invalid Java identifiers.
     */
    @Converter(autoApply = false)
    public static class ProductStatusConverter
            implements AttributeConverter<ProductStatus, String> {

        @Override
        public String convertToDatabaseColumn(ProductStatus attribute) {
            return attribute == null ? null : attribute.getDbValue();
        }

        @Override
        public ProductStatus convertToEntityAttribute(String dbData) {
            return dbData == null ? null : ProductStatus.fromDbValue(dbData);
        }
    }

    // ── Fields ───────────────────────────────────────────────────────────────

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false, unique = true, length = 20)
    private String sku;

    @Column(nullable = false, length = 255)
    private String name;

    @Column(nullable = false, length = 100)
    private String brand;

    /** Human-readable category label (e.g. "Laptop", "Smartphone"). */
    @Column(nullable = false, length = 100)
    private String category;

    /**
     * Machine-readable category key → api.product_category enum.
     * columnDefinition = "varchar" matches what the PostgreSQL JDBC driver
     * reports during Hibernate schema validation (Types#VARCHAR).
     */
    @Convert(converter = ProductCategoryConverter.class)
    @Column(name = "category_key", nullable = false, columnDefinition = "varchar")
    private ProductCategory categoryKey;

    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal price;

    @Column(nullable = false)
    @Builder.Default
    private Integer stock = 0;

    /**
     * columnDefinition = "varchar" matches PostgreSQL JDBC reporting for enum columns.
     */
    @Convert(converter = ProductStatusConverter.class)
    @Column(nullable = false, columnDefinition = "varchar")
    @Builder.Default
    private ProductStatus status = ProductStatus.IN_STOCK;

    @Column(nullable = false, precision = 3, scale = 1)
    @Builder.Default
    private BigDecimal rating = BigDecimal.ZERO;

    @Column(nullable = false, length = 100)
    private String warehouse;

    @Column(name = "release_date", nullable = false)
    private LocalDate releaseDate;

    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at", nullable = false)
    private OffsetDateTime updatedAt;
}
