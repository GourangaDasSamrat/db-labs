-- Safely drop the table if it already exists
DROP TABLE IF EXISTS players;

-- Create the table using a functional default for the UUID
CREATE TABLE players (
    id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
    name TEXT NOT NULL,
    sport VARCHAR(255) NOT NULL,
    yearly_earnings DECIMAL(15, 2) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Indexing for performance
CREATE INDEX idx_players_sport ON players(sport);