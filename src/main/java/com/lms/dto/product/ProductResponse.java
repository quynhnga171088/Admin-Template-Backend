package com.lms.dto.product;

import com.lms.entity.Product;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.OffsetDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProductResponse {

    private Integer id;
    private String sku;
    private String name;
    private String brand;
    private String category;
    private String categoryKey;
    private BigDecimal price;
    private Integer stock;
    private String status;
    private BigDecimal rating;
    private String warehouse;
    private LocalDate releaseDate;
    private OffsetDateTime createdAt;
    private OffsetDateTime updatedAt;

    public static ProductResponse fromEntity(Product p) {
        return ProductResponse.builder()
                .id(p.getId())
                .sku(p.getSku())
                .name(p.getName())
                .brand(p.getBrand())
                .category(p.getCategory())
                .categoryKey(p.getCategoryKey() != null ? p.getCategoryKey().name() : null)
                .price(p.getPrice())
                .stock(p.getStock())
                .status(p.getStatus() != null ? p.getStatus().getDbValue() : null)
                .rating(p.getRating())
                .warehouse(p.getWarehouse())
                .releaseDate(p.getReleaseDate())
                .createdAt(p.getCreatedAt())
                .updatedAt(p.getUpdatedAt())
                .build();
    }
}
