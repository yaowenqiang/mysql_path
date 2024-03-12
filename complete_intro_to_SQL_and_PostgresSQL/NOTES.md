< https://sql.holt.courses

> docker exec  -u postgres -it psql   pg

```sql
SELECT id, title, COUNT(*) OVER ()::INT AS total_count FROM ingredients;
```

> \c dbname; # change to dbname

```sql
create table ingredients (
    id integer primary key generated always as identity ,
    title varchar(255) unique not null
)

```

> \d ingredients # describe table
