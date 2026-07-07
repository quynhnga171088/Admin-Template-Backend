-- ============================================================
-- V21: Add avatar column to categories table
-- ============================================================

ALTER TABLE categories
    ADD COLUMN avatar VARCHAR(50);
