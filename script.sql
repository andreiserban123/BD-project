create table sit_jud
(
    id   number primary key not null,
    name varchar2(256)      not null
);
/

create table sit_loc
(
    id     number primary key not null,
    name   varchar2(256)      not null,
    id_jud number             not null,
    FOREIGN KEY (id_jud) REFERENCES SIT_JUD (id)
);
/

create table sit_address
(
    id      number primary key not null,
    id_loc  number             not null,
    address varchar2(256),
    FOREIGN KEY (id_loc) references sit_loc (id)
);
/

create table sit_person
(
    id         number primary key not null,
    f_name     varchar2(256)      not null,
    l_name     varchar2(256)      not null,
    b_day      date               not null,
    id_address number             not null,
    cnp        number,
    FOREIGN KEY (id_address) references SIT_ADDRESS (id)
);

create table SIT_USER
(
    id       number primary key not null,
    email    varchar2(200)      not null,
    password varchar2(200)      not null,
    id_pers  number             not null,
    FOREIGN KEY (id_pers) references SIT_PERSON (id)
);

create table sit_roles
(
    id   number primary key not null,
    role varchar2(200)      not null
);
/

create table sit_user_roles
(
    id      number primary key not null,
    id_user number             not null,
    id_role number             not null,
    FOREIGN KEY (id_user) references SIT_USER (id),
    FOREIGN KEY (id_role) references SIT_ROLES (id)
);
/

create table SIT_PARENTS
(
    id         number primary key not null,
    id_parent  number             not null,
    id_student number             not null,
    FOREIGN KEY (id_parent) references SIT_USER_ROLES (id),
    FOREIGN KEY (id_student) references SIT_USER_ROLES (id)
);
/


create table SIT_GRADE
(
    id    number primary key not null,
    grade number             not null
);
/

create table SIT_MATERII
(
    id   number primary key not null,
    name varchar2(50)       not null
);
/
create table SIT_CLASS
(
    id       number primary key not null,
    letter   varchar2(1),
    year     varchar2(20),
    grade_id number,
    FOREIGN KEY (grade_id) references SIT_GRADE (id)
);
/
create table SIT_SUBJECT
(
    id            number primary key not null,
    id_class      number             not null,
    id_materie    number             not null,
    id_user_roles number             not null,
    FOREIGN KEY (id_class) references SIT_CLASS (id),
    FOREIGN KEY (id_materie) references SIT_MATERII (id),
    FOREIGN KEY (id_user_roles) references SIT_USER_ROLES (id)
);
/

create table SIT_OBJ
(
    key   number primary key not null,
    value varchar2(100)      not null
);

create table SIT_CATALOGUE
(
    id         number primary key not null,
    nota       number             not null,
    id_student number             not null,
    id_materie number             not null,
    obj_date   date,
    id_obj     number,
    FOREIGN KEY (id_student) references SIT_USER_ROLES (id),
    FOREIGN KEY (id_materie) references SIT_SUBJECT (id),
    foreign key (id_obj) references SIT_OBJ (key),
    check ( round(nota) >= 1 and round(nota) <=10 )
);

