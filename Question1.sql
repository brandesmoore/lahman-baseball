/*
Question 1: What range of years does the provided database cover?

SOURCES ::
       * go to the data dictionary
	   * look in people table
	   
    
	DIMENSIONS (columns) ::
        * (people) playerid, debut, finalgame
		  	
  FACTS ::
        Each player's debut and final game is in the people table
		    
	FILTERS ::      
	* WHERE finalgame IS NOT NULL
	
	DESCRIPTION ::
        I pulled the playerid, debut and finalgame columns 
		ORDER BY finalgame DESC
		The top row told me when the final game was and the last row told me when the earliest debut was
		    
	ANSWER :: The database covers years 1871-2017
	*/

SELECT playerid, debut, finalgame
FROM people
WHERE finalgame IS NOT NULL
ORDER BY finalgame DESC;