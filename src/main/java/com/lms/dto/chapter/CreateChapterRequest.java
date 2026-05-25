package com.lms.dto.chapter;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class CreateChapterRequest {

    @NotBlank
    @Size(max = 255)
    private String title;
}
