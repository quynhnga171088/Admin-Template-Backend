-- =====================================================================
-- V17: Restructure lessons (remove content fields) + add sections table
-- Decisions:
--   - Lesson becomes metadata only (title, description, avatar_url)
--   - Section owns all content (type, status, video_url, text_content)
--   - All existing lesson data is accepted as lost
-- =====================================================================

-- 1. Truncate all dependent data (accepted data loss)
TRUNCATE TABLE lesson_progress    RESTART IDENTITY CASCADE;
TRUNCATE TABLE lesson_attachments RESTART IDENTITY CASCADE;
TRUNCATE TABLE lessons            RESTART IDENTITY CASCADE;

-- 2. Drop old ENUM types that belonged to lessons
--    (Must drop columns first before dropping types)
ALTER TABLE lessons DROP COLUMN IF EXISTS type;
ALTER TABLE lessons DROP COLUMN IF EXISTS status;
ALTER TABLE lessons DROP COLUMN IF EXISTS text_content;
ALTER TABLE lessons DROP COLUMN IF EXISTS video_source_type;
ALTER TABLE lessons DROP COLUMN IF EXISTS video_url;
ALTER TABLE lessons DROP COLUMN IF EXISTS video_file_key;
ALTER TABLE lessons DROP COLUMN IF EXISTS video_duration_seconds;

DROP TYPE IF EXISTS lesson_type;
DROP TYPE IF EXISTS lesson_status;
DROP TYPE IF EXISTS video_source_type;

-- 3. Add avatar_url to lessons
ALTER TABLE lessons ADD COLUMN IF NOT EXISTS avatar_url VARCHAR(2000);

-- 4. Create ENUM types for sections
CREATE TYPE section_type   AS ENUM ('VIDEO', 'TEXT');
CREATE TYPE section_status AS ENUM ('DRAFT', 'PUBLISHED');

-- 5. Create sections table
CREATE TABLE sections (
    id           BIGSERIAL      PRIMARY KEY,
    lesson_id    BIGINT         NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
    title        VARCHAR(255)   NOT NULL,
    description  TEXT,
    type         section_type   NOT NULL,
    status       section_status NOT NULL DEFAULT 'PUBLISHED',
    video_url    TEXT,
    text_content TEXT,
    order_index  INTEGER        NOT NULL DEFAULT 0,
    created_at   TIMESTAMP      NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMP      NOT NULL DEFAULT NOW(),
    deleted_at   TIMESTAMP
);

-- 6. Indexes for sections
CREATE INDEX idx_sections_lesson_id    ON sections(lesson_id);
CREATE INDEX idx_sections_lesson_order ON sections(lesson_id, order_index);
CREATE INDEX idx_sections_deleted_at   ON sections(deleted_at);
