-- NOTE SQLite doesn't support 'DROP TABLE IF EXISTS' in older versions,
-- but modern versions (3.3+) handle it fine.
DROP TABLE IF EXISTS players;

-- Create the table with SQLite standards
CREATE TABLE players (
    id TEXT PRIMARY KEY DEFAULT (
        lower(hex(randomblob(4))) || '-' ||
        lower(hex(randomblob(2))) || '-4' ||
        substr(lower(hex(randomblob(2))),2) || '-' ||
        substr('89ab',abs(random()) % 4 + 1, 1) ||
        substr(lower(hex(randomblob(2))),2) || '-' ||
        lower(hex(randomblob(6)))
    ),
    name TEXT NOT NULL,
    sport TEXT NOT NULL,
    yearly_earnings REAL NOT NULL,
    created_at TEXT DEFAULT (STRFTIME('%Y-%m-%d %H:%M:%f', 'NOW'))
);

-- Indexing for performance
CREATE INDEX idx_players_sport ON players(sport);