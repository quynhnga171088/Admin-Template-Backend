package com.lms.dto.progress;

import com.lms.entity.LessonProgress;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class LessonProgressSummary {
    private Long lessonId;
    private String lessonTitle;
    // NOTE: Lesson.Type removed in V17 migration. Type is now on Section level.
    private Integer orderIndex;
    private LessonProgress.Status status;
    private Integer videoWatchedSeconds;
    private Double videoMaxWatchedPercent;
    private LocalDateTime completedAt;
    private LocalDateTime lastAccessedAt;
}
