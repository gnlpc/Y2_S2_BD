DROP TABLE IF EXISTS gameTeamStatistics;
DROP TABLE IF EXISTS statistics;
DROP TABLE IF EXISTS game;
DROP TABLE IF EXISTS goal;
DROP TABLE IF EXISTS red_card;
DROP TABLE IF EXISTS yellow_card;
DROP TABLE IF EXISTS event;
DROP TABLE IF EXISTS coach;
DROP TABLE IF EXISTS referee;
DROP TABLE IF EXISTS player;
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS season;
DROP TABLE IF EXISTS stadium;
DROP TABLE IF EXISTS team;
DROP TABLE IF EXISTS country;




CREATE TABLE person (
    person_id INTEGER PRIMARY KEY AUTOINCREMENT,
    person_name VARCHAR(255) NOT NULL
);

CREATE TABLE coach (
    person_id INT PRIMARY KEY,
    coach_age INT NOT NULL CHECK (coach_age > 0),
    team_id INT,
    FOREIGN KEY (person_id) REFERENCES person (person_id) ON DELETE CASCADE,
    FOREIGN KEY (team_id) REFERENCES team (team_id) ON DELETE CASCADE
);

CREATE TABLE referee (
    person_id INT PRIMARY KEY,
    referee_experience INT NOT NULL CHECK (referee_experience > 0),
    FOREIGN KEY (person_id) REFERENCES person (person_id) ON DELETE CASCADE
);

CREATE TABLE player (
    person_id INT PRIMARY KEY,
    player_position VARCHAR(255) NOT NULL,
    minutes_played INT,
    player_goals INT,
    player_yellow_cards INT,
    player_red_cards INT,
    player_team INT,
    player_country INT,
    FOREIGN KEY (person_id) REFERENCES person (person_id) ON DELETE CASCADE,
    FOREIGN KEY (player_team) REFERENCES team (team_id) ON DELETE CASCADE,
    FOREIGN KEY (player_country) REFERENCES country (country_id) ON DELETE CASCADE
);

CREATE TABLE stadium (
    stadium_id INTEGER PRIMARY KEY AUTOINCREMENT,
    stadium_name VARCHAR(255) NOT NULL UNIQUE,
    team_id INT,
    FOREIGN KEY (team_id) REFERENCES team (team_id) ON DELETE CASCADE
);

CREATE TABLE game (
    game_id INTEGER PRIMARY KEY AUTOINCREMENT,
    game_date DATE NOT NULL,
    away_team_goals INT,
    home_team_goals INT,
    game_stadium INT,
    game_season INT,
    game_referee INT,
    FOREIGN KEY (game_stadium) REFERENCES stadium (stadium_id) ON DELETE CASCADE,
    FOREIGN KEY (game_season) REFERENCES season (season_id) ON DELETE CASCADE,
    FOREIGN KEY (game_referee) REFERENCES referee (person_id) ON DELETE CASCADE
);

CREATE TABLE team (
    team_id INTEGER PRIMARY KEY AUTOINCREMENT,
    team_name VARCHAR(255) NOT NULL UNIQUE,
    team_wins INT CHECK (team_wins >= 0),
    team_draws INT CHECK (team_draws >= 0),
    team_losses INT CHECK (team_losses >= 0),
    team_points INT CHECK (team_points >= 0),
    team_country INT,
    FOREIGN KEY (team_country) REFERENCES country (country_id) ON DELETE CASCADE
);

CREATE TABLE statistics (
    statistics_id INTEGER PRIMARY KEY AUTOINCREMENT,
    home_shots INT CHECK (home_shots >= 0),
    away_shots INT CHECK (away_shots >= 0),
    home_possession INT,
    away_possession INT CHECK (home_possession + away_possession = 100),
    home_expected_goals INT CHECK (home_expected_goals >= 0),
    away_expected_goals INT CHECK (away_expected_goals >= 0)
);

CREATE TABLE gameTeamStatistics (
    game_id INT,
    home_team_id INT,
    away_team_id INT,
    statistics_id INT,
    PRIMARY KEY (game_id, home_team_id, away_team_id, statistics_id),
    FOREIGN KEY (game_id) REFERENCES game (game_id) ON DELETE CASCADE,
    FOREIGN KEY (home_team_id) REFERENCES team (team_id) ON DELETE CASCADE,
    FOREIGN KEY (away_team_id) REFERENCES team (team_id) ON DELETE CASCADE,
    FOREIGN KEY (statistics_id) REFERENCES statistics (statistics_id) ON DELETE CASCADE
);

CREATE TABLE country (
    country_id INTEGER PRIMARY KEY AUTOINCREMENT,
    country_name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE event (
    event_id INTEGER PRIMARY KEY AUTOINCREMENT,
    event_team INT,
    game_id INT,
    FOREIGN KEY (event_team) REFERENCES team (team_id) ON DELETE CASCADE,
    FOREIGN KEY (game_id) REFERENCES game (game_id) ON DELETE CASCADE
);

CREATE TABLE goal (
    event_id INT PRIMARY KEY,
    goal_minute INT CHECK (goal_minute >= 0 AND goal_minute <= 90),
    FOREIGN KEY (event_id) REFERENCES event (event_id) ON DELETE CASCADE
);

CREATE TABLE red_card (
    event_id INT PRIMARY KEY,
    red_cards_number INT CHECK (red_cards_number >= 0),
    FOREIGN KEY (event_id) REFERENCES event (event_id) ON DELETE CASCADE
);

CREATE TABLE yellow_card (
    event_id INT PRIMARY KEY,
    yellow_cards_number INT CHECK (yellow_cards_number >= 0),
    FOREIGN KEY (event_id) REFERENCES event (event_id) ON DELETE CASCADE
);

CREATE TABLE season (
    season_id INTEGER PRIMARY KEY AUTOINCREMENT,
    season_start TIMESTAMP CHECK (season_start > 1533124175),
    season_end TIMESTAMP CHECK (season_end < 1559303375)
);
