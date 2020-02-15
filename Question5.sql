/*
Question 5:


Find the average number of strikeouts per game by decade since 1920. 
Round the numbers you report to 2 decimal places.
Do the same for home runs per game. Round the numbers you report to 2 decimal places.
Do you see any trends?


SOURCES ::



       * go to the data dictionary
       * use the following table(s)
	teams - provides the team stikeouts and homeruns
	homegames - provides # of games for the year



DIMENSIONS (columns) ::

        * yearid (Year), HR (Home Runs), SO (Strikeouts)
	* games


FACTS ::
        I need to convert the yearid to a decade bucket
	I need to list the AVG(HR) = SUM(hr)/SUM(games for the year)
			and AVG(SO) = SUM(so)/SUM(games for the year)
	I need a count for the # of Games per decade from 1920-2016


FILTERS ::


        * filter by decades covering 1920-2016


DESCRIPTION ::

A CTE was created to pull the total number of strikeouts/homeruns from the teams table.
	. Use SUM(so) and SUM(hr)

A CTE was created to pull the total number of games from the homegames table.
	. Use SUM(games)

Call the yearid, avg_so, avg_hr from the team_num table
ON year = yearid (can't use USING because the columns aren't the exact title)

	.In order to convert the yearid to a decade bucket, I divided the yearid by 10
	and then multiplied by 10 to add a 0 rather than the original ending number.


ANSWER ::
 
		ANSWER 1: ROUND(SUM(tn.strikeouts) / SUM(g.games),2) as avg_so
		ANSWER 2: ROUND(SUM(tn.homeruns) / SUM(g.games),2) AS avg_hr
		ANSWER 3: (Trends) - The avg_so and avg_hr's increased as the decades increased,
					with the exception of the 1880s and the 1920s.
					Starting in the 1960s, the avg_so increased to double
					digits. Also, the more the avg strikeouts increased, the 
					more the avg homeruns increased.
*/

WITH team_nums AS
	(SELECT yearid, SUM(so) AS strikeouts, SUM(hr) AS homeruns
	FROM teams
	GROUP BY yearid),

games_per_year AS
	(SELECT year, SUM(games) AS games
	FROM homegames
	GROUP BY year)

SELECT
	tn.yearid / 10 * 10 AS decade,
	ROUND(SUM(tn.homeruns) / SUM(g.games),2) AS avg_hr,
	ROUND(SUM(tn.strikeouts) / SUM(g.games),2) as avg_so


FROM team_nums AS tn
	INNER JOIN games_per_year AS g ON g.year = tn.yearid
GROUP BY decade
ORDER BY decade;