create table flags
(
    flag_id          BIGINT       NOT NULL PRIMARY KEY,
    flag_signature   VARCHAR(4)   not null unique,
    flag_description VARCHAR(255) not null,
    flag_input_time  DATETIME(6)  not null
);