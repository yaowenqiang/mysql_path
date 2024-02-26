# Understanding Data Needs

+ Retrieve rows which are required in the application
  + Using where clause properly
+ Retrieve columns which are required in the application
  + Avoid using select * and list column names in select clause
+ Avoid retrieving the same data multiple times
  + Use cache of application to store data for the moment
+ Order the data only if you are not ordering them in application
  + Use order by in the select clause rather than application


# add index 
> alter table film add key ix_length(length);
>

## use index 

> explain  select * from film where length < 100;


## Not use index 

> select * from film where length < 100;


## use index 

> select film_id, length from film where length < 100;

