package com.lms.dto.section;

import com.lms.entity.Section;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SectionResponse {

    private Long id;
    private Long lessonId;
    private String title;
    private String description;
    private Section.Type type;
    private Section.Status status;
    private String videoUrl;
    private String textContent;
    private Integer orderIndex;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public static SectionResponse fromEntity(Section s) {
        return SectionResponse.builder()
                .id(s.getId())
                .lessonId(s.getLesson().getId())
                .title(s.getTitle())
                .description(s.getDescription())
                .type(s.getType())
                .status(s.getStatus())
                .videoUrl(s.getVideoUrl())
                .textContent(s.getTextContent())
                .orderIndex(s.getOrderIndex())
                .createdAt(s.getCreatedAt())
                .updatedAt(s.getUpdatedAt())
                .build();
    }
}
