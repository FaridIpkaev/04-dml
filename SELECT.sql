SELECT title, duration 
FROM tracks 
ORDER BY duration DESC 
LIMIT 1;

SELECT title 
FROM tracks 
WHERE duration >= 210;

SELECT title 
FROM compilations 
WHERE release_year BETWEEN 2018 AND 2020;

SELECT name 
FROM artists 
WHERE name NOT LIKE '% %';

SELECT title 
FROM tracks 
WHERE LOWER(title) LIKE '%my%' OR LOWER(title) LIKE '%мой%';

SELECT g.name AS genre, COUNT(ag.artist_id) AS artist_count
FROM genres g
LEFT JOIN artist_genre ag ON g.genre_id = ag.genre_id
GROUP BY g.name
ORDER BY artist_count DESC;

SELECT COUNT(t.track_id) AS track_count
FROM tracks t
JOIN albums a ON t.album_id = a.album_id
WHERE a.release_year BETWEEN 2019 AND 2020;

SELECT a.title AS album, 
       ROUND(AVG(t.duration), 2) AS avg_duration_sec,
       CONCAT(ROUND(AVG(t.duration)/60, 2), ' min') AS avg_duration_min
FROM albums a
JOIN tracks t ON a.album_id = t.album_id
GROUP BY a.title;

SELECT ar.name AS artist
FROM artists ar
WHERE ar.artist_id NOT IN (
    SELECT aa.artist_id
    FROM artist_album aa
    JOIN albums al ON aa.album_id = al.album_id
    WHERE al.release_year = 2020
);

SELECT DISTINCT c.title AS compilation
FROM compilations c
JOIN comp_track ct ON c.comp_id = ct.comp_id
JOIN tracks t ON ct.track_id = t.track_id
JOIN albums a ON t.album_id = a.album_id
JOIN artist_album aa ON a.album_id = aa.album_id
JOIN artists ar ON aa.artist_id = ar.artist_id
WHERE ar.name = 'Алсу';

SELECT DISTINCT c.title AS compilation
FROM compilations c
JOIN comp_track ct ON c.comp_id = ct.comp_id
JOIN tracks t ON ct.track_id = t.track_id
JOIN albums a ON t.album_id = a.album_id
JOIN artist_album aa ON a.album_id = aa.album_id
JOIN artists ar ON aa.artist_id = ar.artist_id
WHERE ar.name = 'Алсу';