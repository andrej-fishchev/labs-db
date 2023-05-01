CREATE OR REPLACE TABLE server_groups
(
    group_id          BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT,
    group_name        VARCHAR(255) NOT NULL,
    group_description VARCHAR(255) NOT NULL,
    group_status      INT          NOT NULL DEFAULT 0,

    CONSTRAINT ukGroupName UNIQUE (group_name)
);

CREATE OR REPLACE TABLE servers
(
    server_id          BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT,
    server_group       BIGINT       NULL,
    server_ip          VARCHAR(64)  NOT NULL,
    server_port        INT          NOT NULL,
    server_name        VARCHAR(255) NOT NULL,
    server_description VARCHAR(255) NOT NULL,
    server_status      INT          NOT NULL DEFAULT 0,
    server_input_time  DATETIME(6)  NOT NULL,

    CONSTRAINT ukServerAddress
        UNIQUE (server_ip, server_port),

    CONSTRAINT ukServerName UNIQUE (server_name),

    CONSTRAINT FK4v2bhhf69bd6yjw9qaosnic1w
        FOREIGN KEY (server_group) REFERENCES server_groups (group_id)
            ON UPDATE CASCADE
            ON DELETE SET NULL
);

CREATE OR REPLACE TABLE clients
(
    client_id         BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT,
    client_steam      VARCHAR(255) NOT NULL,
    client_name       VARCHAR(255) NOT NULL,
    client_input_time DATETIME(6)  NOT NULL,

    CONSTRAINT ukClientSteam
        UNIQUE (client_steam)
);

CREATE OR REPLACE TABLE client_activities
(
    activity_id           BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT,
    activity_owner        BIGINT       NOT NULL,
    activity_server       BIGINT       NOT NULL,
    activity_duration     INT          NOT NULL,
    activity_input_time   DATETIME(6)  NOT NULL,

    CONSTRAINT FK2dtofdm2kq9vtjw1l9n4ibv12
        FOREIGN KEY (activity_owner) REFERENCES clients (client_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,

    CONSTRAINT FKimig830p53q3y0gb6n6afqhem
        FOREIGN KEY (activity_server) REFERENCES servers (server_id)
            ON DELETE CASCADE
            ON UPDATE CASCADE,

    CONSTRAINT checkDuration
        CHECK ( activity_duration > 0 )
);

CREATE OR REPLACE TABLE detail_keys
(
    key_id   BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT,
    key_name VARCHAR(128) NOT NULL,

    CONSTRAINT UK_dkeyname128
        UNIQUE (key_name)
);

CREATE OR REPLACE TABLE detail_values
(
    value_id   BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT,
    value_name VARCHAR(255) NOT NULL,

    CONSTRAINT UK_dvaluename255
        UNIQUE (value_name)
);

CREATE OR REPLACE TABLE client_details
(
    detail_id    BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    detail_owner BIGINT NOT NULL,
    detail_key   BIGINT NOT NULL,
    detail_value BIGINT NOT NULL,

    CONSTRAINT UKm2j6op67mu08qu2qvdkrdl4kc
        UNIQUE (detail_owner, detail_key),

    CONSTRAINT FK530jsq9n3c7x4qqetaf8wpkn2
        FOREIGN KEY (detail_value) REFERENCES detail_values (value_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,

    CONSTRAINT FK7a062qkngn9l2iqcoi45n9gcd
        FOREIGN KEY (detail_owner) REFERENCES clients (client_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,

    CONSTRAINT FKqnekx15xbcenp9ssmo4tb3ek3
        FOREIGN KEY (detail_key) REFERENCES detail_keys (key_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

CREATE OR REPLACE TABLE client_activity_details
(
    detail_id    BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    detail_owner BIGINT NOT NULL,
    detail_key   BIGINT NOT NULL,
    detail_value BIGINT NOT NULL,

    CONSTRAINT UKml6ahvjbiw4qcplnuvcg6cu8c
        UNIQUE (detail_owner, detail_key),

    CONSTRAINT FK9dugqr7utph4si64duj8nrh4q
        FOREIGN KEY (detail_key) REFERENCES detail_keys (key_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,

    CONSTRAINT FKi565pbr6ii7jblina4ge9qx21
        FOREIGN KEY (detail_owner) REFERENCES client_activities (activity_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,

    CONSTRAINT FKplafebij7okimg9y1e1acdyt7
        FOREIGN KEY (detail_value) REFERENCES detail_values (value_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

CREATE OR REPLACE TABLE server_details
(
    detail_id    BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    detail_owner BIGINT NOT NULL,
    detail_key   BIGINT NOT NULL,
    detail_value BIGINT NOT NULL,

    CONSTRAINT UKbp2u2ifrt3hqmg8cmfpm0vlac
        UNIQUE (detail_owner, detail_key),

    CONSTRAINT FKg1b0sotl1gh86qw5cnt95or2n
        FOREIGN KEY (detail_owner) REFERENCES servers (server_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,

    CONSTRAINT FKjmo5kyejjv8t3epqt8mtlin3n
        FOREIGN KEY (detail_key) REFERENCES detail_keys (key_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,

    CONSTRAINT FKqfdna0h9sfywhmtg35m7scpcb
        FOREIGN KEY (detail_value) REFERENCES detail_values (value_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

CREATE OR REPLACE TABLE users
(
    user_id         BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_client     BIGINT       NULL,
    user_name       VARCHAR(128) NOT NULL,
    user_secret     VARCHAR(512) NOT NULL,
    user_input_time DATETIME(6)  NOT NULL,

    CONSTRAINT UKbp2u2ifrt3hqmg8cmfpm0v21a
        UNIQUE (user_name),

    CONSTRAINT UKbp2u2ifrt3hqmg8cmfpm0vhjg
        UNIQUE (user_client),

    CONSTRAINT FKejrutm6vl9vyr7kggamgd04ke
        FOREIGN KEY (user_client) REFERENCES clients (client_id)
            ON UPDATE CASCADE
            ON DELETE SET NULL
);

CREATE OR REPLACE TABLE user_details
(
    detail_id    BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    detail_owner BIGINT NOT NULL,
    detail_key   BIGINT NOT NULL,
    detail_value BIGINT NOT NULL,

    CONSTRAINT UK7qa69dqnk8jmr6fuje950wt7
        UNIQUE (detail_owner, detail_key),

    CONSTRAINT FKju6etns10xivh19jwdpy4p6k2
        FOREIGN KEY (detail_owner) REFERENCES users (user_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,

    CONSTRAINT FKkm2jtf2c6e30dbrcxd2dxlko6
        FOREIGN KEY (detail_key) REFERENCES detail_keys (key_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,

    CONSTRAINT FKkyrp5jjpipbwvfbfs3vm6vtlp
        FOREIGN KEY (detail_value) REFERENCES detail_values (value_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

CREATE OR REPLACE TABLE flag_groups
(
    group_id          BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT,
    group_name        VARCHAR(255) NOT NULL,
    group_description VARCHAR(255) NOT NULL,

    CONSTRAINT UK_eop4fr4vaxbre482t9b0aj78m
        UNIQUE (group_name)
);

CREATE OR REPLACE TABLE flags
(
    flag_id          BIGINT       NOT NULL PRIMARY KEY AUTO_INCREMENT,
    flag_signature   VARCHAR(4)   NOT NULL,
    flag_description VARCHAR(255) NOT NULL,
    flag_input_time  DATETIME(6)  NOT NULL,

    CONSTRAINT UK_eey83t4a51i8i06fwe9767igh
        UNIQUE (flag_signature)
);

CREATE OR REPLACE TABLE flag_group_tuples
(
    tuple_id    BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    tuple_group BIGINT NOT NULL,
    tuple_flag  BIGINT NOT NULL,

    CONSTRAINT unique_tuple
        UNIQUE (tuple_group, tuple_flag),

    CONSTRAINT FKe4mi3i1cuwmkq02e8jeyuoion
        FOREIGN KEY (tuple_group) REFERENCES flag_groups (group_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,

    CONSTRAINT FKm9t7i6xmqp73mhkph054vetsk
        FOREIGN KEY (tuple_flag) REFERENCES flags (flag_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

CREATE OR REPLACE TABLE user_privileges
(
    privilege_id         BIGINT      NOT NULL PRIMARY KEY AUTO_INCREMENT,
    privilege_giver      BIGINT      NOT NULL,
    privilege_receiver   BIGINT      NOT NULL,
    privilege_group      BIGINT      NOT NULL,
    privilege_input_time DATETIME(6) NOT NULL,

    CONSTRAINT unique_privilege
        UNIQUE (privilege_receiver, privilege_group),

    CONSTRAINT FKg4drywarv8rd5wljrw72ap1r5
        FOREIGN KEY (privilege_group) REFERENCES flag_groups (group_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,

    CONSTRAINT FKhdxulbyhqv61j937u3il32im1
        FOREIGN KEY (privilege_giver) REFERENCES users (user_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE,

    CONSTRAINT FKhdxulbyhqv61j937u3il32im2
            FOREIGN KEY (privilege_receiver) REFERENCES users (user_id)
                ON UPDATE CASCADE
                ON DELETE CASCADE
);





