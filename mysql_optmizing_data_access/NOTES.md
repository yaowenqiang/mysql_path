# Understanding Data Needs

+ Retrieve rows which are required in the application
  + Using where clause properly
+ Retrieve columns which are required in the application
  + Avoid using select * and list column names in select clause
+ Avoid retrieving the same data multiple times
  + Use cache of application to store data for the moment
+ Order the data only if you are not ordering them in application
  + Use order by in the select clause rather than application


## Execution Path of a Query

Client -> Query Cache -> Parser -> Preprocessor -> Query Optimizer -> Query Execution Engine -> Storage Engine -> Data

# add index 
> alter table film add key ix_length(length);

## Query Optimizer Responsibilities

+ Converts sub-optimal join types to efficient logic
+ Reorder join tables
+ Reducing constant expression
+ Optimizing algebraic rules
+ Logic short circuit
+ Optimal index usage
+ Sort optimization
+ Optimizing aggregate functions

## Query Optimizer Limitations

+ No parallel query execution
+ No consideration to parallel running query
+ Dependency on storage engine statistics
+ Fastest executing query vs Must resource optimized query
+ Cost of stored routines(SP, Function), are not  often considered in the cost of operation

## use index 

> explain  select * from film where length < 100;


## Not use index 

> select * from film where length < 100;


## use index 

> select film_id, length from film where length < 100;

