USE library_lab4;
-- =========================================
-- F2.1 Search Books (WHERE, LIKE, BETWEEN)
-- =========================================
SELECT b.book_id,
    b.title,
    b.price,
    b.publish_year,
    a.name AS author,
    p.name AS publisher,
    c.name AS category
FROM BOOK b
    JOIN AUTHOR a ON b.author_id = a.author_id
    JOIN PUBLISHER p ON b.publisher_id = p.publisher_id
    JOIN CATEGORY c ON b.category_id = c.category_id
WHERE b.title LIKE '%Utopia%'
    AND b.price BETWEEN 10 AND 30
    AND b.category_id = 3
ORDER BY b.price ASC;
-- =========================================
-- F2.2 Catalogue (JOIN)
-- =========================================
SELECT b.book_id,
    b.title,
    b.price,
    b.publish_year,
    a.name AS author_name,
    p.name AS publisher_name,
    c.name AS category_name
FROM BOOK b
    JOIN AUTHOR a ON b.author_id = a.author_id
    JOIN PUBLISHER p ON b.publisher_id = p.publisher_id
    JOIN CATEGORY c ON b.category_id = c.category_id
ORDER BY b.title ASC;
-- =========================================
-- F2.3 (a) Number of Books and Average Price
-- GROUP BY
-- =========================================
SELECT c.category_id,
    c.name AS category,
    COUNT(b.book_id) AS total_books,
    ROUND(AVG(b.price), 2) AS average_price
FROM CATEGORY c
    LEFT JOIN BOOK b ON c.category_id = b.category_id
GROUP BY c.category_id,
    c.name
ORDER BY c.name;
-- =========================================
-- F2.3 (b) Authors Who Wrote at Least 2 Books
-- GROUP BY, HAVING
-- =========================================
SELECT a.author_id,
    a.name AS author_name,
    COUNT(b.book_id) AS total_books
FROM AUTHOR a
    JOIN BOOK b ON a.author_id = b.author_id
GROUP BY a.author_id,
    a.name
HAVING COUNT(b.book_id) >= 2;
-- =========================================
-- F2.3 (c) Total, Minimum and Maximum Price
-- Aggregate Functions
-- =========================================
SELECT SUM(price) AS total_price,
    MIN(price) AS minimum_price,
    MAX(price) AS maximum_price
FROM BOOK;
-- =========================================
-- =========================================
-- F2.4 (a) Loans Not Returned Yet
-- JOIN

SELECT
    l.loan_id,
    b.title AS book_title,
    m.name AS member_name,
    l.loan_date,
    l.return_date
FROM LOAN AS l
JOIN BOOK AS b
    ON l.book_id = b.book_id
JOIN `MEMBER` AS m
    ON l.member_id = m.member_id
WHERE l.return_date IS NULL;