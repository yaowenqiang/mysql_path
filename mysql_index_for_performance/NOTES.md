
# InnoDB vs MyISAM

| InnoDB  |  MyISAM  | 
| ----- |  ------  |
| Default storage engine as of MySQL 5.5 | Default storage engine before MySQL 5.5
| ACID* compliant | Not ACID compliant  | 
| Transactional ()Rollback, commit)  | Non-Transactional | 
| Row Level locking | Table level locking | 
| Row data stored in pages as per Primary Key order | No Particular order for data stored |
| Support Foreign Keys | Does not support relationship-constraint | 
| No Full Text Search | Full Text search |

## B-Tree Index

+ B-Tree Index is offten referred as an index
+ Most storage engines support B+Tree index
  + Each Leafnode contains a link to the next node for the fast range traversals
  + Values are stored in order
  + Each leaf page is at the save distance from root level
  + InnoDB storage uses B+Tree index


## Advantage of B-Tree Index

+ B-Tree Index sppeds up data access
  + Storage engine traveses from root node to leafnode with the help of pointers
+ Increase performance of following query patterns:
+   + Full Value
+   + Leftmost Value of Column Prefix
    + Range of Values
+ B-Tree structure helps ORDER BY clause to increase the performance


