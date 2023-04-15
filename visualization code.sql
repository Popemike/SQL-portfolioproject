Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..coviddeath
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From PortfolioProject..coviddeath
--Where location like '%states%'
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc


Select Location, population_density, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population_density))*100 as PercentPopulationInfected
From PortfolioProject..coviddeath
--Where location like '%states%'
Group by Location, population_density
order by PercentPopulationInfected desc


Select Location, population_density,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population_density))*100 as PercentPopulationInfected
From PortfolioProject..coviddeath
--Where location like '%states%'
Group by Location, population_density, date
order by PercentPopulationInfected desc

