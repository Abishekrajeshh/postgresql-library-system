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

--Task 8: Find Total Rental Income by Category:


SELECT 
	b.category,
	SUM(b.rental_price)
FROM books AS b
JOIN issued_status as ist
ON ist.issued_book_isbn = b.isbn
GROUP BY 1

-- Task 9 List Members Who Registered in the Last 180 Days:

SELECT * FROM members
ORDER BY reg_date desc

INSERT INTO members( member_id, member_name, member_address, reg_date)
VALUES
('C120', 'Sudarsan', '250 Main St', '2025-06-01'),
('C121', 'Bharath', '250 Main St', '2025-07-01')

SELECT * FROM members
WHERE CURRENT_DATE - reg_date <= 180

SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '180 days'

SELECT CURRENT_DATE

--Task 10 List Employees with Their Branch Manager's Name and their branch details

SELECT * FROM branch;
SELECT * FROM employees;


SELECT 
	e1.*,
	e2.emp_name as manager,
	b.manager_id,b.branch_address
FROM employees as e1
JOIN branch as b
ON e1.branch_id = b.branch_id
JOIN 
employees as e2
ON b.manager_id = e2.emp_id


--Task 11. Create a Table of Books with Rental Price Above a Certain Threshold:
CREATE TABLE books_price_greater_than_7
AS
SELECT * FROM books
WHERE rental_price > 7;

SELECT * FROM books_price_greater_than_7;

-- Task 12: Retrieve the List of Books Not Yet Returned

SELECT * FROM issued_status;
SELECT * FROM return_status;

SELECT 
		DISTINCT ist.issued_book_name
FROM issued_status as ist
LEFT JOIN return_status as rst
ON ist.issued_id = rst.issued_id
WHERE rst.return_id IS NULL
;

--Task 13: Identify Members with Overdue Books
--Write a query to identify members who have overdue books (assume a 30-day return period). 
--Display the member's_id, member's name, book title, issue date, and days overdue.


