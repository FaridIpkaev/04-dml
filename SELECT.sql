SELECT title, duration 
FROM track 
ORDER BY duration DESC 
LIMIT 1;

SELECT title 
FROM track 
WHERE duration >= 210;

SELECT title 
FROM collection 
WHERE release_year BETWEEN 2018 AND 2020;

SELECT name 
FROM executor 
WHERE name NOT LIKE '% %';

SELECT title 
FROM track 
WHERE title ILIKE 'my %'
   OR title ILIKE '% my'
   OR title ILIKE '% my %'
   OR title ILIKE 'my'
   OR title ILIKE 'мой %'
   OR title ILIKE '% мой'
   OR title ILIKE '% мой %'
   OR title ILIKE 'мой';

SELECT Genres.name, COUNT(ExecuterGenres.executor_id) AS artist_count
FROM Genres
LEFT JOIN ExecuterGenres ON Genres.genres_id = ExecuterGenres.genres_id
GROUP BY Genres.name
ORDER BY artist_count DESC;

SELECT COUNT(Track.track_id)
FROM Track
JOIN Album ON Track.album_id = Album.album_id
WHERE Album.release_year BETWEEN 2019 AND 2020;

SELECT Album.title, 
       AVG(Track.duration)
FROM Track
JOIN Album ON Track.album_id = Album.album_id
GROUP BY Album.title
ORDER BY 
    AVG(Track.duration) DESC;

SELECT Executor.name
FROM Executor
WHERE Executor.executor_id NOT IN (
    SELECT ExecuterAlbum.executor_id
    FROM ExecuterAlbum
    JOIN Album ON ExecuterAlbum.album_id = Album.album_id
    WHERE Album.release_year = 2020);

SELECT DISTINCT Collection.title
FROM Collection
JOIN CollectionTrack ON Collection.collection_id = CollectionTrack.collection_id
JOIN Track ON CollectionTrack.track_id = Track.track_id
JOIN Album ON Track.album_id = Album.album_id
JOIN ExecuterAlbum ON Album.album_id = ExecuterAlbum.album_id
JOIN Executor ON ExecuterAlbum.executor_id = Executor.executor_id
WHERE Executor.name = 'Алсу';
    