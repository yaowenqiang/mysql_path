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











