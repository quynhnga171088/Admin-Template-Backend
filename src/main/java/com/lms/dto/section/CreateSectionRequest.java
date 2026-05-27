package com.lms.dto.section;

import com.lms.entity.Section;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class CreateSectionRequest {

    @NotBlank
    @Size(max = 255)
    private String title;

    @Size(max = 65535)
    private String description;

    @NotNull
    private Section.Type type;

    private Section.Status status = Section.Status.PUBLISHED;

    /** Required when type = VIDEO */
    private String videoUrl;

    /** Required when type = TEXT */
    private String textContent;
}
