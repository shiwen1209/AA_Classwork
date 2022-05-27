# == Schema Information
#
# Table name: stops
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: routes
#
#  num         :string       not null, primary key
#  company     :string       not null, primary key
#  pos         :integer      not null, primary key
#  stop_id     :integer

require_relative './sqlzoo.rb'

def num_stops
  # How many stops are in the database?
  execute(<<-SQL)
    SELECT COUNT(id)
    FROM stops

  SQL
end

def craiglockhart_id
  # Find the id value for the stop 'Craiglockhart'.
  execute(<<-SQL)
    SELECT id
    FROM stops
    WHERE name = 'Craiglockhart'
  SQL
end

def lrt_stops
  # Give the id and the name for the stops on the '4' 'LRT' service.
  execute(<<-SQL)
    SELECT stop_id, name 
    FROM routes
    JOIN stops
    ON stop_id = id 
    WHERE num = '4'
  SQL
end

def connecting_routes
  # Consider the following query:
  #
  execute(<<-SQL)
  SELECT
    company,
    num,
    COUNT(*) as count
  FROM
    routes
  WHERE
    stop_id = 149 OR stop_id = 53
  GROUP BY
    company, num
  HAVING count(*) = 2
  SQL
    # The query gives the number of routes that visit either London Road
  # (149) or Craiglockhart (53). Run the query and notice the two services
  # that link these stops have a count of 2. Add a HAVING clause to restrict
  # the output to these two routes.

end

def cl_to_lr
  # Consider the query:
  # Observe that b.stop_id gives all the places you can get to from
  # Craiglockhart, without changing routes. Change the query so that it
  # shows the services from Craiglockhart to London Road.
  execute(<<-SQL)
    SELECT
    a.company,
    a.num,
    a.stop_id,
    b.stop_id
    FROM
    routes a
    JOIN
    routes b ON (a.company = b.company AND a.num = b.num)
    WHERE
    a.stop_id = 53 AND b.stop_id = 149
  SQL
end

def cl_to_lr_by_name
  # Consider the query:
  # The query shown is similar to the previous one, however by joining two
  # copies of the stops table we can refer to stops by name rather than by
  # number. Change the query so that the services between 'Craiglockhart' and
  # 'London Road' are shown.
  execute(<<-SQL)
  SELECT
    a.company,
    a.num,
    stopa.name,
    stopb.name
  FROM
    routes a
  JOIN
    routes b ON (a.company = b.company AND a.num = b.num)
  JOIN
    stops stopa ON (a.stop_id = stopa.id)
  JOIN
    stops stopb ON (b.stop_id = stopb.id)
  WHERE
    stopa.name = 'Craiglockhart' AND stopb.name = 'London Road'
  SQL
end

def haymarket_and_leith
  # Give the company and num of the services that connect stops
  # 115 and 137 ('Haymarket' and 'Leith')
  execute(<<-SQL)
    SELECT
    a.company,
    a.num
    FROM
    routes a
    JOIN
    routes b ON (a.company = b.company AND a.num = b.num)
    JOIN
    stops stopa ON (a.stop_id = stopa.id)
    JOIN
    stops stopb ON (b.stop_id = stopb.id)
    WHERE
    stopa.name = 'Haymarket' AND stopb.name = 'Leith'
    GROUP BY a.company, a.num;
  SQL
end

def craiglockhart_and_tollcross
  # Give the company and num of the services that connect stops
  # 'Craiglockhart' and 'Tollcross'
  execute(<<-SQL)
    SELECT
    a.company,
    a.num
    FROM
    routes a
    JOIN
    routes b ON (a.company = b.company AND a.num = b.num)
    JOIN
    stops stopa ON (a.stop_id = stopa.id)
    JOIN
    stops stopb ON (b.stop_id = stopb.id)
    WHERE
    stopa.name = 'Craiglockhart' AND stopb.name = 'Tollcross'
    GROUP BY a.company, a.num;

  SQL
end

def start_at_craiglockhart
  # Give a distinct list of the stops that can be reached from 'Craiglockhart'
  # by taking one bus, including 'Craiglockhart' itself. Include the stop name,
  # as well as the company and bus no. of the relevant service.
  execute(<<-SQL)
    SELECT
    stopb.name,
    b.company,
    b.num
    FROM
    routes a
    JOIN
    routes b ON (a.company = b.company AND a.num = b.num)
    JOIN
    stops stopa ON (a.stop_id = stopa.id)
    JOIN
    stops stopb ON (b.stop_id = stopb.id)
    WHERE
    stopa.name = 'Craiglockhart' 
  SQL
end

def craiglockhart_to_sighthill
  # Find the routes involving two buses that can go from Craiglockhart to
  # Sighthill. Show the bus no. and company for the first bus, the name of the
  # stop for the transfer, and the bus no. and company for the second bus.
  execute(<<-SQL)

    SELECT DISTINCT zero_num, zero_company, one_stop, two_num, two_company 
    FROM (
      SELECT
      a.num as zero_num,
      a.company as zero_company,
      stopb.name as one_stop,
      b.company as one_company,
      b.num as one_num
      FROM
      routes a
      JOIN
      routes b ON (a.company = b.company AND a.num = b.num)
      JOIN
      stops stopa ON (a.stop_id = stopa.id)
      JOIN
      stops stopb ON (b.stop_id = stopb.id)
      WHERE
      stopa.name = 'Craiglockhart') as one 
    JOIN (
      SELECT
      stopa.name as two_stop,
      a.company as two_company,
      a.num as two_num
      FROM
      routes a
      JOIN
      routes b ON (a.company = b.company AND a.num = b.num)
      JOIN
      stops stopa ON (a.stop_id = stopa.id)
      JOIN
      stops stopb ON (b.stop_id = stopb.id)
      WHERE
      stopb.name = 'Sighthill' 
      ) AS two
      ON one.one_stop = two.two_stop AND one.one_num != two.two_num

  SQL
end
