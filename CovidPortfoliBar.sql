--select * from CovidVac$
--order by 3,4
-- select the data we are going to be using
--select location,date,total_cases,new_cases,total_deaths,population
--from CovidDeaths$
--order by 1,2
--select location,date,total_cases,total_deaths,total_deaths/total_cases*100 as DeathPrecentage
--from covidDeaths$
--where location like '%isr%'
--order by 3
--select location,date,population,total_cases,total_cases/population*100 as CovidChance
--from CovidDeaths$
--where location like '%isr%'
--order by 4
--select location,population,max(total_cases) as HighestInfectionCount,max(total_cases/population)*100 as infectionRate
--from CovidDeaths$
--group by population,location
--order by 4 
--select location,population,max(cast(total_deaths as int)) as HighestDeathCount,max((cast(total_deaths as int))/population)*100 as DeathRate
--from CovidDeaths$
--where continent is not  null
--group by population,location
--order by 3 DESC
--select continent,Sum(cast(total_deaths as int)) as HighestDeathCount,max((cast(total_deaths as int))/population)*100 as DeathRate
--from CovidDeaths$
--where continent is not  null
--group by continent 
--order by 2 DESC
--select location,max(cast(total_deaths as int)) as maxDeath from CovidDeaths$
--where continent is null
--group by location
--order by 2 DESC
--USE CTE
--with PopvsVac(continent,location,date,population,new_vaccinations,RollingPplVaccinated)
--as
--(
--select dea.continent,dea.location ,dea.date,dea.population,vac.new_vaccinations
--,SUM(convert(bigint,vac.new_vaccinations)) OVER (Partition by vac.Location order by dea.location,dea.date) as RollingPplVaccinated
--from CovidDeaths$ as dea
--join CovidVac$ as vac
--on vac.location = dea.location
--and
--vac.date = dea.date
--where dea.continent is not null
----order  by 2,3
--)
--select *,(RollingPplVaccinated/population)*100
--from PopvsVac


-- TEMP TABLE
--Drop Table	if exists #PrecentPeopleVaccinated
--Create Table #PrecentPeopleVaccinated
--(
--	Continent nvarchar(255),
--	Location nvarchar(255),
--	Date Datetime,
--	Population numeric,
--	New_vaccinations numeric,
--	RollingPplVaccinated numeric
--	)
--insert into #PrecentPeopleVaccinated
--select dea.continent,dea.location ,dea.date,dea.population,vac.new_vaccinations
--,SUM(convert(bigint,vac.new_vaccinations)) OVER (Partition by vac.Location order by dea.location,dea.date) as RollingPplVaccinated
--from CovidDeaths$ as dea
--join CovidVac$ as vac
--on vac.location = dea.location
--and
--vac.date = dea.date
--where dea.continent is not null
----order  by 2,3

--select *,(RollingPplVaccinated/population)*100
--from #PrecentPeopleVaccinated

--create view to store for data visu later
create view PrecentPopulationVaccinated as
select dea.continent,dea.location ,dea.date,dea.population,vac.new_vaccinations
,SUM(convert(bigint,vac.new_vaccinations)) OVER (Partition by vac.Location order by dea.location,dea.date) as RollingPplVaccinated
from CovidDeaths$ as dea
join CovidVac$ as vac
on vac.location = dea.location
and
vac.date = dea.date
where dea.continent is not null
--order  by 2,3

select *
from PrecentPopulationVaccinated