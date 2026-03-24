PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS goat_achievements;

CREATE TABLE goat_achievements (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab',abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    goat_id TEXT NOT NULL, -- No UNIQUE constraint here allows the "Many" side
    title VARCHAR(200) NOT NULL,
    year_achieved INT NOT NULL,
    category TEXT CHECK(category IN ('Olympic', 'World Championship', 'Grand Slam', 'League Title', 'Individual Award', 'Record')),
    description TEXT,
    CONSTRAINT check_year CHECK (year_achieved BETWEEN 1900 AND 2100),
    FOREIGN KEY (goat_id) REFERENCES goats (id) ON DELETE CASCADE
);

-- Indexing the foreign key is a best practice for performance in 1:M relationships
CREATE INDEX idx_achievements_goat_id ON goat_achievements (goat_id);

INSERT INTO goat_achievements (goat_id, title, year_achieved, category, description)
VALUES
    -- Lionel Messi (Multiple)
    ((SELECT id FROM goats WHERE name = 'Lionel Messi'), 'FIFA World Cup', 2022, 'World Championship', 'Led Argentina to victory in Qatar.'),
    ((SELECT id FROM goats WHERE name = 'Lionel Messi'), 'Copa América', 2021, 'World Championship', 'First major senior international trophy.'),
    ((SELECT id FROM goats WHERE name = 'Lionel Messi'), 'Ballon d''Or', 2023, 'Individual Award', 'His record-extending 8th award.'),

    -- Michael Phelps (Multiple)
    ((SELECT id FROM goats WHERE name = 'Michael Phelps'), '8 Gold Medals', 2008, 'Olympic', 'Single most successful Olympic games by any athlete.'),
    ((SELECT id FROM goats WHERE name = 'Michael Phelps'), 'World Swimmer of the Year', 2016, 'Individual Award', 'Named world swimmer of the year for the 8th time.'),

    -- Serena Williams (Tennis - Example of Grand Slams)
    ((SELECT id FROM goats WHERE name = 'Aryna Sabalenka'), 'Australian Open', 2024, 'Grand Slam', 'Successfully defended her title.'),
    ((SELECT id FROM goats WHERE name = 'Aryna Sabalenka'), 'US Open', 2024, 'Grand Slam', 'Won her first US Open title.'),

    -- Lewis Hamilton (Multiple)
    ((SELECT id FROM goats WHERE name = 'Lewis Hamilton'), '7th World Championship', 2020, 'World Championship', 'Equalled Michael Schumacher''s all-time record.'),
    ((SELECT id FROM goats WHERE name = 'Lewis Hamilton'), '100th Race Win', 2021, 'Record', 'First driver in history to reach 100 wins.'),

    -- Usain Bolt (Multiple)
    ((SELECT id FROM goats WHERE name = 'Usain Bolt'), '100m World Record', 2009, 'Record', 'Ran 9.58 seconds in Berlin.'),
    ((SELECT id FROM goats WHERE name = 'Usain Bolt'), 'Triple-Triple', 2016, 'Olympic', 'Completed the 100m, 200m, and 4x100m gold sweep in 3 consecutive Olympics.'),

    -- Tom Brady (Multiple)
    ((SELECT id FROM goats WHERE name = 'Tom Brady'), '7th Super Bowl Ring', 2021, 'League Title', 'Won with the Tampa Bay Buccaneers.'),
    ((SELECT id FROM goats WHERE name = 'Tom Brady'), 'All-time Passing Yards Record', 2021, 'Record', 'Passed Drew Brees for most yards in NFL history.'),

    -- Magnus Carlsen (Multiple)
    ((SELECT id FROM goats WHERE name = 'Magnus Carlsen'), 'World Chess Champion', 2013, 'World Championship', 'Defeated Viswanathan Anand to become champion.'),
    ((SELECT id FROM goats WHERE name = 'Magnus Carlsen'), 'Triple Crown', 2019, 'Record', 'Held Classical, Rapid, and Blitz world titles simultaneously.'),

    -- Simone Biles (Multiple)
    ((SELECT id FROM goats WHERE name = 'Simone Biles'), '4 Olympic Gold Medals', 2016, 'Olympic', 'Dominant performance at the Rio games.'),
    ((SELECT id FROM goats WHERE name = 'Simone Biles'), '6th World All-Around Title', 2023, 'World Championship', 'Most by any gymnast.'),

    -- Tiger Woods (Multiple)
    ((SELECT id FROM goats WHERE name = 'Tiger Woods'), 'The Masters', 1997, 'Grand Slam', 'Youngest ever winner at age 21.'),
    ((SELECT id FROM goats WHERE name = 'Tiger Woods'), '82nd PGA Tour Win', 2019, 'Record', 'Tied Sam Snead for most career wins.'),

    -- Muhammad Ali (Multiple)
    ((SELECT id FROM goats WHERE name = 'Muhammad Ali'), 'Olympic Gold', 1960, 'Olympic', 'Light heavyweight gold in Rome.'),
    ((SELECT id FROM goats WHERE name = 'Muhammad Ali'), 'The Rumble in the Jungle', 1974, 'World Championship', 'Defeated George Foreman to reclaim the title.');