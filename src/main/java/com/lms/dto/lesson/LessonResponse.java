package com.lms.dto.lesson;

import com.lms.dto.section.SectionResponse;
import com.lms.entity.Lesson;
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
public class LessonResponse {

    private Long id;
    private Long chapterId;
    private String title;
    private String description;
    private String avatarUrl;
    private Integer orderIndex;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    /** Sections nested inside this lesson */
    private List<SectionResponse> sections;

    public static LessonResponse fromEntity(Lesson l, List<SectionResponse> sections) {
        return LessonResponse.builder()
                .id(l.getId())
                .chapterId(l.getChapter().getId())
                .title(l.getTitle())
                .description(l.getDescription())
                .avatarUrl(l.getAvatarUrl())
                .orderIndex(l.getOrderIndex())
                .createdAt(l.getCreatedAt())
                .updatedAt(l.getUpdatedAt())
                .sections(sections)
                .build();
    }

    /** Without sections (used in create/update responses) */
    public static LessonResponse fromEntity(Lesson l) {
        return fromEntity(l, List.of());
    }
}
