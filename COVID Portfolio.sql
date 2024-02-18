--Using alter table to ensure correct data type

USE CovidPortfolioProject
ALTER TABLE dbo.CovidDeathtoll
ALTER COLUMN total_cases float;

ALTER TABLE dbo.CovidDeathtoll
ALTER COLUMN total_deaths float;

ALTER TABLE dbo.CovidDeathtoll
ALTER COLUMN new_cases float;

--Analyzing Total Cases vs Total Deaths to calculate Death % in my country (El Salvador)
SELECT location, date, total_cases, total_deaths, (total_deaths/NULLIF(total_cases,0))*100 as Death_Percentage
FROM CovidPortfolioProject..CovidDeathtoll
WHERE iso_code='SLV'
ORDER BY 3

--Analyzing Total Cases vs Population in my country (El Salvador)
SELECT location, date, population, total_cases,(total_cases/population)*100 as Infection_Percentage
FROM CovidPortfolioProject..CovidDeathtoll
WHERE iso_code='SLV'
ORDER BY 4 desc
--Based on the data, as of 2/4/2024, El Salvador reached an infection percentage of ~3.19%

--Looking at countries with highest infection rate
SELECT location, population, MAX(total_cases) as HighestofInfections, MAX(total_cases/population)*100 as Infection_Percentage
FROM CovidPortfolioProject..CovidDeathtoll
WHERE continent is not NULL
Group by location, population
ORDER BY Infection_Percentage desc

--Showing countries with highest death count
SELECT location, MAX(total_deaths) as TotalDeathCount
FROM CovidPortfolioProject..CovidDeathtoll
WHERE continent <> ''
GROUP BY location
ORDER BY TotalDeathCount desc
--Top 5 countries are: United States, Brazil, India, Russia & Mexico

--Break down by continent
SELECT location, MAX(total_deaths) as TotalDeathCount
FROM CovidPortfolioProject..CovidDeathtoll
WHERE continent = '' AND location NOT LIKE '%income%'
GROUP BY location
ORDER BY TotalDeathCount desc
--While taking a closer look at the data, I noticed that there were some errors regarding the locations, that's why I used the: WHERE continent = '' AND location NOT LIKE '%income%' part

--SUM of total cases and deaths in the world
SELECT SUM(cast(new_cases as bigint)) as total_cases, SUM(cast(new_deaths as bigint)) as total_deaths, (SUM(cast(new_deaths as float))/NULLIF(SUM(cast(new_cases as float)),0))*100 as death_percentage
from CovidPortfolioProject..CovidDeathtoll
WHERE continent = '' AND location NOT LIKE '%income%'
order by 1,2

--Joining tables to analyze total population vs vaccinations
SELECT death.continent, death.location, death.date, death.population, vacc.new_vaccinations, SUM(cast(vacc.new_vaccinations as bigint)) OVER (Partition by death.location ORDER BY death.location, death.date) as RollingPeopleVaccinated
from CovidPortfolioProject..CovidDeathtoll death
JOIN CovidPortfolioProject..CovidVaccines vacc
	ON death.location = vacc.location
	and death.date = vacc.date
where death.location not like '%income%'
order by 2,3

--Creating views for visualizations

CREATE VIEW DeathCountbyLocation as
SELECT location, MAX(total_deaths) as TotalDeathCount
FROM CovidPortfolioProject..CovidDeathtoll
WHERE continent = '' AND location NOT LIKE '%income%'
GROUP BY location
