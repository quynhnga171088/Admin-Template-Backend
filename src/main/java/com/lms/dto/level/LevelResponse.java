package com.lms.dto.level;

import com.lms.entity.Level;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class LevelResponse {

    private Long id;
    private String levelName;
    private String description;
    private Long categoryId;

    public static LevelResponse fromEntity(Level l) {
        return LevelResponse.builder()
                .id(l.getId())
                .levelName(l.getLevelName())
                .description(l.getDescription())
                .categoryId(l.getCategory() != null ? l.getCategory().getId() : null)
                .build();
    }
}
