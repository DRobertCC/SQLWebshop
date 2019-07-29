DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS order_details;

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    company_name VARCHAR NOT NULL,
    contact_name VARCHAR,
    contact_title VARCHAR,
    address VARCHAR,
    city VARCHAR,
    region VARCHAR,
    postal_code VARCHAR,
    country VARCHAR,
    phone VARCHAR,
    fax VARCHAR
);

CREATE TABLE orders (
    order_id SERIAL,
    customer_id INTEGER REFERENCES customers(customer_id),
    employee_id SMALLINT,
    order_date DATE,
    required_date DATE,
    shipped_date DATE,
    ship_via SMALLINT,
    freight REAL,
    ship_name VARCHAR(40),
    ship_address VARCHAR(60),
    ship_city VARCHAR(15),
    ship_region VARCHAR(15),
    ship_postal_code VARCHAR(10),
    ship_country VARCHAR(15),
    PRIMARY KEY (order_id)
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(40) NOT NULL,
    supplier_id SMALLINT,
    category_id SMALLINT,
    quantity_per_unit VARCHAR(20),
    unit_price REAL,
    units_in_stock SMALLINT,
    units_on_order SMALLINT,
    reorder_level SMALLINT,
    discontinued BOOLEAN NOT NULL
);

CREATE TABLE order_details (
    order_id SMALLINT REFERENCES orders(order_id),
    product_id SMALLINT REFERENCES products(product_id),
    unit_price REAL NOT NULL,
    quantity SMALLINT NOT NULL,
    discount REAL NOT NULL,
    PRIMARY KEY (order_id, product_id)
);

INSERT INTO customers (company_name, contact_name, contact_title, address, city, region, postal_code, country, phone, fax) VALUES
    ('Alfreds Futterkiste', 'Maria Anders', 'Sales Representative', 'Obere Str. 57', 'Berlin', NULL, '12209', 'Germany', '030-0074321', '030-0076545'),
    ('Ana Trujillo Emparedados y helados', 'Ana Trujillo', 'Owner', 'Avda. de la Constitución 2222', 'México D.F.', NULL, '05021', 'Mexico', '(5) 555-4729', '(5) 555-3745'),
    ('Antonio Moreno Taquería', 'Antonio Moreno', 'Owner', 'Mataderos  2312', 'México D.F.', NULL, '05023', 'Mexico', '(5) 555-3932', NULL),
    ('Around the Horn', 'Thomas Hardy', 'Sales Representative', '120 Hanover Sq.', 'London', NULL, 'WA1 1DP', 'UK', '(171) 555-7788', '(171) 555-6750');

INSERT INTO orders(customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country) VALUES
    (2, 3, '1997-11-28', '1997-12-26', '1997-12-12', 3, 11.9899998, 'Ana Trujillo Emparedados y helados', 'Avda. de la Constitución 2222', 'México D.F.', NULL, '05021', 'Mexico'),
    (1, 1, '1998-03-16', '1998-04-27', '1998-03-24', 1, 40.4199982, 'Alfred''s Futterkiste', 'Obere Str. 57', 'Berlin', NULL, '12209', 'Germany'),
    (3, 3, '1998-01-28', '1998-02-25', '1998-02-10', 2, 58.4300003, 'Antonio Moreno Taquería', 'Mataderos  2312', 'México D.F.', NULL, '05023', 'Mexico'),
    (4, 6, '1996-11-15', '1996-12-13', '1996-11-20', 1, 41.9500008, 'Around the Horn', 'Brook Farm Stratford St. Mary', 'Colchester', 'Essex', 'CO7 6JX', 'UK');

INSERT INTO products(product_name, supplier_id, category_id, quantity_per_unit, unit_price, units_in_stock, units_on_order, reorder_level, discontinued) VALUES
    ('Chai', 8, 1, '10 boxes x 30 bags', 18, 39, 0, 10, true),
    ('Chang', 1, 1, '24 - 12 oz bottles', 19, 17, 40, 25, true),
    ('Aniseed Syrup', 1, 2, '12 - 550 ml bottles', 10, 13, 70, 25, false),
    ('Chef Anton''s Cajun Seasoning', 2, 2, '48 - 6 oz jars', 22, 53, 0, 0, false),
    ('Chef Anton''s Gumbo Mix', 2, 2, '36 boxes', 21.3500004, 0, 0, 0, true),
    ('Grandma''s Boysenberry Spread', 3, 2, '12 - 8 oz jars', 25, 120, 0, 25, false);

INSERT INTO order_details(order_id, product_id, unit_price, quantity, discount) VALUES
    (1, 1, 14, 12, 0),
    (1, 3, 9.80000019, 10, 0),
    (2, 1, 34.7999992, 5, 0),
    (2, 2, 18.6000004, 9, 0),
    (2, 3, 42.4000015, 40, 0),
    (2, 4, 7.69999981, 10, 0),
    (3, 3, 42.4000015, 35, 0.150000006),
    (4, 1, 16.7999992, 15, 0.150000006),
    (4, 2, 16.7999992, 6, 0.0500000007),
    (4, 3, 15.6000004, 15, 0.0500000007);

