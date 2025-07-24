SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM return_status;
SELECT * FROM members;

-- Project Task
-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

INSERT INTO books (isbn, book_title, category, rental_price,status,author, publisher)
VALUES ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')
SELECT * FROM books;

-- Task 2: Update an Existing Member's Address
UPDATE members
SET member_address = '250 Main St'
WHERE member_id = 'C101';

SELECT * FROM members;

-- Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

SELECT * FROM issued_status
WHERE issued_id = 'IS121';

DELETE FROM issued_status
WHERE issued_id = 'IS121'


-- Task 4: Retrieve All Books Issued by a Specific Employee 
-- Objective: Select all books issued by the employee with emp_id = 'E101'.

SELECT * FROM issued_status
WHERE issued_emp_id = 'E101';


-- Task 5: List Members Who Have Issued More Than One Book 
-- Objective: Use GROUP BY to find members who have issued more than one book.

SELECT 
		issued_emp_id,
		COUNT(issued_id) as total_book_issued
FROM issued_status
GROUP BY issued_emp_id
HAVING COUNT(issued_id) > 1

-- CTAS (Create Table As Select)
--Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**

CREATE TABLE book_cnts
AS
SELECT 
	b.isbn,
	COUNT(ist.issued_id) as no_issued,
	b.book_title
FROM books as b
JOIN 
issued_status as ist
ON ist.issued_book_isbn = b.isbn
GROUP BY 1, 3

SELECT * FROM book_cnts

-- Task 7. Retrieve All Books in a Specific Category:

SELECT * FROM books
WHERE category = 'Classic'

