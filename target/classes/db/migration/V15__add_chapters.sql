-- =====================================================================
-- V15: Add chapters table, migrate lessons to reference chapters
-- Note: Lesson data is not important and will be cleared.
-- =====================================================================

-- 1. Clear dependent data (data not important)
TRUNCATE TABLE lesson_progress RESTART IDENTITY CASCADE;
TRUNCATE TABLE lesson_attachments RESTART IDENTITY CASCADE;
TRUNCATE TABLE lessons RESTART IDENTITY CASCADE;

-- 2. Drop old indexes on lessons that reference course_id
DROP INDEX IF EXISTS idx_lessons_course_id;
DROP INDEX IF EXISTS idx_lessons_course_order;

-- 3. Create chapters table
CREATE TABLE chapters (
    id          BIGSERIAL    PRIMARY KEY,
    course_id   BIGINT       NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
    title       VARCHAR(255) NOT NULL,
    order_index INTEGER      NOT NULL DEFAULT 0,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    deleted_at  TIMESTAMP
);

-- 4. Swap lessons.course_id → chapter_id
ALTER TABLE lessons DROP COLUMN course_id;
ALTER TABLE lessons ADD COLUMN chapter_id BIGINT NOT NULL REFERENCES chapters(id) ON DELETE CASCADE;

-- 5. New indexes
CREATE INDEX idx_chapters_course_id    ON chapters(course_id);
CREATE INDEX idx_chapters_deleted_at   ON chapters(deleted_at);
CREATE INDEX idx_lessons_chapter_id    ON lessons(chapter_id);
CREATE INDEX idx_lessons_chapter_order ON lessons(chapter_id, order_index);
