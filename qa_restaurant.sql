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
FOREIGN KEY(customer) REFERENCES customers(id)
);

CREATE TABLE order_items(
id INT UNIQUE NOT NULL AUTO_INCREMENT,
order_id INT NOT NULL,
item_id INT NOT NULL,
quantity INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (order_id) REFERENCES orders(id),
FOREIGN KEY (item_id) REFERENCES menu(id)
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

SELECT * FROM order_items;
### ADDING ORDER ITEMS ###
INSERT INTO order_items(order_id, item_id, quantity)
VALUES
(1,5,1),
(2,3,1),
(3,1,1),
(4,2,1),
(5,5,1);

SELECT * FROM order_items;


