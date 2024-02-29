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


## Query Optimizer

+ Query Optimizer is a Cost Based Optimizer
  + Selects the path using the least resources
+ MySQL execution plan is tree of unstructions
+ Use EXPLAN EXTENDED
+ Static Optimization
  + Inspection of parse tree
+ Dynamic Optimization
  + Contextual inspection of various factors of query

## Maximizing Query Optimizer Performance

+ Optimizing Data Access
+ Understanding Query Optimization
+ Query Re-write

## Understanding  Query Stats

> SHOW FULL PROCESSLIST

+ Sleep
+ Query
+ Analyzing and statistics
+ Copying to tmp table
+ Sorting result
+ Sending data

## Understanding EXPLAIN Command

Explain select query

+ id
+ select_type
+ table
+ type
+ possible_keys
+ key
+ key_len
+ ref
+ rows

> explain extended select * from actor inner join film_actor on actor.actor_id = film_actor.actor_id;+

> the extended keyword does not exists in mysql 8.0


> MySql general thread stats

+





## use index 

> explain  select * from film where length < 100;


## Not use index 

> select * from film where length < 100;


## use index 

> select film_id, length from film where length < 100;

