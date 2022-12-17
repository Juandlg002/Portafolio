use PROYECTO1
select * from deaths
where continent is not null
order by 3,4

--select * from vaccinations
--order by 3,4

select location,date,total_cases,new_cases,total_deaths,population
from deaths
where continent is not null
order by 1,2

--Looking at total cases vs total deaths---
---This show the likelihood of dying if you get covid per country---
select location, date, total_cases, total_deaths,(total_deaths/total_cases)*100 as Death_Percentage
from deaths
where location like 'colombia'
and continent is not null
order by 1,2

---Total cases vs Population---
select location,date,total_cases,population,(total_cases/population)*100 as Populaiton_with_covid
from deaths
where location like 'colombia'
and continent is not null
order by 1,2

--countries with highest infection rate compared to population---
select location,population,MAX(total_cases) AS HighestInfectionCount,MAX((total_cases/population))*100  as Populaiton_with_covid
from deaths
where continent is not null
---where location like 'colombia'---
Group by location, population
order by Populaiton_with_covid desc


--- Shows continents with the highest death count per population---
select continent,MAX(cast(total_deaths AS int)) AS HighestDeathCount
from deaths
where continent is not null
---where location like 'colombia'---
Group by continent
order by HighestDeathCount desc


---Show countries with the highest death count per population---
select location,population,MAX(cast(total_deaths AS int)) AS HighestDeathCount
from deaths
---where location like 'colombia'---
Group by location,population
order by HighestDeathCount desc

--Global Numbers
select  sum(new_cases)as total_cases,sum(cast(new_deaths as int)) as total_deaths,sum(cast(new_deaths as int))/sum(new_cases)*100 as Deathpercentage
from deaths
where continent is not null
order by 1,2

---vaccinations

select *
from vaccinations

--join tables on location and date

	with PopvsVac (Continent,location,date,population,new_vaccinations,Rolling_vaccinated)
	as
	(
	select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	sum(CONVERT(bigint,vac.new_vaccinations)) OVER (partition by dea.location order by dea.population, dea.date) 
	as Rolling_vaccinated
	from deaths dea
	join vaccinations vac
		on dea.location = vac.location
		and dea.date = vac.date
	where dea.continent is not null
	--order by 2,3---
	)
	select *, (Rolling_vaccinated/population)*100 as TOTAL_VACCINATED
	from PopvsVac


---TEMP TABLE 

create table #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
Date datetime,
population numeric,
new_vaccinations numeric,
Rolling_vaccinated numeric,
)

insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	sum(CONVERT(bigint,vac.new_vaccinations)) OVER (partition by dea.location order by dea.population, dea.date) 
	as Rolling_vaccinated
	from deaths dea
	join vaccinations vac
		on dea.location = vac.location
		and dea.date = vac.date
	--where dea.continent is not null---
	--order by 2,3---
	
select *, (Rolling_vaccinated/population)*100 as TOTAL_VACCINATED
from #PercentPopulationVaccinated

---Create a view to store data for later visualizations
create view  percentPoupulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	sum(CONVERT(bigint,vac.new_vaccinations)) OVER (partition by dea.location order by dea.population, dea.date) 
	as Rolling_vaccinated
	from deaths dea
	join vaccinations vac
		on dea.location = vac.location
		and dea.date = vac.date
	where dea.continent is not null---
	---order by 2,3


Select *
from PercentPopulationVaccinated


