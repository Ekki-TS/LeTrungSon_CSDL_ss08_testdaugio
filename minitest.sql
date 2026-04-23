USE bookStore;

DROP TABLE IF EXISTS bookOrder;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS category;

CREATE TABLE category (
	category_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    category_name VARCHAR(100), 
    description VARCHAR(255)
);

CREATE TABLE book (
	book_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    title VARCHAR(150) NOT NULL,
    status INT DEFAULT 1,
    publish_date DATE,
    price DECIMAL(10,2),
    category_id INT NOT NULL, 
    FOREIGN KEY (category_id) REFERENCES category (category_id)
);

CREATE TABLE bookOrder (
	order_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
	book_id INT NOT NULL, 
    order_date DATE DEFAULT (current_date()),
    delivery_date DATE ,
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

ALTER TABLE book
ADD author_name VARCHAR(100) NOT NULL; 

ALTER TABLE bookOrder 
MODIFY customer_name VARCHAR(200);

ALTER TABLE bookOrder
ADD CONSTRAINT check_date CHECK (delivery_date >= order_date);

INSERT INTO category  VALUES 
('1', 'IT & Tech' , 'Sách lập trình'),
('2', 'Business' , 'Sách kinh doanh'),
('3', 'Novel' , 'Tiểu thuyết');

INSERT INTO book  VALUES 
('1' , 'Clean code' , '1' , '2020-05-10', '500000' , '1' , 'Robert C.Martin'),
('2' , 'Đắc Nhân Tâm' , '0' , '2018-08-20' , '150000', '2' , 'Dale Carnrnegie'),
('3' , 'JavaScriptNâng cao' , ' 1' , '2023-01-15', '350000' , '1' , 'KyKyle Simpson'),
('4' , 'Nhà Giả Kim' , '0' , '2015-11-25' , '120000', '3', 'Paulo Coelho');

INSERT INTO bookOrder VALUES 
('101' , 'Nguyen Hai Nam' , '1' , '2025-01-10' , '2025-01-15'),
('102' , 'Tran Bao Ngoc' , '3' , '2025-02-05' , '2025-02-10'),
('103' , 'Le Hoang yen' , '4' , '2025-03-12' , NULL);

UPDATE book
SET price = price + 200 
WHERE category_name = 'IT & Tech';

UPDATE bookOrder 
SET delivery_date = "2025-12-31"
WHERE delivery_date IS NULL;

SELECT 
	title,
    author_name,
		CASE 
			WHEN 1 THEN 'Còn hàng'
            ELSE 'Hết Hàng'
		END AS status_name 
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
	book_id,
    COUNT(*) AS total
    FROM category
    GROUP BY book_id 
    HAVING COUNT(*) >= 2
    LIMIT 2;
    
SELECT * FROM category
WHERE price > (
	SELECT AVG(price)
    FROM category
);

SELECT * FROM category c 
WHERE price = (SELECT MAX(price) FROM category WHERE book_id = c.book_id);







    
    
    





