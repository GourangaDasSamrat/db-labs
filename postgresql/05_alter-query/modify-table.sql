-- change data types
ALTER TABLE goats
ALTER COLUMN nationality
SET
    DATA TYPE VARCHAR(100);

-- change default value
ALTER TABLE goats
ALTER COLUMN nationality
SET DEFAULT 'unknown';

-- change to not null
ALTER TABLE goats
ALTER COLUMN nationality
SET
    NOT NULL;

-- drop default value
ALTER TABLE goats
ALTER COLUMN nationality
DROP DEFAULT;