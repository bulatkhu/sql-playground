-- create table customers (cid int primary key, customer_name varchar(40));
-- insert into customers values (1, 'John Doe'), (2, 'Jane Smith'), (3, 'Alice Brown');
-- alter table customers alter column cid SET GENERATED ALWAYS AS IDENTITY;
drop table if exists customers cascade;
create table customers (
    cid int primary key generated always as identity,
    customer_name varchar(40)
);
insert into customers (customer_name)
values ('John Doe'), ('Jane Smith'), ('Alice Brown');


drop table if exists orders;
create table orders (
    order_id int primary key generated BY DEFAULT as identity,
    order_date Date,
    customer_id INT,
    amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(cid) ON DELETE CASCADE
);
alter SEQUENCE orders_order_id_seq RESTART WITH 101;

insert into orders (order_date, customer_id, amount) values
    ('2023-01-10', 1, 250.00),
    ('2023-01-15', 2, 150.00),
    ('2023-01-20', 3, 300.00),
    ('2023-01-25', 1, 175.00)
returning *;

SELECT * from customers
INNER JOIN orders on orders.customer_id=customers.cid;
-- cid     customer_name   order_id    order_date      customer_id     amount
-- 1       John Doe        101         2023-01-10      1               250.00
-- 2       Jane Smith      102         2023-01-15      2               150.00
-- 3       Alice Brown     103         2023-01-20      3               300.00
-- 1       John Doe        104         2023-01-25      1               175.00

-- SELECT * from customers
-- LEFT JOIN orders on orders.customer_id=customers.cid;
-- cid     customer_name   order_id    order_date      customer_id     amount
-- 1       John Doe        101         2023-01-10      1               250.00
-- 2       Jane Smith      102         2023-01-15      2               150.00
-- 3       Alice Brown     103         2023-01-20      3               300.00
-- 1       John Doe        104         2023-01-25      1               175.00


-- SELECT * from customers
-- RIGHT JOIN orders on orders.customer_id=customers.cid;
-- cid     customer_name   order_id    order_date      customer_id     amount
-- 1       John Doe        101         2023-01-10      1               250.00
-- 2       Jane Smith      102         2023-01-15      2               150.00
-- 3       Alice Brown     103         2023-01-20      3               300.00
-- 1       John Doe        104         2023-01-25      1               175.00


-- SELECT * from customers
-- FULL JOIN orders on orders.customer_id=customers.cid;

BEGIN;
savepoint before_delete;
SELECT * from customers
INNER JOIN orders on orders.customer_id=customers.cid;
SELECT * from orders;

delete from customers where cid = 1;
SELECT * from customers
INNER JOIN orders on orders.customer_id=customers.cid;
SELECT * from orders;

rollback;
SELECT * from customers
INNER JOIN orders on orders.customer_id=customers.cid;
SELECT * from orders;
COMMIT;


BEGIN;
savepoint before_delete;
SELECT * from customers
INNER JOIN orders on orders.customer_id=customers.cid;
SELECT * from orders;

delete from customers where cid = 2;
SELECT * from customers
INNER JOIN orders on orders.customer_id=customers.cid;
SELECT * from orders;

rollback;
SELECT * from customers
INNER JOIN orders on orders.customer_id=customers.cid;
SELECT * from orders;
COMMIT;


BEGIN;
savepoint before_delete;
SELECT * from customers
                  INNER JOIN orders on orders.customer_id=customers.cid;

delete from customers where cid = 3;
SELECT * from customers
                  INNER JOIN orders on orders.customer_id=customers.cid;

rollback;
SELECT * from customers
                  INNER JOIN orders on orders.customer_id=customers.cid;
COMMIT;