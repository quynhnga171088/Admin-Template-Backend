-- ============================================================
-- V20: Make category_id and level_id NOT NULL on courses table
-- ============================================================
-- Delete dependent records for courses missing category/level.
-- Deletion order must respect FK constraints (no-cascade relations first).

-- 1. lesson_progress references courses directly (no ON DELETE CASCADE)
DELETE FROM lesson_progress
WHERE course_id IN (
    SELECT id FROM courses WHERE category_id IS NULL OR level_id IS NULL
);

-- 2. enrollments references courses (no ON DELETE CASCADE).
--    payment_proofs references enrollments ON DELETE CASCADE → auto-deleted.
DELETE FROM enrollments
WHERE course_id IN (
    SELECT id FROM courses WHERE category_id IS NULL OR level_id IS NULL
);

-- 3. Delete the courses themselves.
--    chapters  → ON DELETE CASCADE → lessons → sections / lesson_attachments (all cascade).
DELETE FROM courses
WHERE category_id IS NULL
   OR level_id IS NULL;

-- ============================================================
-- Apply NOT NULL constraints (safe now — no NULLs remain)
-- ============================================================
ALTER TABLE courses
    ALTER COLUMN category_id SET NOT NULL,
    ALTER COLUMN level_id    SET NOT NULL;
