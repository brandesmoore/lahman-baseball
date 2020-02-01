/*Question 1
  What range of years does the provided database cover?

    SOURCES ::
       * go to the data dictionary
	   *use the main tables
Batting - batting statistics
Pitching - pitching statistics
Fielding - fielding statistics
		
    DIMENSIONS ::
        * yearid
    
	FACTS ::
        min year - earliest year
		max year - latest year
    
	FILTERS ::
        * only using 3 main tables from db
    
	DESCRIPTION ::
        Assumptions from README say 1871-2016
		
		do a check from the 3 main tables as spec'd in the data dictionary
		*batting, fielding, pitching
		
		I pulled the min / max years per main table
		
    ANSWER ::
        1871-2016
		-if you have multiple questions, list out as:
		ANSWER 1:
		ANSWER 2:
*/

SELECT MIN(yearid) as min_year, MAX(yearid) AS max_year
FROM batting;

SELECT MIN(yearid) as min_year, MAX(yearid) AS max_year
FROM fielding;

SELECT MIN(yearid) as min_year, MAX(yearid) AS max_year
FROM pitching;