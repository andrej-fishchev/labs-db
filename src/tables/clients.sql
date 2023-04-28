create table clients
(
    client_id         BIGINT       NOT NULL PRIMARY KEY,
    client_steam      varchar(66)  NOT NULL UNIQUE,
    client_name       varchar(128) NOT NULL,
    client_input_time datetime(6)  NOT NULL
);