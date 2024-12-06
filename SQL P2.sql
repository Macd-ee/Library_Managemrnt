SELECT * FROM books
SELECT * FROM branch
SELECT * FROM employees
SELECT * FROM issue_status
SELECT * FROM members
SELECT * FROM return_status

--Project Task

--Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

INSERT INTO books (isbn,book_title,	category,	rental_price,	status,	author,	publisher)
VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

-- Task 2: Update an Existing Member's Address

UPDATE members
SET member_address = '125 Oak St'
WHERE member_id = 'C103';

--Task 3: Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table

DELETE FROM issued_status
WHERE   issued_id =   'IS121';

--Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.
SELECT * FROM issue_status
WHERE issued_emp_id = 'E101'

--Task 5: List Members Who Have Issued More Than One Book
-- Objective: Use GROUP BY to find members who have issued more than one book.

SELECT issued_member_id,
       COUNT (*) AS number_of_issued_bks
FROM issue_status
GROUP BY issued_member_id
HAVING COUNT(*) > 1

--Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt
CREATE TABLE book_issued_cnt
AS	
SELECT b.isbn,
	   b.book_title,
	   COUNT(ist.issued_book_isbn) AS no_issued
	
	FROM books AS b
JOIN 
issue_status AS ist
ON ist.issued_book_isbn = b.isbn
GROUP BY b.isbn, b.book_title;

--Task 7. Retrieve All Books in a Specific Category:


SELECT * FROM books
WHERE category = 'Classic';

--Task 8: Find Total Rental Income by Category:

SELECT b.category,
	   SUM(b.rental_price) AS total_rent_price,
	   COUNT(*)
FROM books AS b
JOIN 
issue_status AS ist
ON ist.issued_book_isbn = b.isbn
GROUP BY b.category;

--List Members Who Registered in the Last 180 Days:
SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '180';

--List Employees with Their Branch Manager's Name and their branch details:
SELECT e1.* ,
	   b.manager_id,
	   e2.emp_name as manager
FROM employees e1
JOIN
branch b
ON b.branch_id = e1.branch_id
JOIN
employees e2
ON e2.emp_id = b.manager_id

