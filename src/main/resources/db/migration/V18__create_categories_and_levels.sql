-- ============================================================
-- V18: Create categories and levels tables
-- ============================================================

CREATE TABLE categories (
    id              BIGSERIAL       PRIMARY KEY,
    category_name   VARCHAR(255)    NOT NULL,
    description     TEXT,
    created_date    TIMESTAMP       NOT NULL DEFAULT NOW(),
    deleted_date    TIMESTAMP
);

CREATE INDEX idx_categories_deleted_date ON categories (deleted_date);

-- ------------------------------------------------------------

CREATE TABLE levels (
    id              BIGSERIAL       PRIMARY KEY,
    category_id     BIGINT          NOT NULL REFERENCES categories (id),
    level_name      VARCHAR(255)    NOT NULL,
    description     TEXT,
    created_date    TIMESTAMP       NOT NULL DEFAULT NOW(),
    deleted_date    TIMESTAMP
);

CREATE INDEX idx_levels_category_id   ON levels (category_id);
CREATE INDEX idx_levels_deleted_date  ON levels (deleted_date);
