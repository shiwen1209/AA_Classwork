# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
  SELECT name
  FROM countries
  WHERE gdp > (
    SELECT MAX(gdp)
    FROM countries
    WHERE continent = 'Europe'
  )
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
  SELECT continent, name, area
  FROM countries
  WHERE area IN (
    SELECT max(area)
    FROM countries
    GROUP BY continent
  ) 

  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
  select name, continent 
  from countries join (
    select cont, max(population) 
    from (
      select * 
      from countries join (
        select max(population), continent as cont 
        from countries  
        GROUP BY continent) as c2 on c2.cont = countries.continent) as temp  
        where max <=  3*population 
        group by cont 
        having count(*) =1) as temp2 on temp2.max = countries.population;
  
  SQL
end

# SELECT countries.continent, countries.name
#   FROM countries 
#   LEFT OUTER JOIN (
#   SELECT continent, name, population
#   FROM countries
#   WHERE population IN(
#     SELECT max(population)
#     FROM countries
#     GROUP BY continent))
#  AS max_pop
#   ON countries.continent = max_pop.continent
#   WHERE max_pop.population/3 > countries.population
