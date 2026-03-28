-- Change data type and set to NOT NULL
ALTER TABLE goats
MODIFY COLUMN nationality VARCHAR(100) NOT NULL;

-- Change default value
ALTER TABLE goats
ALTER COLUMN nationality SET DEFAULT 'unknown';

-- Drop default value
ALTER TABLE goats
ALTER COLUMN nationality DROP DEFAULT;