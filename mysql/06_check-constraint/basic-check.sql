-- 1. Drop the table if it exists
DROP TABLE IF EXISTS contacts;

-- 2. Create the table
-- Note: MySQL 8.0.13+ supports functional default values and CHECK constraints
CREATE TABLE contacts (
    id VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name VARCHAR(150) NOT NULL,
    num VARCHAR(15) UNIQUE,
    CONSTRAINT num_no_less_than_10digits CHECK (CHAR_LENGTH(num) >= 10)
);

-- 3. Insert data
INSERT INTO contacts (name, num)
VALUES ('Alyssa Healy', '1234567890');