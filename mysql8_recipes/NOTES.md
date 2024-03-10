# get mysql status

> show status
> > show variables``


# Server Status Variables

+ Provide information about the server operation
+ Read-only
+ show status
+ show global status
+ show session status(default show status)

List of Status Variables

> https://dev.mysql.com/doc/refman/8.0/en/mysqld-option-tables.html


# Server System Variables

+ Configure how the database operates
+ Can be modified
+ show variables
+ show global variables
+ show session variables (default show variables)

List of System Variables

> https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html

# Changing Server System Variables - The SET command

+ the SEt command is used to chagne Server system variables
+ Set variable temporarily for this session: SET SESSION
+ Set variable temporarily for this server: SET GLOBAL
+ Set variable permanently for this session: SET persist


# Server System Variables - How they Are Set

+ Start with default variable value
+ On startup: Read Options file(for example /etc/my.cnf)
+ Apply persisted settings (SET PERSIST): <data-dir>/mysqld-auto.cnf
+ temporarily settings applied with SET GLOBAL
+ temporarily session settings applied with SET SESSION

## INNODB_BUFFER_POOL_SIZE

Defines how much memory (in bytes) InnoDB used for buffering data, Typically, this should be 70% of the server memory

## Accessing Data dictionary(mysql 8)

> Data dictionary: Data about our data

## Benefits

+ simplicity of a centralized data dictionary schema that uniformly stores dictionary data
+ Removal of file-based metadata storage
+ transactional,crash-safe storage of dictionary data
+ Uniform and centralized caching for dictionary objects
+ A simpler and improved implementation for some INFORMATION_SCHEMA tables


## Querying the Data dictionary

+ Cannot query directly
+ Vies/Tables in INFORMATION_SCHEMA
+

> https://dev.mysql.com/doc/refman/8.0/en/data-dictionary-schema.html


# Managing Users

> select user, host from mysql.user;

## Commands to Create/Alter/Delete users

Creating a  new user 'myuser';

> create user 'myuser'@'localhost' identified by 'mypass';

Changing the password of an existing user 'myuser'

> alter user 'myuser'@'localhost' identified by 'newpassword';

Deleting a user 'myuser'

> drop user 'myuser'@'localhost'

> grant create, select, insert, update, delete on world.* to 'myuser@%';
>

## Roles


> create role developers
> grant create, select, insert, update, delete on world.* to developers;
> grant developers to simon;
> grant developers to josh;

> Both 'simon' and 'john'  can now work on al objects in database world;

# Administration Topics

## MySql Error Log

> /user/log/mysqld.log


+ Contains errors and diagnostic information
+ Most important log file for mysql Administration
+ Defined in variable 'log_error'

> netstat -tunlp

## Reset Root Password

+ Stop MySQL Server : systemctl stop mysqld
+ Restart MySQL server with '-skip-grant-tables' 
+ mysqld --skip-grant-tables --user=mysql &
+ Login without password mysql -uroot
+ Load privileges table: FLUSH PRIVILEGES
+ Change root password: alter user 'root'@'localhost' identified by 'newpassword';
+ restart the server normally and log in with your new password;

## Too many connections

> Common error on incorrectly configured MySQL databases

### Too Many Connections - Cause and Resolution

+ Symptoms: "Too many connections"
+ Cause
  + there are too many simultaneous connection to the database
  + The maximum number of connection is defined in 'max_connections'
  + Default value is 151 simultaneous connections
  + if you require more connections ,change this variable by issuing:
    + SET PERSIST max_connections = 300;


+ Symptoms: "Table does not exists", "Access denies"
+ Cause
  + Insufficient privieges, missing GRANTs
+ Troubleshooting steps:
  + Check that tables/objects exist using user 'root'
  + show grants for 'simon'@'localhost';
  + grant _ on _ to 'simon'@'localhost';

# configuring Security

> MySQL 8 has many security features enables by default

## Example for features enabled by default in MySQL 8

+ 'root'is only allowed to connect from 'localhost'
+ Users are required to provide complex passwords
+ SSL certificate are installed by default installation

## general Security issues

+ Avoid exposing you MySQL server to the internet, if necessary, only allow local connectin, never external conections
+ Never give anyone ('except'root') access to the table 'mysql.user'
+ Never use 'root' in an application
  + This user is only for administration

## Users and privileges

important concepts to secure your data in your database

### Users

+ Choose a long, complex password
+ Clearly restrict the host from where the user can connect

### MySQL Access Privilege System

+ Defines who can perform what operations on what objects
+ Grant privileges according to the 'Principle of least privilege';
  + Only grant the minimal set of privileges to a user
+ With MySQL 8, use Roles to grant similar privileges to different user+

### Application security

SQL injection are the most common attack vectors

### SQL injection

+ Do not trust user input and use it directly in your database queries
+ Example
  + Application Query such as 'select * from table where id=234' User enter "234 or 1=1'
  + When trusting the user input, this generate the following query that returns all rows of the table
  + > select * from table where id=1234 or 1=1


## backup and reocvery

### Importance of backups

+ Protect against a wide range of problems and errors, such as:
  + Hardware failure
  + Accidental deletion of data
  + Data corruption

### mysqldump

+ Exports databases as a SQL file
+ Works for most use-cases
+ For more complex requirements, consider "MySQL Enterprise Backup"


### Using mysqldump

+ Typically, for a backup, we specify the following arguments:
  + Username: -u <Username>
  + Password -p <Password>
  + Dump all databases: --all-databases
  + Force consistent backup: --single-transaction
  + Output file: --result-file+

example: 

> mysqldump -u root -p "mypassword" --all-databases --single-transaction --result-file mybackup.sql

### Restore

> source backup.sql

## Optmize Query

### Query plan

The SQL language

+ SQL is a declarative language
+ With an SQL statement, you tell a database WHAT you want to query,not HOW you want to query the database
+ Therefore, the Optimizer needs to convert your query into a Query Execution Plan and the database will then execute the plan
+ Each operation of the plan has a "cost", generally, the less a query costs, the faster it runs

### Optimization with Query Execution Plans

+ Check if there are operations with a high cost
+ So the Query Execution Plan tells you where the query spends the most time
+ Using indexes, rewriting the query adding more "WHERE" clauses, try to minimize costs


### Slow Query Log

+ To enable, set the variable "slow_query_log=ON"
+ Logs queries taking longer than n seconds, where n is the value of 'long_query_time'
+ Writes to "$HOSTNAME-slow.log"

### Variables to Consider for Performance tuning

+ Innodb_buffer_pool_size
  + Size of the database buffer
  + Defines how much data can be buffered in memory
  + Should be around 50-80% of the total server memory
+ Innodb_log_file_size
  + Size of the innodb logs
  + Defines how many unflushed pages can exist, The higher this value, The more unflushed pages can exist, therefore improving write performance
  + Size depends on workload, many databases works with 500MB - 1GB

## Functions

### Single Row functions

+ upper([varchar])
+ lower([varchar])
+ length([varchar])
+ round([number], n)
+ year([date])
+ month([date])
+ ifnull([expr], [ret_val])

### Multi-Row functions


+ sum
+ count
+ avg
+ min
+ max

### Joins

> https://dev.mysql.com/doc/refman/8.0/en/join.html


# Design Databases

Most important data types:

+ varchar
+ text
+ int
+ bigint
+ decimal
+ date
+ datetime

## String Data Types

> https://dev.mysql.com/doc/refman/8.0/en/string-types.html

## Numeric Data Types

> https://dev.mysql.com/doc/refman/8.0/en/numeric-types.html

## Date and Time Types

+ Store temporal (time and date) values
+ DATE
+ Store only the year, month, day
+ DATETIME
+ Like Date, but with hour, minute, seconds

> https://dev.mysql.com/doc/refman/8.0/en/datetime.html

## Joins

+ Make sure both columns referenced in the JOIN:
  + Are indexed
  + Have the same data type

## Auto-Commit

Performance improvements when modifying a lot of data

+ Auto-commit usually helpful
+ When inserting large amounts of data, consider turning auto-commit off

# Nuew feature of MySQL 8

+ Improved Optimizer
+ Descending indexes
+ invisible indexes
+ Partitioning
+ CTE(Common Table Expression)
  + Define separate queries
  + Create a temporary VIEW
  + Create a temporary result set

## Common Table Expression - Advantages

+ Write easier queries
+ code reuse, reference the same subquery multiple times

```sql
with it_employees as (
    select first_name, last_name from employees where department_id = 60
    
) select first_name, last_name from it_employees where salary > 5000;

```

## Common Table Expression - Recursive Example

```sql
with recursive cte as (
    select 1
        union all
            select n + 1 from ctr where n < 5
            
) select * from ctr;

```

> https://dev.mysql.com/doc/refman/8.0/en/mysql-nutshell.html

## indexes

one index may contains up to 60 columns

## Partitions Basics

+ Partitioning a table means:
  + Create a table consisting of multiple partitions
  + Depending on certain column values, store different rows of the table in different partitions
+ Partitioning is transparent, The application does not see if a table is partitioned or not

## Partitioning Types

+ RANGE
+ LIST
+ HASH
+ KEY

```sql
create table employees (
    employee_id int not null,
    first_name varchar(30),
    last_name varchar(30),
    hired date
)
partition by range(year(hired)) (
    partition p0 values less than (1991),
    partition p1 values less than (1996),
    partition p2 values less than (2001),
    partition p3 values less than maxvalue
    );

```

```sql
create table employees2 (
                           employee_id int not null,
                           first_name varchar(30),
                           last_name varchar(30),
                           hired date,
                            store_id int
)
partition by list(store_id) (
	partition pNorth values in (3,5, 6, 9, 17),
	partition pEast values in (1,2,10, 11, 19, 20),
	partition pWest values in (4, 12, 13, 14, 18),
	partition pCentral values in (7, 8, 15, 16)
	);

```

```sql
create table employees3 (
	employee_id int not null,
	first_name varchar(30),
	last_name varchar(30),
	hired date,
	store_id int
)
partition by hash(year(hired))
partitions 4;
```

## New administration options for alter  table

+ ADD partition
+ DROP partition
+ COALESCE partition
+ REORGANIZE partition
+ REBUILD partition

> https://dev.mysql.com/doc/refman/8.0/en/partitioning-overview.html


Python Modules for database access

+ MySQLdb
+ Records
+ SQLAlchemy
+ Django ORM
+ peewee


