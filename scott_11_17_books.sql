create table yes24(
	no number(5) primary key,
	title varchar2(50) not null,
	author varchar2(30) not null,
	coauthor varchar2(30),
	price number(10,2)
);

select * from yes24;

alter table yes24 add(pub_date date);
alter table yes24 add(company varchar2(30));
