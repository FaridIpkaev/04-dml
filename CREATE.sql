CREATE TABLE Genres (
    genres_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Executor (
    executor_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE ExecuterGenres (
    executer_genres_id SERIAL PRIMARY KEY,
    executor_id INTEGER NOT NULL REFERENCES Executor(executor_id) ON DELETE CASCADE,
    genres_id INTEGER NOT NULL REFERENCES Genres(genres_id) ON DELETE CASCADE,
    CONSTRAINT unique_executor_genre UNIQUE (executor_id, genres_id)
);

CREATE TABLE Album (
    album_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INTEGER NOT NULL CHECK (release_year > 1900 AND release_year <= EXTRACT(YEAR FROM CURRENT_DATE))
);

CREATE TABLE ExecuterAlbum (
    executer_albom_id SERIAL PRIMARY KEY,
    executor_id INTEGER NOT NULL REFERENCES Executor(executor_id) ON DELETE CASCADE,
    album_id INTEGER NOT NULL REFERENCES Album(album_id) ON DELETE CASCADE,
    CONSTRAINT unique_executor_akbum UNIQUE (executor_id, album_id)
);

CREATE TABLE Track (
    track_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    duration INTEGER NOT NULL CHECK (duration > 0),
    album_id INTEGER NOT NULL REFERENCES Album(album_id) ON DELETE CASCADE,
    CONSTRAINT unique_track_in_album UNIQUE (title, album_id)   
);

CREATE TABLE Collection (
    collection_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INTEGER NOT NULL CHECK (release_year > 1900 AND release_year <= EXTRACT(YEAR FROM CURRENT_DATE))
);

CREATE TABLE CollectionTrack (
    collection_track_id SERIAL PRIMARY KEY,
    collection_id INTEGER NOT NULL REFERENCES Collection(collection_id) ON DELETE CASCADE,
    track_id INTEGER NOT NULL REFERENCES Track(track_id) ON DELETE CASCADE,
    CONSTRAINT unique_collection_track UNIQUE (collection_id, track_id)
);
