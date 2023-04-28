create table flag_groups
(
    flag_group_id          BIGINT       NOT NULL PRIMARY KEY,
    flag_group_name        varchar(255) NOT NULL UNIQUE,
    flag_group_description varchar(255) NOT NULL
);