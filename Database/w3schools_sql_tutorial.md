# SQL Tutorial

## Introduction to SQL

## SQL Syntax

下面的数据是表 `Customers` 中的一些数据

| CustomerID |            CustomerName            |    ContactName     |            Address            |    City     | PostalCode | Country |
| :--------: | :--------------------------------: | :----------------: | :---------------------------: | :---------: | :--------: | :-----: |
|     1      |        Alfreds Futterkiste         |    Maria Anders    |         Obere Str. 57         |   Berlin    |   12209    | Germany |
|     2      | Ana Trujillo Emparedados y helados |    Ana Trujillo    | Avda. de la Constitución 2222 | México D.F. |   05021    | Mexico  |
|     3      |      Antonio Moreno Taquería       |   Antonio Moreno   |        Mataderos 2312         | México D.F. |   05023    | Mexico  |
|     4      |          Around the Horn           |    Thomas Hardy    |        120 Hanover Sq.        |   London    |  WA1 1DP   |   UK    |
|     5      |         Berglunds snabbköp         | Christina Berglund |        Berguvsvägen 8         |    Luleå    |  S-958 22  | Sweden  |



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
```

## SQL SELECT DISTINCT Statement

查找非重复数据

```sql
SELECT DISTINCT column1, column2, ...
FROM table_name;

# SELECT Example
SELECT Country FROM Customers;
```

### SELECT DISTINCT Examples

```sql
SELECT DISTINCT Country FROM Customers;
```

列出非重复数据有多少个
```sql
SELECT COUNT(DISTINCT Country) FROM Customers;
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

| Operator |               Description                |
| :------: | :--------------------------------------: |
|    =     |                  Equal                   |
|    <>    | Not equal. <b>Note:</b> In some versions of SQL this operator may be written as != |
|    >     |               Greater than               |
|    <     |                Less than                 |
|    >=    |          Greater than or equal           |
|    <=    |            Less than or equal            |
| BETWEEN  |        Between an inclusive range        |
|   LIKE   |           Search for a pattern           |
|    IN    | To specify multiple possible values for a column |

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

## SQL NULL Values

null就是没有值，不能使用一般的比较操作符

```sql
# IS NULL Syntax
SELECT column_names
FROM table_name
WHERE column_name IS NULL;

# IS NOT NULL Syntax
SELECT column_names
FROM table_name
WHERE column_name IS NOT NULL;
```

## SQL UPDATE Statement

注意使用`update`的时候一定不要漏了`where`

```sql
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;
```

## The SQL DELETE Statement

注意使用`delete`的时候一定不要漏了`where`


```sql
DELETE FROM table_name
WHERE condition;
```

## SQL TOP, LIMIT or ROWNUM Clause

```sql
# SQL Server / MS Access Syntax:
SELECT TOP number|percent column_name(s)
FROM table_name
WHERE condition;

# MySQL Syntax:
SELECT column_name(s)
FROM table_name
WHERE condition
LIMIT number;

# Oracle Syntax:
SELECT column_name(s)
FROM table_name
WHERE ROWNUM <= number;
```

```sql
# Example
SELECT TOP 3 * FROM Customers;
SELECT * FROM Customers LIMIT 3;
SELECT * FROM Customers WHERE ROWNUM <= 3;

# SQL TOP PERCENT Example 取前50％
SELECT TOP 50 PERCENT * FROM Customers;
```

## SQL MIN() and MAX() Functions

```sql
# MIN() Syntax
SELECT MIN(column_name)
FROM table_name
WHERE condition;

# MAX() Syntax
SELECT MAX(column_name)
FROM table_name
WHERE condition;
```

```sql
#Example
SELECT MIN(Price) AS SmallestPrice FROM Products;
```

## SQL COUNT(), AVG() and SUM() Functions

`count`可以直接`count(0)`

```sql
# COUNT() Syntax
SELECT COUNT(column_name)
FROM table_name
WHERE condition;

# AVG() Syntax
SELECT AVG(column_name)
FROM table_name
WHERE condition;

# SUM() Syntax
SELECT SUM(column_name)
FROM table_name
WHERE condition;
```

## SQL LIKE Operator

`LIKE`操作符是匹配字符串的，一共有两个通配符
- `%` 0 / 1 / 多 个字符
- `_` 单个字符

> MS Access 中
> - 使用 `?` 代替 `_`
> - [abc] - abc中的一个
> - [^abc] or [!abc] - 不属于abc的一个


```sql
SELECT column1, column2, ...
FROM table_name
WHERE columnN LIKE pattern;
```

## SQL IN Operator

```sql
# IN Syntax
SELECT column_name(s)
FROM table_name
WHERE column_name IN (value1, value2, ...);

# or
SELECT column_name(s)
FROM table_name
WHERE column_name IN (SELECT STATEMENT);
```

```sql
# example
SELECT * FROM Customers WHERE Country IN ('Germany', 'France', 'UK');

SELECT * FROM Customers WHERE Country IN (SELECT Country FROM Suppliers);
```

## SQL BETWEEN Operator

```sql
SELECT column_name(s)
FROM table_name
WHERE column_name BETWEEN value1 AND value2;
```

```sql
#Example
SELECT * FROM Products WHERE Price BETWEEN 10 AND 20;

# NOT BETWEEN Example
SELECT * FROM Products WHERE Price NOT BETWEEN 10 AND 20;

# BETWEEN with IN Example
SELECT * FROM Products WHERE (Price BETWEEN 10 AND 20) AND NOT CategoryID IN (1,2,3);

# BETWEEN Text Values Example
SELECT * FROM Products WHERE ProductName BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni' ORDER BY ProductName;

# NOT BETWEEN Text Values Example
SELECT * FROM Products WHERE ProductName NOT BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni' ORDER BY ProductName;

# BETWEEN Dates Example
SELECT * FROM Orders WHERE OrderDate BETWEEN #07/04/1996# AND #07/09/1996#;
```

## SQL Aliases

```sql
# Alias Column Syntax
SELECT column_name AS alias_name FROM table_name;

# Alias Table Syntax
SELECT column_name(s) FROM table_name *AS *alias_name;
```

```sql
# example
SELECT CustomerName AS Customer, ContactName AS `Contact Person` FROM Customers;

SELECT CustomerName, CONCAT(Address,', ',PostalCode,', ',City,', ',Country) AS Address FROM Customers;

# to make the SQL shorter
SELECT o.OrderID, o.OrderDate, c.CustomerName
FROM Customers AS c, Orders AS o
WHERE c.CustomerName="Around the Horn" AND c.CustomerID=o.CustomerID;
```

使用别名的好处

- 在一次query中有超过一个table
- 在query中使用了function
- 列名太长或不可读
- 多列拼接起来了



## SQL Joins

sql join 是通过向关联的列将多个table的rows拼起来

Orders

| OrderID | CustomerID | OrderDate  |
| :-----: | :--------: | :--------: |
|  10308  |     2      | 1996-09-18 |
|  10309  |     37     | 1996-09-19 |
|  10310  |     77     | 1996-09-20 |

Customers
| CustomerID |            CustomerName            |  ContactName   | Country |
| :--------: | :--------------------------------: | :------------: | :-----: |
|     1      |        Alfreds Futterkiste         |  Maria Anders  | Germany |
|     2      | Ana Trujillo Emparedados y helados |  Ana Trujillo  | Mexico  |
|     3      |      Antonio Moreno Taquería       | Antonio Moreno | Mexico  |

```sql
# 上面两个表通过CustomerID关联起来了
SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate
FROM Orders
INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID;
```

几个join的区别

- **(INNER) JOIN** : Returns records that have matching values in both tables
- **LEFT (OUTER) JOIN** : Return all records from the left table, and the matched records from the right table
- **RIGHT (OUTER) JOIN** : Return all records from the right table, and the matched records from the left table
- **FULL (OUTER) JOIN** : Return all records when there is a match in either left or right table

- inner join
![img_innerjoin](./img/img_innerjoin.gif)

```sql
SELECT column_name(s)
FROM table1
INNER JOIN table2 ON table1.column_name = table2.column_name;

# example
SELECT Orders.OrderID, Customers.CustomerName
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

# join three tables
SELECT Orders.OrderID, Customers.CustomerName, Shippers.ShipperName
FROM ((Orders INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID)
INNER JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID);
```

- left join
![img_leftjoin](./img/img_leftjoin.gif)

看图，好像和直接查左边的表没什么区别。

但是实际query的结果里面，是含有第二个表的数据的

```sql
SELECT column_name(s)
FROM table1
LEFT JOIN table2 ON table1.column_name = table2.column_name;

# example
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
ORDER BY Customers.CustomerName;
```

- right join
![img_rightjoin](./img/img_rightjoin.gif)

```sql
SELECT column_name(s)
FROM table1
RIGHT JOIN table2 ON table1.column_name = table2.column_name;

# example
SELECT Orders.OrderID, Employees.LastName, Employees.FirstName
FROM Orders
RIGHT JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
ORDER BY Orders.OrderID;
```

- full join
![img_fulljoin](./img/img_fulljoin.gif)

```sql
SELECT column_name(s)
FROM table1
FULL OUTER JOIN table2 ON table1.column_name = table2.column_name;

# example
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
FULL OUTER JOIN Orders ON Customers.CustomerID=Orders.CustomerID
ORDER BY Customers.CustomerName;
```

- SQL Self JOIN

```sql
SELECT column_name(s)
FROM table1 T1, table1 T2
WHERE condition;

# example
SELECT A.CustomerName AS CustomerName1, B.CustomerName AS CustomerName2, A.City
FROM Customers A, Customers B
WHERE A.CustomerID <> B.CustomerID
AND A.City = B.City
ORDER BY A.City;
```

## The SQL UNION Operator

union语法用于将多个query的result-set拼起来
- 每一个select必须有一样数目的列
- 对应的列需要有一样的数据类型
- 每个select需要有一样的order

```sql
# UNION Syntax
SELECT column_name(s) FROM table1
UNION
SELECT column_name(s) FROM table2;

# UNION ALL Syntax
# UNION只会返回唯一的数据，为了使得所有数据都返回，需要使用 all
SELECT column_name(s) FROM table1
UNION ALL
SELECT column_name(s) FROM table2;

# 返回的列名等于第一个select的列名
```

```sql
#SQL UNION Example
SELECT City FROM Customers
UNION
SELECT City FROM Suppliers
ORDER BY City;

# SQL UNION ALL Example
SELECT City FROM Customers
UNION ALL
SELECT City FROM Suppliers
ORDER BY City;

# SQL UNION With WHERE
SELECT City, Country FROM Customers
WHERE Country='Germany'
UNION
SELECT City, Country FROM Suppliers
WHERE Country='Germany'
ORDER BY City;

# SQL UNION ALL With WHERE
SELECT City, Country FROM Customers
WHERE Country='Germany'
UNION ALL
SELECT City, Country FROM Suppliers
WHERE Country='Germany'
ORDER BY City;

# Another UNION Example
SELECT 'Customer' As Type, ContactName, City, Country
FROM Customers
UNION
SELECT 'Supplier', ContactName, City, Country
FROM Suppliers;
```

## SQL GROUP BY Statement

group 是为了聚合一些数据后使用`functions (COUNT, MAX, MIN, SUM, AVG)`

```sql
SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
ORDER BY column_name(s);
```

```sql
# example
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country;

SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
ORDER BY COUNT(CustomerID) DESC;

# GROUP BY With JOIN Example
SELECT Shippers.ShipperName, COUNT(Orders.OrderID) AS NumberOfOrders FROM Orders
LEFT JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID
GROUP BY ShipperName;
```

## SQL HAVING Clause

添加`having`是因为`where`中不能使用函数，需要在`having`后使用

```sql
SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
HAVING condition
ORDER BY column_name(s);
```


```sql
# Only include countries with more than 5 customers
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5;

# sorted high to low (Only include countries with more than 5 customers)
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5
ORDER BY COUNT(CustomerID) DESC;

# have registered more than 10 orders
SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders
FROM (Orders
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID)
GROUP BY LastName
HAVING COUNT(Orders.OrderID) > 10;

# if the employees "Davolio" or "Fuller" have registered more than 25 orders
SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders
FROM Orders
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE LastName = 'Davolio' OR LastName = 'Fuller'
GROUP BY LastName
HAVING COUNT(Orders.OrderID) > 25;
```