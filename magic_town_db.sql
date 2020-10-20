-- Let's drop tables if they already exists
DROP TABLE IF EXISTS 
   states_db,
   gdp_db,
   weather_db,
   magic_town_db
CASCADE;

-- Let's create the tables


CREATE TABLE states_db (
	"abr_state" VARCHAR   NOT NULL,
    "state" VARCHAR NOT NULL,
    "id_state" INT  PRIMARY KEY   
);

CREATE TABLE weather_db (
	"id_state" INT NOT NULL,
	"state_w" VARCHAR   NOT NULL,
    "year" INT   NOT NULL,
    "precipitation" NUMERIC   NOT NULL,
    "average_temperature" NUMERIC   NOT NULL,
    "minimum_temperature" NUMERIC   NOT NULL,
    "maximum_temperature" NUMERIC   NOT NULL,
	PRIMARY KEY (id_state, year),
	FOREIGN KEY (id_state) REFERENCES states_db (id_state)
);

CREATE TABLE magic_town_db (
	"id" INT  NOT NULL,
	"town" VARCHAR NOT NULL,
	"state_mt" VARCHAR   NOT NULL,
    "year" INT   NOT NULL,
	"id_state" INT NOT NULL,
	FOREIGN KEY (id_state, year) REFERENCES weather_db (id_state, year),
	FOREIGN KEY (id_state) REFERENCES states_db (id_state)
	
);

CREATE TABLE gdp_db ( 			
    "id_state" INT   NOT NULL,
    "states" VARCHAR   NOT NULL,
    "tourism_gdp" NUMERIC   NOT NULL,
    "year" INT   NOT NULL,
	FOREIGN KEY (id_state, year) REFERENCES weather_db(id_state, year),
	FOREIGN KEY (id_state) REFERENCES states_db (id_state)
);

--LET'S CHECK THE DB
SELECT * FROM states_db;
SELECT * FROM weather_db;
SELECT * FROM magic_town_db;
SELECT * FROM gdp_db;

--LET'S MAKE SOME QUERRIES
--JOIN STATE DB WITH WEATHER DB
SELECT
	T1.id_state,
	T1.state,
	T2.id_state,
	T2.town,
	T2.year,
	T3.id_state,
	T3.tourism_gdp,
	T3.year
FROM magic_town_db as T2
INNER JOIN states_db as T1 on T2.id_state = T1.id_state
--INNER JOIN gdp_db as T3 on T2.year = T3.year
INNER JOIN gdp_db as T3 on T2.id_state = T3.id_state;





