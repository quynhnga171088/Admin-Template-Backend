package com.lms.dto.chapter;

import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class UpdateChapterRequest {

    @Size(max = 255)
    private String title;
}
