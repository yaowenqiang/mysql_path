
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


## Clustered index

+ Clustered index is just a different approach of data storage
  + Not really different type of index
  + Not all storage engines support it
+ Rows with adjacent key values are stored close to each other
+ One clustered index per table


## Advantages of clustered index

+ Related data is stored close to each other leading less disk I/O while retrieving sequential or range data
+ Faster data access as data and index are stored together at leaf node


## Disadvantages of Clustered index

+ Data insertion speed is dependent on the order of the Primary key
  + Table needs to optmize if inserted data is not ordered by Primary key
+ Clustered index have minimal impact for in memory data
+ Updating the clustered index column is expensive as data is moved based on its size to different location
+ Page split occurs when new data is inserted leading to fragmentation
+ Secondary index contains the location of the clustered index instead of row pointer, hence the size is larger

## Secondary Index

+ An index which is not clustered index is called as a secondary index
+ Secondeary index in Innodb does not store actual data but only contains the pointer to the data
+ If there is a clustered index on the table
  + Secondary index will contain the pointer to clustered index
+ If there is no clustered index on the table
  + Secondeary index will contain the row pointer

## Hash Index

+ Hash index is built on a hash table
+ Increases performance for exact lookups
+ For each row a hash code is generated
  + Generally different keys generate different hash code
  + Stores hash codes in index with pointer to each row in a hash table
  + If multiple values hase same hash code, it will also contain their row pointers in linked list
+ Memory sotrage engine in MySQL supports explicit hash tables
+ Very fast and effective as it reside in Memory


## Limitation of hash Index

+ As hash index does not contain original data it is not effective in 
  + Sorting
  + No PartialMatching
+ Only support Equal To ('=') operator
+ Multiple values with same hash code, it will result in slow performance
  + Storage engine will follow each row pointer in the linked list and compare the value to the lookup values
  + Slow maintaince


## Adaptive hash index

+ InnoDB storeage engine supports  adaptive hash index
+ This is automatic process and no control/configuration
  + Possible to disable
+ Hash Indexes are built in memory on the top of frequently used B-tree indexes
+ Adaptive Hash index gives B-Tree indexes very fast hashed lookups for improved performance


> Note: You can simulate Hash Indexws on the unsupported storage engine

+

