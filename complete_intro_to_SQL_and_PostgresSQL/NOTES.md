< https://sql.holt.courses

```sql
SELECT id, title, COUNT(*) OVER ()::INT AS total_count FROM ingredients;
```
