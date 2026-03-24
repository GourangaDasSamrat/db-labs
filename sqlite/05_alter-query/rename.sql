-- rename a column
-- Supported in SQLite version 3.25.0+
ALTER TABLE players
RENAME COLUMN country TO nationality;

-- rename a table
ALTER TABLE players
RENAME TO wtaRank;