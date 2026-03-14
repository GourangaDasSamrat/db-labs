-- add column
ALTER TABLE players
ADD COLUMN city VARCHAR(100) NOT NULL;

-- remove column
ALTER TABLE players
DROP COLUMN city;