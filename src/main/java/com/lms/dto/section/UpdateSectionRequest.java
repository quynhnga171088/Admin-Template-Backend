package com.lms.dto.section;

import com.lms.entity.Section;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class UpdateSectionRequest {

    @Size(max = 255)
    private String title;

    @Size(max = 65535)
    private String description;

    private Section.Type type;

    private Section.Status status;

    private String videoUrl;

    private String textContent;
}
