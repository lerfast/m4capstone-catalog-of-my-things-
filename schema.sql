CREATE DATABASE "my catalogue of things"

-- Genre table
CREATE TABLE public."Genre"
(
    id integer NOT NULL,
    name "char",
    PRIMARY KEY (id)
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