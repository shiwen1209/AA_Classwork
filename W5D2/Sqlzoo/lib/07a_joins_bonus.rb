# == Schema Information
#
# Table name: albums
#
#  asin        :string       not null, primary key
#  title       :string
#  artist      :string
#  price       :float
#  rdate       :date
#  label       :string
#  rank        :integer
#
# Table name: styles
#
# album        :string       not null
# style        :string       not null
#
# Table name: tracks
# album        :string       not null
# disk         :integer      not null
# posn         :integer      not null
# song         :string

require_relative './sqlzoo.rb'

def alison_artist
  # Select the name of the artist who recorded the song 'Alison'.
  execute(<<-SQL)
  SELECT artist
  FROM albums
  WHERE asin = (
    SELECT album
    FROM tracks
    WHERE song = 'Alison'
  )

  SQL
end

def exodus_artist
  # Select the name of the artist who recorded the song 'Exodus'.
  execute(<<-SQL)
  SELECT artist
  FROM albums
  WHERE asin = (
    SELECT album
    FROM tracks
    WHERE song = 'Exodus'
  )

  SQL
end

def blur_songs
  # Select the `song` for each `track` on the album `Blur`.
  execute(<<-SQL)
  SELECT song
  FROM tracks
  WHERE album = (
    select asin
    from albums
    where title = 'Blur'
  )
  
  SQL
end

def heart_tracks
  # For each album show the title and the total number of tracks containing
  # the word 'Heart' (albums with no such tracks need not be shown). Order first by
  # the number of such tracks, then by album title.
  execute(<<-SQL)
  SELECT title, COUNT(tracks)
  FROM albums
  JOIN tracks
  ON albums.asin = tracks.album
  WHERE song LIKE ('%Heart%')
  GROUP BY title
  ORDER BY COUNT(tracks) DESC, title
  SQL
end

def title_tracks
  # A 'title track' has a `song` that is the same as its album's `title`. Select
  # the names of all the title tracks.
  execute(<<-SQL)
  SELECT title
  FROM albums
  JOIN tracks
  ON albums.asin = tracks.album AND albums.title = tracks.song
  SQL
end

def eponymous_albums
  # An 'eponymous album' has a `title` that is the same as its recording
  # artist's name. Select the titles of all the eponymous albums.
  execute(<<-SQL)
  SELECT a.title
  FROM albums AS a
  JOIN albums as b
  ON a.asin = b.asin AND a.title = b.artist
  SQL
end

def song_title_counts
  # Select the song names that appear on more than two albums. Also select the
  # COUNT of times they show up.
  execute(<<-SQL)
  SELECT song, count(DISTINCT album)
  FROM tracks
  GROUP BY song
  HAVING count(DISTINCT album) > 2;


  SQL
end

def best_value
  # A "good value" album is one where the price per track is less than 50
  # pence. Find the good value albums - show the title, the price and the number
  # of tracks.
  execute(<<-SQL)
    SELECT title, price, count(*)
    FROM albums 
    LEFT OUTER JOIN tracks
    ON albums.asin = tracks.album
    GROUP BY asin
    HAVING albums.price / count(*) < 0.5




  SQL
end

def top_track_counts
  # Wagner's Ring cycle has an imposing 173 tracks, Bing Crosby clocks up 101
  # tracks. List the top 10 albums. Select both the album title and the track
  # count, and order by both track count and title (descending).
  execute(<<-SQL)
  SELECT title, count(tracks.song)
  FROM albums
  JOIN tracks
  ON albums.asin = tracks.album
  GROUP BY albums.asin
  ORDER BY count(tracks.song) DESC, title DESC
  LIMIT 10

  SQL
end

def rock_superstars
  # Select the artist who has recorded the most rock albums, as well as the
  # number of albums. HINT: use LIKE '%Rock%' in your query.
  execute(<<-SQL)
  SELECT 
    albums.artist, count(DISTINCT albums.asin)
  FROM 
    albums
  JOIN 
    styles
  ON albums.asin = styles.album
  WHERE 
    styles.style LIKE '%Rock%'
  GROUP BY 
    albums.artist
  ORDER BY count(DISTINCT albums.asin) DESC
  LIMIT 1
  SQL


  #  execute(<<-SQL)
  #   SELECT
  #     albums.artist,
  #     COUNT(DISTINCT albums.asin)
  #   FROM
  #     albums
  #   JOIN
  #     styles ON albums.asin = styles.album
  #   WHERE
  #     styles.style LIKE '%Rock%'
  #   GROUP BY
  #     albums.artist
  #   ORDER BY
  #     COUNT(DISTINCT albums.asin) DESC
  #   LIMIT 1
  # SQL
end

def expensive_tastes
  # Select the five styles of music with the highest average price per track,
  # along with the price per track. One or more of each aggregate functions,
  # subqueries, and joins will be required.
  #
  # HINT: Start by getting the number of tracks per album. You can do this in a
  # subquery. Next, JOIN the styles table to this result and use aggregates to
  # determine the average price per track.
  execute(<<-SQL)
  SELECT styles.style, SUM(albums.price) / SUM(album_track_counts.track_count) AS price_per_track
  FROM albums
  JOIN styles
  ON albums.asin = styles.album
  JOIN (
  SELECT albums.asin AS album_id, count(tracks.song) AS track_count
  FROM albums
  JOIN tracks
  ON albums.asin = tracks.album
  GROUP by albums.asin
  ) AS album_track_counts
  ON albums.asin = album_track_counts.album_id
  GROUP BY styles.style
  HAVING SUM(albums.price) / SUM(album_track_counts.track_count) IS NOT NULL
  ORDER BY price_per_track DESC, styles.style ASC
  LIMIT 5




  SQL
end
