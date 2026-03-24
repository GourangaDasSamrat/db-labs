-- add column
ALTER TABLE players
ADD COLUMN city TEXT NOT NULL DEFAULT 'Unknown';

-- remove column
ALTER TABLE players
DROP COLUMN city;