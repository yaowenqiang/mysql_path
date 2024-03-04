CREATE TABLE `filmcopy` (
  `film_id` smallint unsigned NOT NULL,
  `title` varchar(128) NOT NULL,
  `description` text,
  `release_year` year DEFAULT NULL,
  `language_id` tinyint unsigned NOT NULL,
  `original_language_id` tinyint unsigned DEFAULT NULL,
  `rental_duration` tinyint unsigned NOT NULL DEFAULT '3',
  `rental_rate` decimal(4,2) NOT NULL DEFAULT '4.99',
  `length` smallint unsigned DEFAULT NULL,
  `replacement_cost` decimal(5,2) NOT NULL DEFAULT '19.99',
  `rating` enum('G','PG','PG-13','R','NC-17') DEFAULT 'G',
  `special_features` set('Trailers','Commentaries','Deleted Scenes','Behind the Scenes') DEFAULT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;


delimiter //
create procedure SubQ(p1 int)
begin
    label1: LOOP
        set p1 = p1 -1;
        if p1 > 0 then
            insert into  filmcopy (film_id, title, description, release_year, language_id, original_language_id, rental_duration, rental_rate, length, replacement_cost, rating, special_features, last_update)
                select * from film f where f.film_id in (select i.film_id from inventory i where inventory_id < 555);
            iterate label1;
        end if;
        leave label1;
    end loop label1;
end //
delimiter ;

delimiter //
create procedure ExistQ(p1 int)
begin
    label1: LOOP
        set p1 = p1 -1;
        if p1 > 0 then
            insert into  filmcopy (film_id, title, description, release_year, language_id, original_language_id, rental_duration, rental_rate, length, replacement_cost, rating, special_features, last_update)
            select * from film f where exists (select i.film_id from inventory i where inventory_id < 555 and i.film_id = f.film_id);
            iterate label1;
        end if;
        leave label1;
    end loop label1;
end //
delimiter ;


drop procedure JoinQ;
delimiter //
create procedure JoinQ(p1 int)
begin
    label1: LOOP
        set p1 = p1 -1;
        if p1 > 0 then
            insert into  filmcopy (film_id, title, description, release_year, language_id, original_language_id, rental_duration, rental_rate, length, replacement_cost, rating, special_features, last_update)
            select f.* from film f inner join inventory i on  i.film_id = f.film_id where i.inventory_id < 555;
            iterate label1;
        end if;
        leave label1;
    end loop label1;
end //
delimiter ;

call SubQ(1000);
truncate table filmcopy;

call ExistQ(1000);
truncate table filmcopy;

call JoinQ(1000);
truncate table filmcopy;

drop procedure SubQ;
drop procedure ExistQ;
drop procedure JoinQ;

