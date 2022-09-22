CREATE DATABASE qa3;
USE qa3;

#### TABLES #####
CREATE TABLE customers(
id INT UNIQUE NOT NULL AUTO_INCREMENT,
first_name VARCHAR(255) DEFAULT "unknown",
last_name VARCHAR(255) DEFAULT "unknown",
phone VARCHAR(11) NOT NULL,
address VARCHAR(255) DEFAULT "collection",
postcode VARCHAR(10) DEFAULT "collection",
email VARCHAR(255),
PRIMARY KEY(id)
);

CREATE TABLE menu(
id INT UNIQUE NOT NULL AUTO_INCREMENT,
item VARCHAR(255) NOT NULL,
price DECIMAL(5,2) NOT NULL,
available BOOLEAN,
image_url VARCHAR(255) NOT NULL,
allergens VARCHAR(255) NOT NULL,
calories INT NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE orders(
id INT UNIQUE NOT NULL AUTO_INCREMENT,
order_date TIMESTAMP DEFAULT NOW(),
customer INT NOT NULL,
price DECIMAL(6,2) NOT NULL,
order_complete BOOLEAN,
discount_code DECIMAL(4,2),
PRIMARY KEY(id),
FOREIGN KEY(customer) REFERENCES customers(id) ON DELETE CASCADE
);

CREATE TABLE order_items(
id INT UNIQUE NOT NULL AUTO_INCREMENT,
order_id INT NOT NULL,
item_id INT NOT NULL,
quantity INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
FOREIGN KEY (item_id) REFERENCES menu(id) ON DELETE CASCADE
);


#### CUSTOMERS #####
INSERT INTO customers(
first_name, last_name, phone, address, postcode, email)
VALUES
("Jimbob", "McGraw", "07774445555", "123 Fake Street", "PA5 LA3","jimbobmcgraw@email.com"),
("Jane", "Smith", "01415558877",  "69 Donald Trump Avenue", "NY5 1XA","jimbobmcgraw@email.com"),
("Harry", "Potter", "07896541234",  "4 Privet Drive","SW12 EXL","harrypotter@gryffindor.com"),
("Hermione", "Granger", "07891234567",  "55 Whatever Avenue","M15 GE3","hermione@granger.com"),
("Ron", "Weasley", "07774441111",  "1 Weasley Manor", "GF14 3EP", "ron.weasley@aol.com");

SELECT * FROM customers;


#### MENU ITEMS #####
INSERT INTO menu(item, price, available, image_url, allergens, calories)
VALUES
("Quorn Chicken Burger",12.99,FALSE,"https://www.qa-res.com/qcbimg.png","sesame seeds",659),
("Spinach Goulash",10.86,TRUE,"https://www.qa-res.com/spingouimg.png","pine nuts, cashews",498),
("Halloumi Kebab",13.60,TRUE,"https://www.qa-res.com/hallhathnofury.png","walnuts",713),
("Falafel",12.33,FALSE,"https://www.qa-res.com/falafull.jpg","pine nuts",943),
("Mushroom Risotto",7.00,TRUE,"https://www.qa-res.com/musherris.jpg","gluten",687);

SELECT * FROM menu;


### ADDING ORDERS ###
INSERT INTO orders(customer, price, order_complete, discount_code)
VALUES
(3, 7.00,TRUE,0),
(5,13.6,TRUE,0.1),
(3,12.99,FALSE,0),
(1,10.86,TRUE,0.25),
(1,7.00,TRUE,0.25);

SELECT * FROM orders;

### ADDING ORDER ITEMS ###
INSERT INTO order_items(order_id, item_id, quantity)
VALUES
(1,5,1),
(2,3,1),
(3,1,1),
(4,2,1),
(5,5,1);

SELECT * FROM order_items;


### MAKING UPDATES TO TABLES ###
SELECT * FROM customers;

UPDATE customers
SET first_name="Draco", last_name="Malfoy"
WHERE id=1;

SELECT * FROM customers;


### ADD 2 NEW ORDERS  ###
SELECT * FROM orders;

INSERT INTO orders(customer, price, order_complete, discount_code)
VALUES
(1, 14.00, TRUE, 0),
(1, 25.98, TRUE, 0);

SELECT * FROM orders;

SELECT * FROM order_items;

INSERT INTO order_items(order_id, item_id, quantity)
VALUES
(6,5,2),
(7,1,2);

SELECT * FROM order_items;

### DELETE THE FINAL ORDER ###
#DELETE FROM orders WHERE id=7; #cannot delete as parent
DELETE FROM order_items WHERE id=7;
DELETE FROM orders WHERE id=7;

SELECT * FROM orders;
SELECT * FROM order_items;

#### VIEWING RECORDS ####
SELECT first_name FROM customers WHERE last_name="Potter";
SELECT * FROM menu WHERE price>10.00;
SELECT * FROM menu WHERE available IS TRUE;
SELECT * FROM menu WHERE available != TRUE;
SELECT * FROM menu WHERE price > 10.00 AND price < 11.00;
SELECT * FROM menu WHERE price BETWEEN 10.00 AND 12.33;
SELECT * FROM menu WHERE item LIKE "%ash";
SELECT * FROM menu WHERE item LIKE "%a%";
SELECT * FROM menu WHERE allergens LIKE "%nut%";

SELECT DISTINCT id FROM order_items;
SELECT DISTINCT customer FROM orders;

### ORDERING DATA
SELECT * FROM menu ORDER BY item; #ascending automatically, or can state ASC
SELECT * FROM menu ORDER BY item DESC;

#LIMITING DATA#
SELECT * FROM menu LIMIT 2;
SELECT * FROM menu ORDER BY id DESC LIMIT 2;
SELECT * FROM menu WHERE price BETWEEN 10.00 AND 12.50 ORDER BY id DESC;
SELECT * FROM customers ORDER BY last_name DESC LIMIT 3;

SELECT id FROM orders ORDER BY order_date LIMIT 4;
SELECT DISTINCT customer FROM orders ORDER BY customer DESC;
SELECT DISTINCT order_id FROM order_items ORDER BY order_id DESC LIMIT 3;


SELECT first_name, last_name FROM customers WHERE address LIKE "%Drive";
SELECT * FROM customers WHERE email LIKE "%@granger%";
SELECT phone FROM customers WHERE email LIKE "%@%" ORDER BY id DESC;

# NOT WORKING
#SELECT * FROM order_items IF COUNT(item_id) > 1;
#SELECT id, item_id FROM order_items WHERE COUNT(SELECT DISTINCT item_id FROM order_items) > 1;

### AGGREGATE FUNCTIONS ###
SELECT AVG(price) FROM menu;
SELECT MIN(price) FROM menu;
SELECT MAX(price) FROM menu;
SELECT SUM(price) FROM orders;
SELECT COUNT(id) FROM customers;

### NESTED QUERIES ###
SELECT customer FROM orders WHERE id = 5; # returns 1
SELECT * FROM customers WHERE id = 1;
## Combine both select statements:
SELECT * FROM customers WHERE id=(SELECT customer FROM orders WHERE id=5);

SELECT item_id FROM order_items WHERE id = 1; #returns 5
SELECT * FROM menu WHERE id = 5; # returns mushroom risottor
# combine both statements to give:
SELECT * FROM menu WHERE id = (SELECT item_id FROM order_items WHERE id = 1);

### JOINS ###
### INNER JOIN - default,combines based on data present in both tables
SELECT * FROM customers
JOIN orders ON customers.id = orders.customer;

SELECT first_name, last_name, order_date FROM customers
JOIN orders ON customers.id = orders.customer;

#Abbreviated table names
SELECT c.id, o.id FROM customers c
JOIN orders o ON c.id = o.customer;

### OUTER JOINS: 2 types, LEFT OUTER JOIN and RIGHT OUTER JOIN
#LEFT OUTER JOIN: customers table looking for records to match in the orders table, no match returns NULL
SELECT * FROM customers c
LEFT OUTER JOIN orders o ON c.id = o.customer;
#RIGHT OUTER JOIN
SELECT * FROM customers c
RIGHT OUTER JOIN orders o ON c.id = o.customer;

# Display all customers who ordered something (INNER JOIN)
SELECT * FROM customers c
JOIN orders o ON c.id = o.customer
JOIN order_items oi ON  o.id=oi.order_id
JOIN menu m ON oi.item_id=m.id;

SELECT c.email, m.item, o.price, oi.quantity FROM customers c
JOIN orders o ON c.id = o.customer
JOIN order_items oi ON  o.id=oi.order_id
JOIN menu m ON oi.item_id=m.id;

# also include customers who didnt place an order
SELECT * FROM customers c
LEFT OUTER JOIN orders o ON c.id = o.customer
LEFT OUTER JOIN order_items oi ON  o.id=oi.order_id
LEFT OUTER JOIN menu m ON oi.item_id=m.id;