package com.lms.dto.category;

import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class UpdateCategoryRequest {

    @Size(max = 255, message = "Category name must not exceed 255 characters")
    private String categoryName;

    private String description;

    @Size(max = 50, message = "Avatar must not exceed 50 characters")
    private String avatar;
}
