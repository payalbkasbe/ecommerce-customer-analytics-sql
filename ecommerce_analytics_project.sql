CREATE DATABASE IF NOT EXISTS ecommerce_analytics1;
USE ecommerce_analytics1;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    country VARCHAR(50),
    join_date DATE,
    status VARCHAR(20) DEFAULT 'Active'
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    order_status VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE order_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

USE ecommerce_analytics1;

INSERT INTO users (username, country, join_date, status) VALUES
('alex_99', 'USA', '2026-01-15', 'Active'),
('sofia_m', 'Canada', '2025-11-20', 'Active'),
('liam_tech', 'UK', '2026-03-02', 'Active'),
('emma_b', 'USA', '2025-05-14', 'Inactive'),
('hiro_s', 'Japan', '2026-02-10', 'Active');

INSERT INTO products (product_name, category, price) VALUES
('Wireless Mouse', 'Electronics', 25.00),
('Mechanical Keyboard', 'Electronics', 85.00),
('Ergonomic Chair', 'Furniture', 250.00),
('Coffee Mug', 'Kitchen', 15.00),
('Water Bottle', 'Kitchen', 20.00);

INSERT INTO orders (user_id, order_date, order_status) VALUES
(1, '2026-02-01', 'Shipped'),
(1, '2026-04-15', 'Completed'),
(2, '2026-03-10', 'Completed'),
(3, '2026-05-20', 'Processing'),
(5, '2026-06-01', 'Completed');

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 2), -- Alex bought 2 mice
(1, 4, 1), -- Alex bought 1 mug
(2, 2, 1), -- Alex bought 1 keyboard
(3, 3, 1), -- Sofia bought 1 chair
(4, 5, 3), -- Liam bought 3 water bottles
(5, 2, 1);

SELECT 
    u.user_id,
    u.username,
    u.country,
    SUM(oi.quantity * p.price) AS total_spent
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY u.user_id, u.username, u.country
ORDER BY total_spent DESC;


SELECT 
    p.category,
    SUM(oi.quantity * p.price) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category
HAVING total_revenue > 100.00
ORDER BY total_revenue DESC;

SELECT 
    order_id,
    user_id,
    order_date,
    LAG(order_date) OVER (PARTITION BY user_id ORDER BY order_date) AS previous_order_date
FROM orders;