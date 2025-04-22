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