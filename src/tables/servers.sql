CREATE TABLE servers
(
    server_id          BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT,
    server_group       BIGINT       NOT NULL,
    server_ip          VARCHAR(255) NOT NULL,
    server_port        INT          NOT NULL,
    server_name        varchar(255) NOT NULL,
    server_description VARCHAR(255) NOT NULL,
    server_input_time  DATETIME(6)  NOT NULL,

    CONSTRAINT UK_serveraddress UNIQUE (server_ip, server_port),

    CONSTRAINT FK_servergroup FOREIGN KEY (server_group) REFERENCES server_groups (server_group_id)
);