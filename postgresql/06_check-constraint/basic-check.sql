-- 1. Drop the table if it exists to ensure a clean start
DROP TABLE IF EXISTS contacts;

-- 2. Enable the pgcrypto extension to generate random UUIDs
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- 3. Create the table
CREATE TABLE
    contacts (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid (),
        name VARCHAR(150) NOT NULL,
        num VARCHAR(15) UNIQUE CHECK (length (num) >= 10)
    );

-- 4. Insert data
INSERT INTO
    contacts (name, num)
VALUES
    -- ('Alyssa Healy', '123456789'); -- its return an error
    ('Alyssa Healy', '1234567890');