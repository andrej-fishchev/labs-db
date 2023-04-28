create table flag_group_tuples
(
    fg_tuple_id BIGINT NOT NULL PRIMARY KEY,
    flag        BIGINT NOT NULL,
    flag_group  BIGINT NOT NULL,

    CONSTRAINT unique_tuple     UNIQUE (flag_group, flag),

    CONSTRAINT fg_reference     FOREIGN KEY (flag_group)    REFERENCES flag_groups (flag_group_id),
    CONSTRAINT flag_reference   FOREIGN KEY (flag)          REFERENCES flags (flag_id)
);