CREATE DATABASE student_manage;
USE student_manage;

create table department(
		dept_id int primary key auto_increment,
        department_name varchar(50)
);

create table students_details(
	st_id int primary key auto_increment,
	st_name varchar(40),
    st_email varchar(50),
    st_pass varchar(50),
    st_phone varchar(10),
    st_svv_id int,
    st_year varchar(40),
    dept_id int,
    foreign key(dept_id) references department(dept_id)
);

create table faculty(
	fac_id int primary key auto_increment,
    fac_name varchar(40),
    fac_pass varchar(30),
    fac_email varchar(40),
    dept_id int,
    foreign key(dept_id) references department(dept_id)
);

create table question(
	quest_id int primary key auto_increment,
    question varchar(500),
    fac_id int,
    stu_id int,
	date varchar(50),
    topic varchar(100),
    status bool default false,
    foreign key(fac_id) references faculty(fac_id),
    foreign key(stu_id) references students_details(st_id)    
);

create table answer(
	answer_id int primary key auto_increment,
    quest_id int unique,
    answer varchar(500),
    foreign key(quest_id) references question(quest_id)  
);

insert into department values(1,"Computer Science");
insert into department values(2,"Information Technology");
insert into department values(3,"Artificial Intelligence And Data Science");
