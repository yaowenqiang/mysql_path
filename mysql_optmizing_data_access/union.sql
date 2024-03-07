explain  select staff_id, first_name, last_name from staff s
union all
select customer_id, first_name, last_name from customer c
union all
select actor_id, first_name, last_name from actor a

explain select staff_id, first_name, last_name from staff s
union
select customer_id, first_name, last_name from customer c
union
select actor_id, first_name, last_name from actor a

