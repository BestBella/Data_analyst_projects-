--Firstly Let check if our tables are properly Imported 
 SELECT * 
 FROM COVIDDEATH

 
 --LOCATION, DATE,TOTAL CASES,TOTAL DEATH, A DERIVED COLUMN THAT SHOWS TOTAL CASES DIVIDED BY TOTAL DEATH--
 



-- show the percentage of people who died after contaction per day
SELECT LOCATION, DATE, total_cases,total_deaths, 
(CONVERT(FLOAT,total_deaths)/CONVERT(FLOAT,total_cases))*100 AS  DEATH_PERCENTAGE
FROM COVIDDEATH
ORDER BY location, Date
WHERE LOCATION = 'NIGERIA' AND DATE = '2023-03-29'

--show the current percentage of death from contaction per country 
WITH CTE_DEATHPERCENTAGE
AS
(
SELECT
LOCATION,
DATE,
TOTAL_CASES,
TOTAL_DEATHS,
ROW_NUMBER() OVER(PARTITION BY LOCATION ORDER BY DATE DESC) AS ROWNUM
FROM 
	COVIDDEATH
WHERE CONTINENT IS NOT NULL


--ROW_NUMBER ASSIGNS A UNIQUE NUMBER TO THE ROWS
--AND THE CTE CREATES A TEMPORAL TABLE FOR A RESULT SET
)

SELECT LOCATION,
DATE,
INFECTED_PEOPLE,
TOTAL_DEATH
FROM CTE_DEATHPERCENTAGE
WHERE ROWNUM = 1




--SHOW THE COUNTRY WITH THE HIGHEST INFECTION RATE
--TO GET THE HIGHEST INFECTION RATE, GROUP YOUR COUNTRY BY LOCATION, GET THE ROLL WITH HIGHEST POPULATION & THE ROLL WITH 

NOTE"SHORTCUT TO COMMENT A LINE IS BY HIGHLIGHTING IT AND PRESS CONTROL KC"

SELECT 
LOCATION,
MAX(CONVERT(FLOAT,TOTAL_CASES)) AS INFECTED_PEOPLE,
MAX(CONVERT(FLOAT,POPULATION))
FROM COVIDDEATH
GROUP BY LOCATION

SELECT 
LOCATION,
MAX(CONVERT(FLOAT,TOTAL_CASES)) AS INFECTED_PEOPLE,
MAX(CONVERT(FLOAT,POPULATION)) AS POPULATION,
MAX(CONVERT(FLOAT, TOTAL_CASES))/MAX(CONVERT(FLOAT,POPULATION))*100 AS INFECTION_RATE
FROM COVIDDEATH
WHERE CONTINENT IS NOT NULL
GROUP BY LOCATION
ORDER BY INFECTION_RATE DESC

SELECT 
LOCATION,
MAX(CONVERT(FLOAT,TOTAL_CASES)) AS INFECTED_PEOPLE,
MAX(CONVERT(FLOAT,POPULATION)) AS POPULATION,
MAX(CONVERT(FLOAT, TOTAL_CASES))/MAX(CONVERT(FLOAT,POPULATION))*100 AS INFECTION_RATE
FROM COVIDDEATH
WHERE CONTINENT IS NULL
GROUP BY LOCATION
ORDER BY INFECTION_RATE ASC

SELECT * FROM COVIDDEATH
ORDER BY LOCATION
ORDER BY CONTINENT

Sp_Help coviddeath


-- showing the country with highest death rate per population
--GETTING THE HIGHEST DEATHRATE IS THESAME AS THAT AS THAT OF THE HIGHEST TOTAL CASES COMMAND, 
--JUST CHANGE THE TOTAL_CASES TO TOTAL_DEATH. 




-- showing the continent with the highest death count



--show the  percentage of dying from 
--contaction IN THE WORLD



--show the  vaccination to population ratio per day

--TEMP TABLE
CREATE TABLE #PercentagePopulationVaccinated
(
location varchar(50),
date datetime,
population numeric,
new_vaccinations numeric,
RollingVaccinatedPeople numeric
)

INSERT INTO #PercentagePopulationVaccinated 
SELECT dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(FLOAT,vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingVaccinatedPeople
FROM coviddeaths dea
JOIN covidvaccine vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
order by dea.location, dea.date

SELECT *, (RollingVaccinatedPeople/population)*100 PERCENTAGE_POPULATION_VACCINATED
FROM #PercentagePopulationVaccinated
ORDER BY location, date

--CREATING VIEW FOR VISUALIZATION

-- view for country with the highest infection


-- view for continent with the highest infection


-- view for the percentage of death per country


-- view for percentage vaccinated

