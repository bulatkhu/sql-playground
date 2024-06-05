DROP TABLE IF EXISTS Foo;
CREATE TABLE Foo (bar char(32));
insert into foo values ('');
insert into foo values ('------------------------------32');
insert into foo values ('-------------------------------33');
insert into foo values ('---------------------------------');


DROP TABLE IF EXISTS FooVarchar;
CREATE TABLE FooVarchar (bar varchar(32));
insert into FooVarchar values ('');
insert into FooVarchar values ('------------------------------32');
insert into FooVarchar values ('-------------------------------33');
insert into FooVarchar values ('---------------------------------');
