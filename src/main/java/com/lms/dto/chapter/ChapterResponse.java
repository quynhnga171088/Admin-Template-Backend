package com.lms.dto.chapter;

import com.lms.dto.lesson.LessonResponse;
import com.lms.entity.Chapter;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ChapterResponse {

    private Long id;
    private Long courseId;
    private String title;
    private String description;
    private String avatarUrl;
    private Integer orderIndex;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    /** Lessons nested inside this chapter */
    private List<LessonResponse> lessons;

    public static ChapterResponse fromEntity(Chapter c, List<LessonResponse> lessons) {
        return ChapterResponse.builder()
                .id(c.getId())
                .courseId(c.getCourse().getId())
                .title(c.getTitle())
                .description(c.getDescription())
                .avatarUrl(c.getAvatarUrl())
                .orderIndex(c.getOrderIndex())
                .createdAt(c.getCreatedAt())
                .updatedAt(c.getUpdatedAt())
                .lessons(lessons)
                .build();
    }

    /** Without lessons (used in create/update responses) */
    public static ChapterResponse fromEntity(Chapter c) {
        return fromEntity(c, List.of());
    }
}
