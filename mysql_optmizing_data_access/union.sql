select staff_id, first_name, last_name from staff s
union all
select customer_id, first_name, last_name from customer c
union all
select actor_id, first_name, last_name from actor a

select staff_id, first_name, last_name from staff s
union
select customer_id, first_name, last_name from customer c
union
select actor_id, first_name, last_name from actor a

delimiter //
create procedure UnionAllOption(p1 int)
begin
    label1: LOOP
        set p1 = p1 -1;
        if p1 > 0 then
            insert into  union_test (id, first_name, last_name)
            select staff_id, first_name, last_name from staff s
            union all
            select customer_id, first_name, last_name from customer c
            union all
            select actor_id, first_name, last_name from actor a;
            iterate label1;
        end if;
        leave label1;
    end loop label1;
end //
delimiter ;

delimiter //
create procedure UnionOption(p1 int)
begin
    label1: LOOP
        set p1 = p1 -1;
        if p1 > 0 then
            insert into  union_test (id, first_name, last_name)
            select staff_id, first_name, last_name from staff s
            union
            select customer_id, first_name, last_name from customer c
            union
            select actor_id, first_name, last_name from actor a;
            iterate label1;
        end if;
        leave label1;
    end loop label1;
end //
delimiter ;

call UnionOption(1000);
truncate table union_test;
call UnionAllOption(1000);
drop table union_test;
drop procedure UnionOption;
drop procedure UnionAllOption;

