/*
Question 2
Find the name and height of the shortest player in the database. 
How many games did he play in? 
What is the name of the team for which he played?

    SOURCES ::
       * go to the data dictionary
	   
people - who he is (first and last name, ID#), height is in inches per the dictionary
appearances - how many games did he play in
teams - team identifier #, Full name of team
    
	DIMENSIONS (columns) ::
        * (people) playerid, namefirst, namelast, height
		  (appearances) playerid, g_all (total games played by player), teamid
          (teams) teamid (team identifier #), name (full name of team)
		  
		  *people and appearances both have playerid
		  	start with people table, JOIN to appearances table ON p.playerid = a.playerid
		  *appearances and teams both have teamid
		  	JOIN appearances to teams ON a.teamid = t.teamid
		  
	
	FACTS ::
        Use p.playerid, namefirst, namelast, height
		MIN(height) is the shortest player, 
		t.name, a.teamid, a.g_all AS games_played	
		    
	FILTERS ::      
	* using people, appearances and teams tables from db
	take out NULL values in the height dimension
	
	DESCRIPTION ::
        Definitons from README 
		do a check from the people, appearances and teams tables 
		
		I pulled p.playerid, namefirst, namelast, height from the people table,
		playerid and g_all from the appearances table. g_all told me the total # of games played per player, per team.
		ORDER BY height ASC placed the Shortest player at the top of the records
    
	ANSWER ::
        ANSWER 1: Eddie Gaedel was the shortest player at 43".
		ANSWER 2: He played 1 game.
		ANSWER 3: He played for the St. Louis Browns.
*/

SELECT 
	DISTINCT p.playerid, namefirst, namelast, p.height AS height_in_inches, 
	t.name, a.teamid, a.g_all AS games_played	
FROM people as p

JOIN appearances as a
ON p.playerid = a.playerid

JOIN teams as t
ON a.teamid = t.teamid
WHERE height IS NOT NULL
GROUP BY p.playerid, t.name, a.teamid, a.g_all
ORDER BY height_in_inches asc;

