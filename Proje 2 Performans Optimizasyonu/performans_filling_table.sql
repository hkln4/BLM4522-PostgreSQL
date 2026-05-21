-- Müşteri verisi (1000 müşteri)
INSERT INTO customers (name, email, country, created_at)
SELECT
    'Customer_' || i,
    'customer' || i || '@email.com',
    (ARRAY['Turkey', 'Germany', 'USA', 'France', 'UK'])[floor(random()*5+1)],
    DATE '2018-01-01' + (random() * 2000)::INTEGER
FROM generate_series(1, 1000) AS i;

-- Ürün verisi (500 ürün)
INSERT INTO products (product_name, category, price)
SELECT
    'Product_' || i,
    (ARRAY['Electronics', 'Clothing', 'Food', 'Books', 'Sports'])[floor(random()*5+1)],
    (random() * 990 + 10)::NUMERIC(10,2)
FROM generate_series(1, 500) AS i;

-- Sipariş verisi (1 milyon sipariş)
INSERT INTO orders (customer_id, product_id, quantity, order_date, status, total_price)
SELECT
    floor(random() * 1000 + 1)::INTEGER,
    floor(random() * 500 + 1)::INTEGER,
    floor(random() * 10 + 1)::INTEGER,
    DATE '2019-01-01' + (random() * 1800)::INTEGER,
    (ARRAY['completed', 'pending', 'cancelled', 'shipped'])[floor(random()*4+1)],
    (random() * 5000 + 10)::NUMERIC(10,2)
FROM generate_series(1, 1000000) AS i;