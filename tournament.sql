-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.


CREATE TABLE players (
    id SERIAL primary key, 
    name varchar(255) NOT NULL
    );

-- table for matches
CREATE TABLE matches (
    match_id SERIAL primary key, 
    winner SERIAL references players(id), 
    loser SERIAL references players(id)
    );

CREATE View play_matches AS
Select players.id as PlayerID, matches.match_id as MatchID,
CAST (
	CASE
		When players.id = matches.winner
			Then 1
		Else 0
	END AS int) AS Won
From players Left Join matches ON (players.id = matches.winner OR players.id = matches.loser);


CREATE View stats AS
SELECT PlayerID, count(MatchID) as Games, sum(Won) as Wins
From play_matches
Group By PlayerID
Order By Wins desc;



