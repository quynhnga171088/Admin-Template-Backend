package com.lms.dto.config;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class UpdateConfigRequest {

    @NotBlank
    private String value;
}
