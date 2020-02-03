/*
Question 4
Using the fielding table, group players into three groups based on their position: 
label players with position OF as "Outfield", those with position "SS", "1B", "2B", and "3B" as "Infield", 
and those with position "P" or "C" as "Battery". 
Determine the number of putouts made by each of these three groups in 2016.


SOURCES ::
       * go to the data dictionary
	   
    
	DIMENSIONS (columns) ::
        * (people) p.playerid, namefirst, namelast
	  (fielding) - f.playerid, yearid, pos, po
          	
		  
		  *people and fielding have playerid (what we'll JOIN on)
		   
		  	start with people table, JOIN to fielding ON playerid
					 
	FACTS ::
        Use 
	people - who as a group based on position
        fielding - who, position, year and number of putouts
	
		
	
		    
	FILTERS ::      
	* using people and fielding tables from db
	CASE WHEN THEN - No ELSE
	yearid = '2016'
	
	DESCRIPTION ::
        Definitons from README 
		
		people AS p
		fielding AS f
		
		I pulled p.playerid, namefirst & namelast from the people table
			. this was an issue b'c it listed each player and position vs. grouping them together by position
		f.playerid, yearid, pos, po from the fielding table
			
		
		I specified position_group and putouts to be listed in the output
		I created CASE WHEN statements for each group using IN where I had multiple positions to select:
			"OF" = 'Outfield', 
			"SS", "1B", "2B", and "3B" = 'Infield'
			"P" or 'C' = 'Battery'
		I did a SUM(PO) aliased to account for the total of putouts for each group
*/
SELECT
	CASE WHEN pos = 'OF' THEN 'Outfield'
	WHEN pos IN ('SS', '1B', '2B', '3B') THEN 'Infield'
	WHEN pos IN ('P', 'C') THEN 'Battery'
	END AS position_group,
	SUM(po) AS putouts
FROM people as p
JOIN fielding AS f
ON p.playerid = f.playerid
WHERE yearid = '2016'
GROUP BY position_group
ORDER BY position_group;