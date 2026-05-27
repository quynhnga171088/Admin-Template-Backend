package com.lms.dto.lesson;

import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class UpdateLessonRequest {

    @Size(max = 255)
    private String title;

    @Size(max = 65535)
    private String description;

    @Size(max = 2000)
    private String avatarUrl;
}
