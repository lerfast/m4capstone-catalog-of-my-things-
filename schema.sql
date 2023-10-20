CREATE DATABASE "my catalogue of things"

-- Genre table
CREATE TABLE public."Genre"
(
    id integer NOT NULL,
    name "char",
    PRIMARY KEY (id)
);

-- Label table
CREATE TABLE label(
  ID SERIAL PRIMARY KEY,
  name VARCHAR(30),
  color VARCHAR(30)
);

-- Author table
CREATE TABLE author (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    first_name VARCHAR,
    last_name VARCHAR
);

-- Item table
CREATE TABLE public."Item"
(
    id integer NOT NULL,
    genre_id integer,
    author_id integer,
    label_id integer,
    published_date date,
    archived boolean,
    PRIMARY KEY (id),
    FOREIGN KEY (genre_id) REFERENCES public."Genre"
    FOREIGN KEY (author_id) REFERENCES public."Author"
    FOREIGN KEY (label_id) REFERENCES public."Label"
);

-- MusicAlbum table
CREATE TABLE public."MusicAlbum"
(
    id integer NOT NULL,
    item_id integer,
    on_spotify boolean,
    PRIMARY KEY (id),
    FOREIGN KEY (item_id) REFERENCES public."Item"
);

-- Book table
CREATE TABLE book(
  ID SERIAL PRIMARY KEY,
  publish_date DATE NOT NULL,
  archived BOOLEAN NOT NULL,
  publisher VARCHAR(30) NOT NULL,
  cover_state VARCHAR(10) NOT NULL,
  label_ID INT,
  author_ID INT,
  genre_ID INT,
  FOREIGN KEY (label_ID) REFERENCES label(ID),
  FOREIGN KEY (author_ID) REFERENCES author(ID),
  FOREIGN KEY(genre_ID) REFERENCES genre(ID)
);

-- Game table
CREATE TABLE games (
    id TEXT PRIMARY KEY, -- UUID
    name TEXT NOT NULL,
    publish_date DATE NOT NULL,
    genre_id INTEGER,
    source_id INTEGER,
    label_id INTEGER,
    author_id INTEGER,
    archived BOOLEAN DEFAULT FALSE,
    multiplayer BOOLEAN, -- Solo es relevante para juegos, podría ser NULL para otros items
    last_played_at DATE, -- Solo es relevante para juegos, podría ser NULL para otros items
    FOREIGN KEY (genre_id) REFERENCES genres (id),
    FOREIGN KEY (source_id) REFERENCES sources (id),
    FOREIGN KEY (label_id) REFERENCES labels (id),
    FOREIGN KEY (author_id) REFERENCES authors (id)
);