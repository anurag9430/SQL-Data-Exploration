
--Total Cases vs Total deaths in india---------
Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From covid_deths_csv
Where location like 'india'
and continent is not null 
order by 1,2

 -------Total Cases vs Population in india-------
Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From covid_deths_csv
Where location like 'india'
order by 1,2


--Deaths who goes in icu-----
UPDATE [covid_deths_csv]
SET [icu_patients]=0
WHERE [icu_patients] IS NULL;

select location , (max(icu_patients) / max(total_deaths)) *100 as ICU_DeathPercentege
from covid_deths_csv
group by location
order by ICU_DeathPercentege desc


-- Countries with Highest Infection Rate compared to Population
Select location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From covid_deths_csv
--Where location like '%states%'
Group by Location , population
order by PercentPopulationInfected desc


-- Countries with Highest Death Count per Population---------
Select Location, MAX(total_deaths) as TotalDeathCount
From covid_deths_csv
Where continent is not null 
Group by Location
order by TotalDeathCount desc


-------Total Death per continent---------------
Select continent, MAX(total_deaths) as TotalDeathCount
From covid_deths_csv
Where continent is not null 
Group by continent
order by TotalDeathCount desc

-----------Global death%--------------------
Select location , SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From covid_deths_csv
where continent is not null 
Group By location
order by location 

--Creating Temp Table------
DROP Table if exists #PercentDeathGlobal
Create Table #PercentDeathGlobal
(
Location nvarchar(255),
total_cases numeric,
total_deaths numeric,
DeathPercentage numeric
)
Insert into #PercentDeathGlobal
Select location , SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From covid_deths_csv
where continent is not null 
Group By location
order by location



--Creating view  to store data ---------
Create view  DeathGloba as
Select location , SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From covid_deths_csv
--Where location like '%states%'
where continent is not null 
Group By location










