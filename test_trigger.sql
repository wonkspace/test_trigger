-- drop database if exists test;
-- create database test;
-- use test;
drop table if exists testtable;
create table testtable (str char(10), num int);
delimiter $$ 
drop function if exists incr$$
create function incr(n1 int)
  returns int deterministic
			begin
				declare newval int;
				set newval = n1 +1;
				return newval;
			end; $$
drop trigger if exists increment$$ 
create trigger incr before insert on testtable
	for each row begin
		declare a1 int;
		set new.num = incr(new.num); 
	end; $$
delimiter ;
insert into testtable (str,num) values("rec1",1);
insert into testtable (str,num) values("rec2",3);
insert into testtable (str,num) values("rec3",5);
select * from testtable;
