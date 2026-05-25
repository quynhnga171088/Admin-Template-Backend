-- V16: Add description and avatar_url columns to chapters table
ALTER TABLE chapters ADD COLUMN description TEXT;
ALTER TABLE chapters ADD COLUMN avatar_url VARCHAR(2000);
