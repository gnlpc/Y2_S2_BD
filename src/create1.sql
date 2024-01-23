DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS coach;
DROP TABLE IF EXISTS referee;
DROP TABLE IF EXISTS player;
DROP TABLE IF EXISTS stadium;
DROP TABLE IF EXISTS game;
DROP TABLE IF EXISTS team;
DROP TABLE IF EXISTS statistics;
DROP TABLE IF EXISTS gameTeamStatistics;
DROP TABLE IF EXISTS country;
DROP TABLE IF EXISTS event;
DROP TABLE IF EXISTS goal;
DROP TABLE IF EXISTS red_card;
DROP TABLE IF EXISTS yellow_card;
DROP TABLE IF EXISTS season;



CREATE TABLE person (
    person_id INTEGER PRIMARY KEY AUTOINCREMENT,
    person_name VARCHAR(255) NOT NULL
);

CREATE TABLE coach (
    person_id INTEGER PRIMARY KEY,
    coach_age INT,
    team_id INT,
    FOREIGN KEY (person_id) REFERENCES person (person_id),
    FOREIGN KEY (team_id) REFERENCES team (team_id)
);

CREATE TABLE referee (
    person_id INTEGER PRIMARY KEY,
    referee_experience INT,
    FOREIGN KEY (person_id) REFERENCES person (person_id)
);

CREATE TABLE player (
    person_id INTEGER PRIMARY KEY,
    player_position VARCHAR(255) NOT NULL,
    minutes_played INT,
    player_goals INT,
    player_yellow_cards INT,
    player_red_cards INT,
    player_team INT,
    player_country INT,
    FOREIGN KEY (person_id) REFERENCES person (person_id),
    FOREIGN KEY (player_team) REFERENCES team (team_id),
    FOREIGN KEY (player_country) REFERENCES country (country_id)
);

CREATE TABLE stadium (
    stadium_id INTEGER PRIMARY KEY AUTOINCREMENT,
    stadium_name VARCHAR(255) NOT NULL UNIQUE,
    team_id INT,
    FOREIGN KEY (team_id) REFERENCES team (team_id)
);

CREATE TABLE game (
    game_id INTEGER PRIMARY KEY AUTOINCREMENT,
    game_date DATE NOT NULL,
    away_team_goals INT,
    home_team_goals INT,
    game_stadium INT,
    game_season INT,
    game_referee INT,
    FOREIGN KEY (game_stadium) REFERENCES stadium (stadium_id),
    FOREIGN KEY (game_season) REFERENCES season (season_id),
    FOREIGN KEY (game_referee) REFERENCES referee (person_id)
);

CREATE TABLE team (
    team_id INTEGER PRIMARY KEY AUTOINCREMENT,
    team_name VARCHAR(255) NOT NULL UNIQUE,
    team_wins,
    team_draws,
    team_losses,
    team_points,
    team_country INT,
    FOREIGN KEY (team_country) REFERENCES country (country_id)
);

CREATE TABLE statistics (
    statistics_id INTEGER PRIMARY KEY AUTOINCREMENT,
    home_shots,
    away_shots,
    home_possession INT,
    away_possession INT,
    home_expected_goals INT ,
    away_expected_goals INT 
);

CREATE TABLE gameTeamStatistics (
    game_id INT,
    home_team_id INT,
    away_team_id INT,
    statistics_id INT,
    PRIMARY KEY (game_id, home_team_id, away_team_id, statistics_id),
    FOREIGN KEY (game_id) REFERENCES game (game_id),
    FOREIGN KEY (home_team_id) REFERENCES team (team_id),
    FOREIGN KEY (away_team_id) REFERENCES team (team_id),
    FOREIGN KEY (statistics_id) REFERENCES statistics (statistics_id)
);

CREATE TABLE country (
    country_id INTEGER PRIMARY KEY AUTOINCREMENT,
    country_name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE event (
    event_id INTEGER PRIMARY KEY AUTOINCREMENT,
    event_team INT,
    game_id INT,
    FOREIGN KEY (event_team) REFERENCES team (team_id),
    FOREIGN KEY (game_id) REFERENCES game (game_id)
);

CREATE TABLE goal (
    event_id INT PRIMARY KEY,
    goal_minute INT,
    FOREIGN KEY (event_id) REFERENCES event (event_id)
);

CREATE TABLE red_card (
    event_id INT PRIMARY KEY,
    red_cards_number INT ,
    FOREIGN KEY (event_id) REFERENCES event (event_id)
);

CREATE TABLE yellow_card (
    event_id INT PRIMARY KEY,
    yellow_cards_number INT ,
    FOREIGN KEY (event_id) REFERENCES event (event_id)
);

CREATE TABLE season (
    season_id INTEGER PRIMARY KEY AUTOINCREMENT,
    season_start TIMESTAMP ,
    season_end TIMESTAMP
);
