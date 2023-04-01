SELECT *
FROM portfolioproject..coviddeath
order by 3,4

SELECT *
FROM portfolioproject..covidvaccination
order by 3,4

select Location, date, total_cases, new_cases, total_deaths, population_density
FROM portfolioproject..coviddeath
order by 1,2

select Location, date,total_deaths, population_density, (total_deaths/population_density)*100 as DeathPercentage
FROM portfolioproject..coviddeath
Where location like '%nigeria%'
order by 1,2

select Location, date,total_cases, population_density, (total_cases/population_density)*100 as DeathPercentage
FROM portfolioproject..coviddeath
Where location like '%nigeria%'
order by 1,2



select Location, population_density,MAX(total_cases) as HighestInfectionCount, MAX(total_cases/population_density)*100 as PercentPopulationInfected
FROM portfolioproject..coviddeath
Where location like '%nigeria%'
Group by location, population_density
order by 1,2

select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM portfolioproject..coviddeath
Where location like '%nigeria%'
Group by location 
order by TotalDeathCount desc



select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM portfolioproject..coviddeath
Where continent is not null
Group by continent 
order by TotalDeathCount desc

select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM portfolioproject..coviddeath
Where continent is null
Group by continent 
order by TotalDeathCount desc

select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM portfolioproject..coviddeath
Where continent is not null
Group by continent 
order by TotalDeathCount desc


with PopvsVac (continent, location, date, population, New_vaccinations, rollingpeopleVaccinated)
as
(
SELECT dea.continent, dea.location, dea.date,dea.population_density, vac.new_vaccinations
, sum(cast(vac.new_vaccinations as int)) OVER (partition by dea.location order by dea.location, dea.date) as rollingpeopleVaccinated
--, (rollingpeopleVaccinated/population)*100
from portfolioproject..coviddeath dea
Join portfolioproject..covidvaccination vac
    on dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null
--order by 2,3
)
select *, (rollingpeopleVaccinated/population)
From PopvsVac

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
rollingpeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date,dea.population_density, vac.new_vaccinations
, sum(cast(vac.new_vaccinations as int)) OVER (partition by dea.location order by dea.location, dea.date) as rollingpeopleVaccinated
--, (rollingpeopleVaccinated/population)*100
from portfolioproject..coviddeath dea
Join portfolioproject..covidvaccination vac
    on dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null
--order by 2,3

select *, (rollingpeopleVaccinated/population)
From PopvsVac


create view PercentPopulationVaccinated as
SELECT dea.continent, dea.location, dea.date,dea.population_density, vac.new_vaccinations
, sum(CONVERT(int,vac.new_vaccinations )) OVER (partition by dea.location order by dea.location, dea.date) as rollingpeopleVaccinated
--, (rollingpeopleVaccinated/population)*100
from portfolioproject..coviddeath dea
Join portfolioproject..covidvaccination vac
    on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3

select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_cases)*100 as DeathPercentage
From portfolioproject..coviddeath
where continent is not null
order by 1,2

Create View PercentPopulationVaccinated as
SELECT dea.continent, dea.location, dea.date,dea.population_density, vac.new_vaccinations
, sum(CONVERT(int,vac.new_vaccinations )) OVER (partition by dea.location order by dea.location, dea.date) as rollingpeopleVaccinated
--, (rollingpeopleVaccinated/population)*100
from portfolioproject..coviddeath dea
Join portfolioproject..covidvaccination vac
    on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3

select *
From PercentPopulationVaccinated
