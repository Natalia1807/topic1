1. Îñ Windows.
2. Create database example;
   use example
   Create table users (
   id SERIAL PRIMARY KEY,
   name varchar(50));
   Create database smple;
3. mysqldump mysql example > example.sql 
   mysql sample < example.sql
4.mysqldump mysql --where="true limit 100" mysql help_keyword > help_keyword.sql

