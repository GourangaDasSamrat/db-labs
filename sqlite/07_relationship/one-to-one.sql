PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS goat_profiles;

CREATE TABLE goat_profiles (
    id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(4)) || '-' || hex(randomblob(2)) || '-4' || substr(hex(randomblob(2)),2) || '-' || substr('89ab',abs(random()) % 4 + 1, 1) || substr(hex(randomblob(2)),2) || '-' || hex(randomblob(6)))),
    goat_id TEXT NOT NULL UNIQUE, -- UNIQUE enforces the 1:1 relationship
    nickname VARCHAR(100),
    debut_year INT NOT NULL,
    career_titles INT NOT NULL DEFAULT 0,
    est_net_worth_usd BIGINT,
    biography TEXT,
    CONSTRAINT check_debut_year CHECK (debut_year >= 1900),
    CONSTRAINT check_titles_positive CHECK (career_titles >= 0),
    FOREIGN KEY (goat_id) REFERENCES goats (id) ON DELETE CASCADE
);

INSERT INTO goat_profiles (goat_id, nickname, debut_year, career_titles, est_net_worth_usd, biography)
VALUES
    ((SELECT id FROM goats WHERE name = 'Alyssa Healy'), 'Heals', 2010, 6, 5000000, 'Australian wicketkeeper-bat and elite captain.'),
    ((SELECT id FROM goats WHERE name = 'Magnus Carlsen'), 'Chess Mozart', 2004, 5, 50000000, 'Highest rated chess player in history.'),
    ((SELECT id FROM goats WHERE name = 'Lionel Messi'), 'La Pulga', 2004, 44, 600000000, 'Record 8-time Ballon d''Or winner.'),
    ((SELECT id FROM goats WHERE name = 'Michael Jordan'), 'Air Jordan', 1984, 6, 2000000000, '6-time NBA champion and Finals MVP.'),
    ((SELECT id FROM goats WHERE name = 'Aryna Sabalenka'), 'The Tiger', 2015, 14, 20000000, 'Known for her aggressive baseline play and power.'),
    ((SELECT id FROM goats WHERE name = 'Michael Phelps'), 'The Flying Fish', 2000, 28, 100000000, 'Most decorated Olympian of all time.'),
    ((SELECT id FROM goats WHERE name = 'Usain Bolt'), 'Lightning Bolt', 2004, 8, 90000000, 'World record holder in 100m and 200m sprints.'),
    ((SELECT id FROM goats WHERE name = 'Tom Brady'), 'The GOAT', 2000, 7, 300000000, 'Winningest QB in NFL history.'),
    ((SELECT id FROM goats WHERE name = 'Tiger Woods'), 'The Big Cat', 1996, 82, 800000000, '15-time major championship winner.'),
    ((SELECT id FROM goats WHERE name = 'Wayne Gretzky'), 'The Great One', 1978, 4, 250000000, 'Holds virtually every offensive record in hockey.'),
    ((SELECT id FROM goats WHERE name = 'Simone Biles'), 'GOAT', 2013, 30, 16000000, 'Most decorated gymnast in history.'),
    ((SELECT id FROM goats WHERE name = 'Lewis Hamilton'), 'Billion Dollar Man', 2007, 7, 285000000, 'Statistically the greatest F1 driver.'),
    ((SELECT id FROM goats WHERE name = 'Muhammad Ali'), 'The Greatest', 1960, 1, 50000000, 'Iconic heavyweight champion and activist.'),
    ((SELECT id FROM goats WHERE name = 'Jon Jones'), 'Bones', 2008, 15, 10000000, 'Undefeated in cage (mostly), youngest UFC champ.'),
    ((SELECT id FROM goats WHERE name = 'Kelly Slater'), 'Slats', 1990, 11, 25000000, 'Oldest and youngest world surfing champion.'),
    ((SELECT id FROM goats WHERE name = 'Lin Dan'), 'Super Dan', 2000, 66, 30000000, 'First to achieve the "Super Grand Slam".'),
    ((SELECT id FROM goats WHERE name = 'Ma Long'), 'The Dictator', 2003, 27, 20000000, 'Longest reign as world number one in table tennis.'),
    ((SELECT id FROM goats WHERE name = 'Katie Ledecky'), 'The Goat', 2012, 10, 5000000, 'Dominant distance swimmer with 21 world titles.'),
    ((SELECT id FROM goats WHERE name = 'Ronnie O''Sullivan'), 'The Rocket', 1992, 7, 15000000, 'Fastest maximum break in snooker history.'),
    ((SELECT id FROM goats WHERE name = 'Eddy Merckx'), 'The Cannibal', 1965, 5, 10000000, 'Widely considered the greatest cyclist ever.');