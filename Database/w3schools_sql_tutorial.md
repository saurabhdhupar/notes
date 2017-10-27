# SQL Tutorial

## Introduction to SQL

## SQL Syntax

下面的数据是表 `Customers` 中的一些数据

| CustomerID | CustomerName | ContactName | Address | City | PostalCode | Country |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| 1 | Alfreds Futterkiste | Maria Anders | Obere Str. 57 | Berlin | 12209 | Germany |
| 2 | Ana Trujillo Emparedados y helados | Ana Trujillo | Avda. de la Constitución 2222 | México D.F. | 05021 | Mexico |
| 3 | Antonio Moreno Taquería | Antonio Moreno | Mataderos 2312 | México D.F. | 05023 | Mexico |
| 4 | Around the Horn | Thomas Hardy | 120 Hanover Sq. | London | WA1 1DP | UK |
| 5 | Berglunds snabbköp | Christina Berglund | Berguvsvägen 8 | Luleå | S-958 22 | Sweden |



不区分大小写

一些命令

- **SELECT** extracts data from a database
- **UPDATE** updates data in a database
- **DELETE** deletes data from a database
- **INSERT INTO** inserts new data into a database
- **CREATE DATABASE** creates a new database
- **ALTER DATABASE** modifies a database
- **CREATE TABLE** creates a new table
- **ALTER TABLE** modifies a table
- **DROP TABLE** deletes a table
- **CREATE INDEX** creates an index (search key)
- **DROP INDEX** deletes an index

## SQL SELECT Statement

查语法

```sql
SELECT column1, column2, ...
FROM table_name;
```

* 是查所有列
```sql
SELECT * FROM table_name;

+--------------+------------------------------------+--------------------+-------------------------------+-------------+--------------+-----------+
|   CustomerID | CustomerName                       | ContactName        | Address                       | City        | PostalCode   | Country   |
|--------------+------------------------------------+--------------------+-------------------------------+-------------+--------------+-----------|
|            1 | Alfreds Futterkiste                | Maria Anders       | Obere Str. 57                 | Berlin      | 12209        | Germany   |
|            2 | Ana Trujillo Emparedados y helados | Ana Trujillo       | Avda. de la Constitución 2222 | México D.F. | 05021        | Mexico    |
|            3 | Antonio Moreno Taquería            | Antonio Moreno     | Mataderos 2312                | México D.F. | 05023        | Mexico    |
|            4 | Around the Horn                    | Thomas Hardy       | 120 Hanover Sq.               | London      | WA1 1DP      | UK        |
|            5 | Berglunds snabbköp                 | Christina Berglund | Berguvsvägen 8                | Luleå       | S-958 22     | Sweden    |
+--------------+------------------------------------+--------------------+-------------------------------+-------------+--------------+-----------+
```

## SQL SELECT DISTINCT Statement

查找非重复数据

```sql
SELECT DISTINCT column1, column2, ...
FROM table_name;
```

### SELECT Example

```sql
SELECT Country FROM Customers;

+-----------+
| Country   |
|-----------|
| Germany   |
| Mexico    |
| Mexico    |
| UK        |
| Sweden    |
+-----------+
```

### SELECT DISTINCT Examples

```sql
SELECT DISTINCT Country FROM Customers;

+-----------+
| Country   |
|-----------|
| Germany   |
| Mexico    |
| UK        |
| Sweden    |
+-----------+
```

列出非重复数据有多少个
```sql
SELECT COUNT(DISTINCT Country) FROM Customers;

+---------------------------+
|   COUNT(DISTINCT Country) |
|---------------------------|
|                         4 |
+---------------------------+
```

上面那个对于ms db不起作用，需要使用下面的语法
```sql
SELECT Count(*) AS DistinctCountries
FROM (SELECT DISTINCT Country FROM Customers);
```

## SQL WHERE Clause

where 是条件限制语法
```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```

字符串需要使用单引号括起来，数字类型不需要

where 中使用的比较

| Operator | Description |
| :---: | :---: |
| = | Equal |
| <> | Not equal. <b>Note:</b> In some versions of SQL this operator may be written as != |
| > | Greater than |
| < | Less than |
| >= | Greater than or equal |
| <= | Less than or equal |
| BETWEEN | Between an inclusive range |
| LIKE | Search for a pattern |
| IN | To specify multiple possible values for a column |

## SQL AND, OR and NOT Operators

### AND Syntax
```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition1 AND condition2 AND condition3 ...;
```
### OR Syntax
```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition1 OR condition2 OR condition3 ...;
```
### NOT Syntax
```sql
SELECT column1, column2, ...
FROM table_name
WHERE NOT condition;
```

组合这些条件 AND, OR and NOT

```sql
SELECT * FROM Customers
WHERE Country='Germany' AND (City='Berlin' OR City='München');

SELECT * FROM Customers
WHERE NOT Country='Germany' AND NOT Country='USA';
```

## SQL ORDER BY Keyword

按照 ascending or descending 的顺序对结果排序

```sql
SELECT column1, column2, ...
FROM table_name
ORDER BY column1, column2, ... ASC|DESC;
```

```sql
# example
SELECT * FROM Customers ORDER BY Country;

# desc example
SELECT * FROM Customers ORDER BY Country DESC;

# 多列 order
SELECT * FROM Customers ORDER BY Country, CustomerName;

# 多列 order 加 asc， desc
SELECT * FROM Customers ORDER BY Country ASC, CustomerName DESC;
```

## SQL INSERT INTO Statement

插入语法

```sql
INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1, value2, value3, ...);

# 如果所有的列都有，然后就可以省略列名，但是要注意顺序不要错了
INSERT INTO table_name
VALUES (value1, value2, value3, ...);
```

```sql
# example
INSERT INTO Customers (CustomerName, City, Country) VALUES ('Cardinal', 'Stavanger', 'Norway');
```