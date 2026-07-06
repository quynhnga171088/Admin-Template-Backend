-- ============================================================
-- V19: Add category_id and level_id columns to courses table
-- ============================================================

ALTER TABLE courses
    ADD COLUMN category_id BIGINT REFERENCES categories (id),
    ADD COLUMN level_id    BIGINT REFERENCES levels (id);

CREATE INDEX idx_courses_category_id ON courses (category_id);
CREATE INDEX idx_courses_level_id    ON courses (level_id);
