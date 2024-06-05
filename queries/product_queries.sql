-- Given the following products table:
-- product_id  product_name    price   stock_quantity
-- 1	        Laptop      	1000    50
-- 2	        Smartphone      700     150
-- 3	        Tablet      	300     200
-- 4	        Headphones      100     300
-- 5	        Charger     	20      500

drop table products;

create table products (
  product_id int primary key generated always as identity,
  product_name varchar(100),
  price int not null,
  stock_quantity int
);

insert into products (product_name, price, stock_quantity) values
    ('Laptop',      1000,   50),
    ('Smartphone',  700,    150),
    ('Tablet',      300,    200),
    ('Headphones',  100,    300),
    ('Charger',     20,     500);

select * from products;

begin;

SAVEPOINT my_savepoint;
delete from products where stock_quantity < 100;
select * from products;
-- product_id  product_name    price   stock_quantity
-- 2	        Smartphone      700     150
-- 3	        Tablet      	300     200
-- 4	        Headphones      100     300
-- 5	        Charger     	20      500

rollback to my_savepoint;
select * from products;
-- product_id  product_name    price   stock_quantity
-- 1	        Laptop      	1000    50
-- 2	        Smartphone      700     150
-- 3	        Tablet      	300     200
-- 4	        Headphones      100     300
-- 5	        Charger     	20      500

commit;