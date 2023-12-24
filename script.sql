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
    nota       number,
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

alter table sit_user
    add constraint uniqueEmail unique (email);


--DML
INSERT INTO sit_jud (id, name)
VALUES (1, 'BUCURESTI');
INSERT INTO sit_jud (id, name)
VALUES (2, 'CLUJ');
INSERT INTO sit_jud (id, name)
VALUES (3, 'TIMIS');
INSERT INTO sit_jud (id, name)
VALUES (4, 'BRASOV');
INSERT INTO sit_jud (id, name)
VALUES (5, 'CONSTANTA');
INSERT INTO sit_jud (id, name)
VALUES (6, 'DOLJ');
INSERT INTO sit_jud (id, name)
VALUES (7, 'GALATI');
INSERT INTO sit_jud (id, name)
VALUES (8, 'IASI');
INSERT INTO sit_jud (id, name)
VALUES (9, 'PRAHOVA');
INSERT INTO sit_jud (id, name)
VALUES (10, 'SIBIU');
INSERT INTO sit_jud (id, name)
VALUES (11, 'Suceava');


INSERT INTO sit_loc (id, name, id_jud)
VALUES (1, 'Sectorul 6', 1);
INSERT INTO sit_loc (id, name, id_jud)
VALUES (2, 'Cluj-Napoca', 2);
INSERT INTO sit_loc (id, name, id_jud)
VALUES (3, 'TIMISOARA', 3);
INSERT INTO sit_loc (id, name, id_jud)
VALUES (4, 'Brasov City', 4);
INSERT INTO sit_loc (id, name, id_jud)
VALUES (5, 'Constanta City', 5);
INSERT INTO sit_loc (id, name, id_jud)
VALUES (6, 'Craiova', 6);
INSERT INTO sit_loc (id, name, id_jud)
VALUES (7, 'Galati', 7);
INSERT INTO sit_loc (id, name, id_jud)
VALUES (8, 'Iasi', 8);
INSERT INTO sit_loc (id, name, id_jud)
VALUES (9, 'Ploiesti', 9);
INSERT INTO sit_loc (id, name, id_jud)
VALUES (10, 'Sibiu', 10);
INSERT INTO sit_loc (id, name, id_jud)
VALUES (11, 'Suceava', 11);



INSERT INTO sit_address (id, id_loc, address)
VALUES (1, 1, 'STR. Chibzuintei');
INSERT INTO sit_address (id, id_loc, address)
VALUES (2, 2, 'STR.  21 Decembrie 1989');
INSERT INTO sit_address (id, id_loc, address)
VALUES (3, 3, 'STR.  Mihai Eminescu');
INSERT INTO sit_address (id, id_loc, address)
VALUES (4, 4, 'STR. Centrului');
INSERT INTO sit_address (id, id_loc, address)
VALUES (5, 5, 'Bd. Tomis');
INSERT INTO sit_address (id, id_loc, address)
VALUES (6, 6, 'STR. 1 Decembrie');
INSERT INTO sit_address (id, id_loc, address)
VALUES (7, 7, 'STR. 1 Mai');
INSERT INTO sit_address (id, id_loc, address)
VALUES (8, 8, 'STR. 2 Mai');
INSERT INTO sit_address (id, id_loc, address)
VALUES (9, 9, 'STR. 3 Mai');
INSERT INTO sit_address (id, id_loc, address)
VALUES (10, 10, 'STR. 4 Mai');
INSERT INTO sit_address (id, id_loc, address)
VALUES (11, 11, 'STR. 5 Mai');



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
INSERT INTO sit_person (id, f_name, l_name, b_day, id_address, cnp)
VALUES (6, 'MARIA', 'MARIAN', to_date('05-05-1992', 'dd-mm-yyyy'), 2, 5234562891323);
INSERT INTO sit_person (id, f_name, l_name, b_day, id_address, cnp)
VALUES (7, 'RADU', 'RADULESCU', to_date('08-08-1985', 'dd-mm-yyyy'), 3, 1234537892123);
INSERT INTO sit_person (id, f_name, l_name, b_day, id_address, cnp)
VALUES (8, 'MIRCEA', 'MIRCEANU', to_date('09-09-1999', 'dd-mm-yyyy'), 4, 1234537890123);
INSERT INTO sit_person (id, f_name, l_name, b_day, id_address, cnp)
VALUES (9, 'ANDREI', 'ANDREESCU', to_date('10-10-2000', 'dd-mm-yyyy'), 5, 1234167890123);
INSERT INTO sit_person (id, f_name, l_name, b_day, id_address, cnp)
VALUES (10, 'MIHAI', 'MIHAILESCU', to_date('11-11-2001', 'dd-mm-yyyy'), 6, 1234667890123);
INSERT INTO sit_person (id, f_name, l_name, b_day, id_address, cnp)
VALUES (11, 'IONEL', 'IONEL', to_date('12-12-2002', 'dd-mm-yyyy'), 7, 12345678912123);
INSERT INTO sit_person (id, f_name, l_name, b_day, id_address, cnp)
VALUES (12, 'IONELA', 'IONELA', to_date('13-01-2003', 'dd-mm-yyyy'), 8, 12345678320123);



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
INSERT INTO sit_user (id, email, password, id_pers)
VALUES (6, 'maria.marinescu', 'parola789', 6);
INSERT INTO sit_user (id, email, password, id_pers)
VALUES (7, 'radu.radulescu', 'parola101112', 7);
INSERT INTO sit_user (id, email, password, id_pers)
VALUES (8, 'mircea.mirceanu', 'parola131415', 8);
INSERT INTO sit_user (id, email, password, id_pers)
VALUES (9, 'andrei.andreescu', 'parola161718', 9);
INSERT INTO sit_user (id, email, password, id_pers)
VALUES (10, 'mihai.mihailescu', 'parola192021', 10);
INSERT INTO sit_user (id, email, password, id_pers)
VALUES (11, 'ionel.ionel', 'parola222324', 11);
INSERT INTO sit_user (id, email, password, id_pers)
VALUES (12, 'ionela.ionela', 'parola252627', 12);



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
INSERT INTO sit_user_roles (id, id_user, id_role)
VALUES (6, 6, 1); -- student
INSERT INTO sit_user_roles (id, id_user, id_role)
VALUES (7, 7, 1); -- student
INSERT INTO sit_user_roles (id, id_user, id_role)
VALUES (8, 8, 3); -- teacher
INSERT INTO sit_user_roles (id, id_user, id_role)
VALUES (9, 9, 1); -- student
INSERT INTO sit_user_roles (id, id_user, id_role)
VALUES (10, 10, 1); -- student
INSERT INTO sit_user_roles (id, id_user, id_role)
VALUES (11, 11, 1); -- student
INSERT INTO sit_user_roles (id, id_user, id_role)
VALUES (12, 12, 1); -- student


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
INSERT INTO sit_materii (id, name)
VALUES (9, 'LIMBA ENGLEZA');
INSERT INTO sit_materii (id, name)
VALUES (10, 'LIMBA FRANCEZA');
INSERT INTO sit_materii (id, name)
VALUES (11, 'LIMBA GERMANA');
INSERT INTO sit_materii (id, name)
VALUES (12, 'Dirigentie');

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
INSERT INTO sit_class (id, letter, year, grade_id)
VALUES (6, 'A', '2019-2020', 2);
INSERT INTO sit_class (id, letter, year, grade_id)
VALUES (7, 'B', '2019-2020', 2);
INSERT INTO sit_class (id, letter, year, grade_id)
VALUES (8, 'C', '2019-2020', 2);
INSERT INTO sit_class (id, letter, year, grade_id)
VALUES (9, 'D', '2019-2020', 2);
INSERT INTO sit_class (id, letter, year, grade_id)
VALUES (10, 'E', '2019-2020', 2);



INSERT INTO sit_subject (id, id_class, id_materie, id_user_roles)
VALUES (1, 1, 1, 1);
INSERT INTO sit_subject (id, id_class, id_materie, id_user_roles)
VALUES (2, 1, 2, 1);
INSERT INTO sit_subject (id, id_class, id_materie, id_user_roles)
VALUES (3, 1, 3, 1);
INSERT INTO sit_subject (id, id_class, id_materie, id_user_roles)
VALUES (4, 1, 4, 1);
INSERT INTO sit_subject (id, id_class, id_materie, id_user_roles)
VALUES (5, 1, 5, 1);
INSERT INTO sit_subject (id, id_class, id_materie, id_user_roles)
VALUES (6, 1, 6, 8);
INSERT INTO sit_subject (id, id_class, id_materie, id_user_roles)
VALUES (7, 1, 7, 8);
INSERT INTO sit_subject (id, id_class, id_materie, id_user_roles)
VALUES (8, 1, 8, 8);
INSERT INTO sit_subject (id, id_class, id_materie, id_user_roles)
VALUES (9, 1, 9, 8);


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
set name = 'Spaniola'
where id = 8;

update sit_roles
set role = 'STUDENT'
where id = 1;

update SIT_CATALOGUE
set nota = 10
where id = 1;


delete
from SIT_MATERII
where id = 8;

--1. selecteaza toate notele studentului cu id 2
SELECT c.nota, m.name AS materie
FROM SIT_CATALOGUE c
         JOIN SIT_SUBJECT s ON c.id_materie = s.id_materie
         JOIN SIT_MATERII m ON s.id_materie = m.id
WHERE c.id_student = 2;

-- 2. afiseaza id-ul si rolul utilizatorilor
SELECT id,
       DECODE(id_role, 1, 'Student', 2, 'Parent', 3, 'Teacher', 4, 'Admin', 'Other') AS role
FROM sit_user_roles;
