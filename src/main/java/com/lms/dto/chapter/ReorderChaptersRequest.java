package com.lms.dto.chapter;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.List;

@Data
public class ReorderChaptersRequest {

    @NotEmpty
    @Valid
    private List<ReorderItem> items;

    @Data
    public static class ReorderItem {

        @NotNull
        private Long chapterId;

        @NotNull
        private Integer orderIndex;
    }
}
