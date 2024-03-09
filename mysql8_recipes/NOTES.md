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

