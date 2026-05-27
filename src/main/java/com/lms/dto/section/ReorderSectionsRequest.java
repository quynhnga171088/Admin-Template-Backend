package com.lms.dto.section;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.List;

@Data
public class ReorderSectionsRequest {

    @NotNull
    private List<ReorderItem> items;

    @Data
    public static class ReorderItem {
        @NotNull
        private Long sectionId;
        @NotNull
        private Integer orderIndex;
    }
}
