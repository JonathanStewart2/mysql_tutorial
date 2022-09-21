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
order_date TIMESTAMP,
customer INT NOT NULL,
items INT NOT NULL,
price DECIMAL(6,2) NOT NULL,
order_complete BOOLEAN,
discount_code DECIMAL(4,2),
PRIMARY KEY(id),
FOREIGN KEY(customer) REFERENCES customers(id),
FOREIGN KEY(items) REFERENCES menu(id)
);





################ DML COMMANDS #################
# INSERT INTO, SELECT, UPDATE, DELETE

#### CUSTOMERS #####
INSERT INTO customers(
first_name, last_name, phone, address, postcode, email)
VALUES (
"Jimbob", 
"McGraw", 
"07774445555",  
"123 Fake Street",
"PA5 LA3",
"jimbobmcgraw@email.com"
),
(
"Jane", 
"Smith", 
"01415558877",  
"69 Donald Trump Avenue",
"NY5 1XA",
"jimbobmcgraw@email.com"
),
(
"Harry", 
"Potter", 
"07896541234",  
"4 Privet Drive",
"SW12 EXL",
"harrypotter@gryffindor.com"
),
(
"Hermione", 
"Granger", 
"07891234567",  
"55 Whatever Avenue",
"M15 GE3",
"hermione@granger.com"
),
(
"Ron", 
"Weasley", 
"07774441111",  
"1 Weasley Manor",
"GF14 3EP",
"ron.weasley@aol.com"
);


#### MENU ITEMS #####
INSERT INTO menu(
item, price, image_url, allergens, calories)
VALUES(
"Quorn Chicken Burger",
12.99,
"https://www.qa-restaurant.com/qcbimg.png",
"sesame seeds",
659
),
(
"Spinach Goulash",
10.86,
"https://www.qa-restaurant.com/spingouimg.png",
"pine nuts, cashews",
498
),
(
"Halloumi Kebab",
13.60,
TRUE,
"https://www.qa-restaurant.com/hallhathnofury.png",
"walnuts",
713
);






