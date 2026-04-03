-- Safely drop the table if it already exists to ensure a fresh start
DROP TABLE IF EXISTS players;

-- Create the table with modern PostgreSQL standards
CREATE TABLE players (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    sport TEXT NOT NULL,
    yearly_earnings NUMERIC(15, 2) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Indexing for performance on common search queries
CREATE INDEX idx_players_sport ON players(sport);