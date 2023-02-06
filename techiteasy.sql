DROP TABLE IF EXISTS television_remotecontrollers;
DROP TABLE IF EXISTS television_brackets;
DROP TABLE IF EXISTS brackets CASCADE;
DROP TABLE IF EXISTS ci_modules;
DROP TABLE IF EXISTS remote_controllers;
DROP TABLE IF EXISTS televisions ;

CREATE TABLE televisions(
	id serial PRIMARY KEY,
	name varchar(255) NOT NULL UNIQUE,
	brand varchar (255) NOT NULL,
	purchase_price decimal,
	sale_price decimal,
	current_stock bigint,
	sold_stock_last_month bigint,
	screen_type varchar(255) NOT NULL,
	wifi boolean DEFAULT true,
	smart_tv boolean DEFAULT true,
	refresh_rate varchar(255) NOT NULL,
	screen_size varchar(255)
);

INSERT INTO televisions (name, brand, purchase_price, sale_price, current_stock, sold_stock_last_month, screen_type, wifi, smart_tv, refresh_rate, screen_size)
	VALUES ('51hkagj21B', 'SAMSUNG', 999.99, 1499.99 , 3, 1,'QLED', true, true, '60hz', '53 inch'),
		   ('52hkagj21B', 'SAMSUNG', 1000, 1599.99 , 3, 1,'QLED', true, true, '60hz', '51 inch');




CREATE TABLE remote_controllers(
	id serial PRIMARY KEY,
	name varchar(255) NOT NULL,
	brand varchar (255) NOT NULL,
	purchase_price decimal,
	sale_price decimal,
	current_stock bigint,
	sold_stock_last_month bigint,
	compatible_with varchar(255),
	battery_type varchar(255),
	television_id int,
	CONSTRAINT fk_television FOREIGN KEY (television_id) REFERENCES televisions(id)
);

INSERT INTO remote_controllers (name, brand, purchase_price, sale_price, current_stock, sold_stock_last_month, compatible_with, battery_type)
	VALUES ('samsung remote', 'Samsung', 13.99 , 21.99, 5,1, 'samsung', '2x aa');

CREATE TABLE ci_modules(
	id serial PRIMARY KEY,
	name varchar(255) NOT NULL,
	brand varchar (255) NOT NULL,
	purchase_price decimal,
	sale_price decimal,
	current_stock bigint,
	sold_stock_last_month bigint,
	ci_plus boolean DEFAULT false
);
INSERT INTO ci_modules(name, brand, purchase_price, sale_price, current_stock, sold_stock_last_month, ci_plus)
	VALUES ('ziggo', 'ziggo', 13.95 , 30,30,2,True);

CREATE TABLE brackets(
	id serial PRIMARY KEY,
	name varchar(255) NOT NULL,
	brand varchar (255) NOT NULL,
	purchase_price decimal,
	sale_price decimal,
	current_stock bigint,
	sold_stock_last_month bigint,
	adjustable boolean DEFAULT true,
	size varchar(255)
);

INSERT INTO brackets(name, brand, purchase_price, sale_price, current_stock, sold_stock_last_month, adjustable, size)
	VALUES ('all size fits', 'wallbracket', 36.12, 59.99, 12,20,true, '51 inch'),
		('bigsizefits', 'floorbracket', 16.12, 89.99, 2,0,false, '53 inch');


CREATE TABLE television_brackets(
	id serial PRIMARY KEY,
	television_id int,
	bracket_id int,
	CONSTRAINT fk_television FOREIGN KEY (television_id) REFERENCES televisions(id),
	CONSTRAINT fk_bracket FOREIGN KEY (bracket_id) REFERENCES brackets(id)
);

INSERT INTO television_brackets (television_id, bracket_id)
VALUES 
  ((SELECT id FROM televisions WHERE screen_size='51 inch'), 
   (SELECT id FROM brackets WHERE size='51 inch')),
  ((SELECT id FROM televisions WHERE screen_size='53 inch'), 
   (SELECT id FROM brackets WHERE size='53 inch'));




CREATE TABLE television_remotecontrollers (
  id serial PRIMARY KEY,
  television_id int,
  remote_controller_id int,
  CONSTRAINT fk_television FOREIGN KEY (television_id) REFERENCES televisions(id),
  CONSTRAINT fk_remote_controller FOREIGN KEY (remote_controller_id) REFERENCES remote_controllers(id)
	
);

INSERT INTO television_remotecontrollers (television_id, remote_controller_id)
VALUES 
  ((SELECT id FROM televisions WHERE name='51hkagj21B'), 
   (SELECT id FROM remote_controllers WHERE name='samsung remote')),
  ((SELECT id FROM televisions WHERE name='52hkagj21B'), 
   (SELECT id FROM remote_controllers WHERE name='samsung remote'));

SELECT * 
FROM televisions
JOIN television_remotecontrollers ON television_remotecontrollers.television_id = televisions.id
JOIN television_brackets ON television_brackets.television_id = televisions.id
WHERE televisions.brand = 'SAMSUNG'



