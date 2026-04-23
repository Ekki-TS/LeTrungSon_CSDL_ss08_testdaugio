CREATE DATABASE IF NOT EXISTS bookStore;
USE bookStore;

DROP TABLE IF EXISTS bookOrder;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS category;

CREATE TABLE category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL,
    description VARCHAR(255)
);

CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    status INT DEFAULT 1,
    publish_date DATE,
    price DECIMAL(10,2),
    category_id INT,
    author_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);

CREATE TABLE bookOrder (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(200) NOT NULL,
    book_id INT,
    order_date DATE DEFAULT (CURRENT_DATE),
    delivery_date DATE,
    FOREIGN KEY (book_id) REFERENCES book(book_id) ON DELETE CASCADE,
    CONSTRAINT chk_date CHECK (delivery_date >= order_date)
);

INSERT INTO category VALUES
(1, 'IT & Tech', 'Sách lập trình'),
(2, 'Business', 'Sách kinh doanh'),
(3, 'Novel', 'Tiểu thuyết');

INSERT INTO book VALUES
(1, 'Clean Code', 1, '2020-05-10', 500000, 1, 'Robert C. Martin'),
(2, 'Đắc Nhân Tâm', 0, '2018-08-20', 150000, 2, 'Dale Carnegie'),
(3, 'JavaScript Nâng cao', 1, '2023-01-15', 350000, 1, 'Kyle Simpson'),
(4, 'Nhà Giả Kim', 0, '2015-11-25', 120000, 3, 'Paulo Coelho');

INSERT INTO bookOrder VALUES
(101, 'Nguyen Hai Nam', 1, '2025-01-10', '2025-01-15'),
(102, 'Tran Bao Ngoc', 3, '2025-02-05', '2025-02-10'),
(103, 'Le Hoang Yen', 4, '2025-03-12', NULL);

UPDATE book
SET price = price + 50000
WHERE category_id = 1;

UPDATE bookOrder
SET delivery_date = '2025-12-31'
WHERE delivery_date IS NULL;

DELETE FROM bookOrder
WHERE order_date < '2025-02-01';

SELECT 
    title,
    author_name,
    CASE 
        WHEN status = 1 THEN 'Còn hàng'
        ELSE 'Hết hàng'
    END AS status_name
FROM book;

-- 2. Hàm hệ thống
SELECT 
    UPPER(title) AS title_upper,
    TIMESTAMPDIFF(YEAR, publish_date, CURDATE()) AS years_since_publish
FROM book;


SELECT 
    b.title,
    b.price,
    c.category_name
FROM book b
INNER JOIN category c 
ON b.category_id = c.category_id;

SELECT *
FROM book
ORDER BY price DESC
LIMIT 2;

SELECT 
    category_id,
    COUNT(*) AS total_books
FROM book
GROUP BY category_id
HAVING COUNT(*) >= 2;

SELECT *
FROM book
WHERE price > (
    SELECT AVG(price) FROM book
);

SELECT *
FROM book
WHERE book_id IN (
    SELECT book_id FROM bookOrder
);

SELECT *
FROM book b
WHERE price = (
    SELECT MAX(price)
    FROM book
    WHERE category_id = b.category_id
);
