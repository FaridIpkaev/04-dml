CREATE table if not exists Genres (
	genres_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE table if not exists Executor (
    executor_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE table if not exists ExecuterGenres (
    executer_genres_id SERIAL PRIMARY KEY,
    executor_id INTEGER NOT NULL REFERENCES Executor(executor_id) ON DELETE CASCADE,
    genres_id INTEGER NOT NULL REFERENCES Genres(genres_id) ON DELETE CASCADE,
    CONSTRAINT unique_executor_genre UNIQUE (executor_id, genres_id)
);

CREATE TABLE if not exists Album (
    album_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INTEGER NOT NULL CHECK (release_year > 1900 AND release_year <= EXTRACT(YEAR FROM CURRENT_DATE))
);

CREATE TABLE if not exists ExecuterAlbum (
    executer_albom_id SERIAL PRIMARY KEY,
    executor_id INTEGER NOT NULL REFERENCES Executor(executor_id) ON DELETE CASCADE,
    album_id INTEGER NOT NULL REFERENCES Album(album_id) ON DELETE CASCADE,
    CONSTRAINT unique_executor_akbum UNIQUE (executor_id, album_id)
);

CREATE TABLE if not exists Track (
    track_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    duration INTEGER NOT NULL CHECK (duration > 0),
    album_id INTEGER NOT NULL REFERENCES Album(album_id) ON DELETE CASCADE,
    CONSTRAINT unique_track_in_album UNIQUE (title, album_id)   
);

CREATE TABLE if not exists Collection (
    collection_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INTEGER NOT NULL CHECK (release_year > 1900 AND release_year <= EXTRACT(YEAR FROM CURRENT_DATE))
);

CREATE TABLE if not exists CollectionTrack (
    collection_track_id SERIAL PRIMARY KEY,
    collection_id INTEGER NOT NULL REFERENCES Collection(collection_id) ON DELETE CASCADE,
    track_id INTEGER NOT NULL REFERENCES Track(track_id) ON DELETE CASCADE,
    CONSTRAINT unique_collection_track UNIQUE (collection_id, track_id)
);

INSERT INTO Executor (name) VALUES
    ('Алсу'),
    ('Тейлор Свифт'),
    ('Greta Van Fleet'),
    ('Dierks Bentley');

INSERT INTO Genres (name) VALUES
    ('Поп'),
    ('Hard Rock'),
    ('Country');
    
INSERT INTO Album (title, release_year) VALUES
    ('Фея добрых снов', 2019),
    ('Folklore', 2020),
    ('The Battle at Gardens Gate', 2021),
    ('The Mountain', 2018);

INSERT INTO Track (title, duration, album_id) VALUES
    ('Спи моя радость усни', 190, 1),
    ('Доченьки мои', 225, 1),
    ('Mirrorball', 208, 2),
    ('August', 240, 2),
    ('Heat Above', 342, 3),
    ('Broken Bells', 350, 3),
    ('The Mountain', 284, 4),
    ('My Religion', 185, 4);

INSERT INTO Collection (title, release_year) VALUES
    ('Best Pop Hits 2020', 2019),
    ('Alternative Mix', 2020),
    ('Rock Classics', 2021),
    ('The best country', 2018);

INSERT INTO ExecuterGenres (executor_id, genres_id) VALUES
    (1, 1),
    (2, 1),
    (3, 3),
    (4, 3);

INSERT INTO executeralbum (executor_id, album_id) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4);

INSERT INTO collectiontrack (collection_id, track_id) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4);

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
    