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
public class LessonDetailResponse {

    private Long id;
    private Long chapterId;
    private String title;
    private String description;
    private String avatarUrl;
    private Integer orderIndex;
    private List<SectionResponse> sections;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public static LessonDetailResponse fromEntity(Lesson l, List<SectionResponse> sections) {
        return LessonDetailResponse.builder()
                .id(l.getId())
                .chapterId(l.getChapter().getId())
                .title(l.getTitle())
                .description(l.getDescription())
                .avatarUrl(l.getAvatarUrl())
                .orderIndex(l.getOrderIndex())
                .sections(sections)
                .createdAt(l.getCreatedAt())
                .updatedAt(l.getUpdatedAt())
                .build();
    }
}
