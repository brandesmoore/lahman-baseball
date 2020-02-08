/*
Question 8:

Using the attendance figures from the homegames table, 
find the teams and parks which had the top 5 average attendance per game in 2016 
(where average attendance is defined as total attendance divided by number of games). 
Only consider parks where there were at least 10 games played. 
Report the park name, team name, and average attendance. 
Repeat for the lowest 5 average attendance.



SOURCES ::
       *go to the data dictionary
       *use the following table(s)
	homegames - attendance and number of games
	parks - name of park
	teamsfranchises - team name
	  
	
    
DIMENSIONS (columns) ::
    * homegames - h.year, h.park (the park ID), h.attendance (total att), h.games (total games)
	* parks - p.park (the park ID), p.park_name (what park the team plays in)
	* teamsfranchises - t.franchname (team name)
	  

FACTS ::
I need to pull the park ID, park_name, attendance and games
I need to pull the team_name 
	

FILTERS ::
        * WHERE h.year = '2016' AND h.games > 10

DESCRIPTION ::

I started with the homegames table to pull the year, attendance, games and avg_attendance
	. avg_attendance = SUM(h.attendance) / SUM(h.games) AS avg_attendance
	. called for the year, franchname (team name), park name and avg_attendance
		h.year, t.franchname, p.park_name, SUM(h.attendance) / SUM(h.games) AS avg_attendance


INNER JOIN to parks AS P
ON h.park = p.park (to get the park id)

INNER JOIN teamsfranchises AS t
ON h.team = t.franchid (to get the team name)


ANSWER ::
    
ANSWER 1 : The top 5 teams and parks with the highest avg_attendance in 2016 are:
		. Toronto Blue Jays - Rogers Centre
		. Boston Red Sox - Fenway Park
		. Texas Rangers - Rnagers Ballpark in Arlington
		. Colorado Rockies - Coors Field
		. Detroit Tigers - Comerica Park
*/
SELECT p.park_name, t.franchname AS team_name, sum(h.attendance) / sum(h.games) AS avg_attendance
FROM homegames AS h

inner JOIN parks AS p
ON h.park = p.park

inner JOIN teamsfranchises AS t 
ON h.team = t.franchid

WHERE h.year = 2016 and h.games > 10 
GROUP BY p.park, p.park_name, t.franchname
ORDER BY avg_attendance DESC;



/*
ANSWER 2 : The lowest 5 teams and parks with the lowest avg_attendance in 2016 are:
		. Oakland Athletics - Oakland-Alameda County Coliseum
		. Cleveland Indians - Progressive Field
		. Cincinnati Reds - Great American Ballpark
		. Philadelphis Phillies - Citizens Bank Park
		. Minnesota Twins - Target Field
*/
SELECT p.park_name, t.franchname AS team_name, sum(h.attendance) / sum(h.games) AS avg_attendance
FROM homegames AS h

inner JOIN parks AS p
ON h.park = p.park

inner JOIN teamsfranchises AS t 
ON h.team = t.franchid

WHERE h.year = 2016 and h.games > 10 
GROUP BY p.park, p.park_name, t.franchname
ORDER BY avg_attendance;