/*

Question 3

Find all players in the database who played at Vanderbilt University.

Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. 

Sort this list in descending order by the total salary earned. 

Which Vanderbilt player earned the most money in the majors?





SOURCES ::

       * go to the data dictionary

	   

people - who 

collegeplaying - who played for Vanderbilt (Vandy)

salaries - what's the TOTAL salary

schools - school name

    

	DIMENSIONS (columns) ::

        * (people) playerid, namefirst, namelast

	  (collegeplaying) playerid, schoolid

          (salaries) playerid, salary

	  (schools) schoolid, schoolname	

		  

		  *people, collegeplaying & salaries all have playerid

		   collegeplaying and schools have schoolid

		  	start with people table, JOIN to collegeplaying & salaries tables ON playerid

			JOIN collegeplaying to schools on schoolid

		 

	FACTS ::

        Use (people) p.playerid, namefirst, namelast - 19112 records

	(collegplaying) c.playerid, schoolid - 17350 records (there are 2000 NULL records in schoolid on the collegeplayingtable)

	(salaries) s.playerid, salary - 26428 records; there are instances of one player having multiple salaries (i.e. David Price, Pedro Alvarez) due to playing on diff teams

	(schools) sc.schoolid, schoolname - 1207 records 

		

	

		    

	FILTERS ::      

	* using people, appearances and teams tables from db

	WHERE schoolid ILIKE '%vand%'

	

	DESCRIPTION ::

        Definitons from README 

		do a check from the people, collegeplaying, salaries and schools tables 

		

		I pulled p.playerid, namefirst & namelast from the people table,

		c.schoolid from the collegeplaying table, - 7550 records after taking out NULLs

		s.salary from the salaries table

		sc.schoolname form the schools table



		I created a subquery linking the four tables through a LEFT JOIN to account for players that played for multiple teams and earned a salary on each team.

		I included a SUM of the salaries, used COALESCE to apply a value of $0 where there were NULL values in the salary table.

		CAST double precison to numeric and then money to make the column readable in dollars

		WHERE schoolid ILIKE '%vand%'

		ORDER BY salary DESC places the highest salary at the top of the records


	ANSWER: David Price is the Vanderbilt player that earned the highest total salary, $81,851,296, in the majors.

*/
SELECT namefirst, namelast, total_salary

FROM

   (SELECT DISTINCT p.playerid, namefirst, namelast,

	c.schoolid, sc.schoolname, SUM(COALESCE(s.salary / 3,0))::numeric::money AS total_salary

	FROM people AS p

	LEFT JOIN collegeplaying AS c

	ON p.playerid = c.playerid

	LEFT JOIN schools AS sc

	ON c.schoolid = sc.schoolid

    	LEFT JOIN salaries AS s

    	ON p.playerid = s.playerid

    	GROUP BY p.playerid, namefirst, namelast, c.schoolid, sc.schoolname) as subquery

WHERE schoolname ILIKE '%vand%'

ORDER BY total_salary DESC;