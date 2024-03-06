delimiter //
create procedure FirstOption(p1 int)
begin
    label1: LOOP
        set p1 = p1 -1;
        if p1 > 0 then
            insert into  test_table (title, length, count)
            select title, length, count(*) from film where length < 100 group by title, length;
            iterate label1;
        end if;
        leave label1;
    end loop label1;
end //
delimiter ;


delimiter //
create procedure SecondOption(p1 int)
begin
    label1: LOOP
        set p1 = p1 -1;
        if p1 > 0 then
            insert into  test_table (title, length, count)
            select title, length, count(*) from film where length < 100 group by film_id;
            iterate label1;
        end if;
        leave label1;
    end loop label1;
end //
delimiter ;


call FirstOption(1000);
truncate table test_table;
call SecondOption(1000);
truncate table test_table;

