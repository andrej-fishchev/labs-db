create table server_groups
(
    server_group_id          BIGINT       NOT NULL PRIMARY KEY,
    server_group_name        VARCHAR(255) NOT NULL,
    server_group_description VARCHAR(255) NOT NULL,
    server_group_status      INT          NOT NULL
);