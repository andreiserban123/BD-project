--DDL
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
    check ( round(nota) >= 1 and round(nota) <= 10 )
);

ALTER TABLE SIT_PERSON
    ADD CONSTRAINT uniqueCNP UNIQUE (CNP);


--DML
INSERT INTO sit_jud (id, name)
VALUES (1, 'BUCURESTI');
INSERT INTO sit_jud (id, name)
VALUES (2, 'CLUJ');
INSERT INTO sit_jud (id, name)
VALUES (3, 'TIMIS');

INSERT INTO sit_loc (id, name, id_jud)
VALUES (1, 'Sectorul 6', 1);
INSERT INTO sit_loc (id, name, id_jud)
VALUES (2, 'Cluj-Napoca', 2);
INSERT INTO sit_loc (id, name, id_jud)
VALUES (3, 'TIMISOARA', 3);


INSERT INTO sit_address (id, id_loc, address)
VALUES (1, 1, 'STR. Chibzuintei');
INSERT INTO sit_address (id, id_loc, address)
VALUES (2, 2, 'STR.  21 Decembrie 1989');
INSERT INTO sit_address (id, id_loc, address)
VALUES (3, 3, 'STR.  Mihai Eminescu');



INSERT INTO sit_person (id, f_name, l_name, b_day, id_address, cnp)
VALUES (1, 'ION', 'IONESCU', to_date('01-01-1990', 'dd-mm-yyyy'), 1, 1234567890123);
INSERT INTO sit_person (id, f_name, l_name, b_day, id_address, cnp)
VALUES (2, 'VASILE', 'VASILESCU', to_date('01-02-2003', 'dd-mm-yyyy'), 2, 1234567890123);
INSERT INTO sit_person (id, f_name, l_name, b_day, id_address, cnp)
VALUES (3, 'MARIUS', 'POPESCU', to_date('12-03-2005', 'dd-mm-yyyy'), 3, 1234567890123);
INSERT INTO sit_person (id, f_name, l_name, b_day, id_address, cnp)
VALUES (4, 'ANA', 'ANESCU', to_date('15-04-1995', 'dd-mm-yyyy'), 1, 1234567890123);
INSERT INTO sit_person (id, f_name, l_name, b_day, id_address, cnp)
VALUES (5, 'GEORGE', 'GEORGESCU', to_date('10-08-1988', 'dd-mm-yyyy'), 2, 1234567890123);

INSERT INTO sit_user (id, email, password, id_pers)
VALUES (1, 'ion.ionescu@gmail.com', '123456', 1);
INSERT INTO sit_user (id, email, password, id_pers)
VALUES (2, 'vasile.vasilescu@gmail.com', 'fdsfds', 2);
INSERT INTO sit_user (id, email, password, id_pers)
VALUES (3, 'marius.popescu@gmail.com', 'acoperis', 3);
INSERT INTO sit_user (id, email, password, id_pers)
VALUES (4, 'ana.anescu@gmail.com', 'parola123', 4);
INSERT INTO sit_user (id, email, password, id_pers)
VALUES (5, 'george.georgescu@gmail.com', 'parola456', 5);


INSERT INTO sit_roles (id, role)
VALUES (1, 'STUDENT');
INSERT INTO sit_roles (id, role)
VALUES (2, 'PARENT');
INSERT INTO sit_roles (id, role)
VALUES (3, 'TEACHER');
INSERT INTO sit_roles (id, role)
VALUES (4, 'ADMIN');

INSERT INTO sit_user_roles (id, id_user, id_role)
VALUES (1, 1, 3); -- teacher
INSERT INTO sit_user_roles (id, id_user, id_role)
VALUES (2, 2, 1); -- student
INSERT INTO sit_user_roles (id, id_user, id_role)
VALUES (3, 3, 1); -- student
INSERT INTO sit_user_roles (id, id_user, id_role)
VALUES (4, 4, 2); -- parent
INSERT INTO sit_user_roles (id, id_user, id_role)
VALUES (5, 5, 1); -- student


INSERT INTO sit_parents (id, id_parent, id_student)
VALUES (1, 1, 2);
INSERT INTO sit_parents (id, id_parent, id_student)
VALUES (2, 4, 5);


INSERT INTO sit_grade (id, grade)
VALUES (1, 9);
INSERT INTO sit_grade (id, grade)
VALUES (2, 10);
INSERT INTO sit_grade (id, grade)
VALUES (3, 11);
INSERT INTO sit_grade (id, grade)
VALUES (4, 12);


INSERT INTO sit_materii (id, name)
VALUES (1, 'MATEMATICA');
INSERT INTO sit_materii (id, name)
VALUES (2, 'FIZICA');
INSERT INTO sit_materii (id, name)
VALUES (3, 'CHIMIE');
INSERT INTO sit_materii (id, name)
VALUES (4, 'INFORMATICA');
INSERT INTO sit_materii (id, name)
VALUES (5, 'BIOLOGIE');
INSERT INTO sit_materii (id, name)
VALUES (6, 'GEOGRAFIE');
INSERT INTO sit_materii (id, name)
VALUES (7, 'ISTORIE');
INSERT INTO sit_materii (id, name)
VALUES (8, 'LIMBA ROMANA');

INSERT INTO sit_class (id, letter, year, grade_id)
VALUES (1, 'A', '2019-2020', 1);
INSERT INTO sit_class (id, letter, year, grade_id)
VALUES (2, 'B', '2019-2020', 1);
INSERT INTO sit_class (id, letter, year, grade_id)
VALUES (3, 'C', '2019-2020', 1);
INSERT INTO sit_class (id, letter, year, grade_id)
VALUES (4, 'D', '2019-2020', 1);
INSERT INTO sit_class (id, letter, year, grade_id)
VALUES (5, 'E', '2019-2020', 1);

INSERT INTO sit_subject (id, id_class, id_materie, id_user_roles)
VALUES (1, 1, 1, 1);

INSERT INTO sit_obj (key, value)
VALUES (1, 'N');
INSERT INTO sit_obj (key, value)
VALUES (2, 'T');
INSERT INTO sit_obj (key, value)
VALUES (3, 'Abs');

INSERT INTO sit_catalogue (id, nota, id_student, id_materie, obj_date, id_obj)
VALUES (1, 9, 2, 1, to_date('01-01-2020', 'dd-mm-yyyy'), 1);
INSERT INTO sit_catalogue (id, nota, id_student, id_materie, obj_date, id_obj)
VALUES (2, 10, 2, 1, to_date('01-01-2020', 'dd-mm-yyyy'), 1);


update SIT_MATERII
set name = 'Limba Engleza'
where id = 8;

delete
from SIT_MATERII
where id = 8;

--1. selecteaza toate notele studentului cu id 2
SELECT c.nota, m.name AS materie
FROM SIT_CATALOGUE c
         JOIN SIT_SUBJECT s ON c.id_materie = s.id_materie
         JOIN SIT_MATERII m ON s.id_materie = m.id
WHERE c.id_student = 2;


