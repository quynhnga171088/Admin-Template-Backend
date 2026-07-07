package com.lms.dto.category;

import com.lms.entity.Category;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CategoryResponse {

    private Long id;
    private String categoryName;
    private String description;
    private String avatar;

    public static CategoryResponse fromEntity(Category c) {
        return CategoryResponse.builder()
                .id(c.getId())
                .categoryName(c.getCategoryName())
                .description(c.getDescription())
                .avatar(c.getAvatar())
                .build();
    }
}

