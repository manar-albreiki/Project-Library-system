use librarySystem
select * from Book -- DO MORE INSERT AS PROJECT PART 2 NEED
INSERT INTO Book 
(Book_ISBN, Book_title, Book_price, Book_IsAvailable, Book_Genre, Shelf_Location, library_ID)
VALUES
    ('978-2111111111', 'The Alchemist', 23.50, 1, 'Fiction', 'A6', 1),
    ('978-2111111112', '1984', 26.75, 1, 'Fiction', 'A7', 1),
    ('978-2111111113', 'Pride and Prejudice', 21.00, 1, 'Fiction', 'A8', 1),
    ('978-2111111114', 'To Kill a Mockingbird', 24.00, 1, 'Fiction', 'A9', 1),

    ('978-2111111115', 'Clean Code', 38.25, 1, 'Reference', 'B6', 2),
    ('978-2111111116', 'Computer Networks', 39.50, 1, 'Reference', 'B7', 2),
    ('978-2111111117', 'Introduction to Algorithms', 45.00, 1, 'Reference', 'B8', 2),

    ('978-2111111118', 'The Little Prince', 16.50, 1, 'Children', 'C6', 3),
    ('978-2111111119', 'Matilda', 17.25, 1, 'Children', 'C7', 3),
    ('978-2111111120', 'Charlotte''s Web', 15.75, 1, 'Children', 'C8', 3),

    ('978-2111111121', 'Atomic Habits', 27.50, 1, 'Non-fiction', 'D6', 4),
    ('978-2111111122', 'Educated', 26.00, 1, 'Non-fiction', 'D7', 4),
    ('978-2111111123', 'Deep Work', 27.00, 1, 'Non-fiction', 'D8', 4),
    ('978-2111111124', 'Thinking, Fast and Slow', 29.00, 1, 'Non-fiction', 'D9', 4);
-- ADD published_year TO BOOK TABLE
	UPDATE Book SET published_year = 2015 WHERE Book_title = 'The Alchemist';
UPDATE Book SET published_year = 1949 WHERE Book_title = '1984';
UPDATE Book SET published_year = 1813 WHERE Book_title = 'Pride and Prejudice';
UPDATE Book SET published_year = 1960 WHERE Book_title = 'To Kill a Mockingbird';

UPDATE Book SET published_year = 2008 WHERE Book_title = 'Clean Code';
UPDATE Book SET published_year = 2010 WHERE Book_title = 'Computer Networks';
UPDATE Book SET published_year = 2009 WHERE Book_title = 'Introduction to Algorithms';

UPDATE Book SET published_year = 1943 WHERE Book_title = 'The Little Prince';
UPDATE Book SET published_year = 1988 WHERE Book_title = 'Matilda';
UPDATE Book SET published_year = 1952 WHERE Book_title = 'Charlotte''s Web';

UPDATE Book SET published_year = 2018 WHERE Book_title = 'Atomic Habits';
UPDATE Book SET published_year = 2018 WHERE Book_title = 'Educated';
UPDATE Book SET published_year = 2016 WHERE Book_title = 'Deep Work';
UPDATE Book SET published_year = 2011 WHERE Book_title = 'Thinking, Fast and Slow';
UPDATE Book SET published_year = 2019 WHERE Book_title = 'Data Structures and Algorithms';
select * from Members -- DO insert for member table 
INSERT INTO Members (Members_FullName, Members_email, Members_PhoneNumber, membership_StartDate, membership_Status)
VALUES
('Huda Al-Salmi', 'huda@example.com', '91567890', '2025-01-10', 'Active'),
('Khalid Al-Hinai', 'khalid@example.com', '91678901', '2025-02-12', 'Active'),
('Lina Al-Farsi', 'lina@example.com', '91789012', '2024-12-05', 'Inactive'),
('Nasser Al-Maawali', 'nasser@example.com', '91890123', '2023-09-15', 'Active'),
('Reem Al-Riyami', 'reem@example.com', '91901234', '2025-06-20', 'Active'),
('Faisal Al-Harthy', 'faisal@example.com', '92012345', '2024-11-30', 'Inactive');

update Members set membership_Status = 'Active' where Members_FullName = 'Ali Al-Harthy';
update Members set membership_Status = 'Active' where Members_FullName = 'Sara Al-Mahri';
update Members set membership_Status = 'Active' where Members_FullName = 'Fatma Al-Balushi';

select * from loan
select * from Members
select * from Book
INSERT INTO Loan (loan_date, due_date, return_date, Loan_Status, Book_ID, Members_ID)
VALUES -- -- DO insert for member table 
('2025-12-02', '2025-12-16', NULL, 'Issued', 1018, 1),
('2025-12-03', '2025-12-17', '2025-12-16', 'Returned', 1019, 2),
('2025-12-04', '2025-12-18', NULL, 'Issued', 1015, 407),
('2025-12-05', '2025-12-19', '2025-12-21', 'Overdue', 1020, 4),
('2025-12-06', '2025-12-20', NULL, 'Issued', 1021, 408),
('2025-12-07', '2025-12-21', '2025-12-21', 'Returned', 1022, 3),
('2025-12-08', '2025-12-22', NULL, 'Issued', 1023, 409),
('2025-12-09', '2025-12-23', '2025-12-24', 'Overdue', 1024, 412),
('2025-12-10', '2025-12-24', NULL, 'Issued', 1025, 410);

-------------------------------------------------------------------------------
-- Section 1: Complex Queries with Joins
-- 1. Library Book Inventory Report
-- Display library name, total number of books, number of available books, and number of books currently on loan for each library.
SELECT 
    l.library_name,
    COUNT(b.Book_ID) AS Total_Books,
SUM(CASE WHEN b.Book_IsAvailable = 1 THEN 1 ELSE 0 END) AS Available_Books,
SUM(CASE 
            WHEN lo.Loan_Status = 'Issued' THEN 1 ELSE 0  -- Issued mean on loan doesn't returend
        END) AS Books_On_Loan
FROM library1 l
 JOIN Book b 
ON l.library_ID = b.library_ID
 JOIN Loan lo
ON b.Book_ID = lo.Book_ID 
GROUP BY l.library_name

-- 2. Active Borrowers Analysis
-- List all members who currently have books on loan (status = 'Issued' or 'Overdue'). Showmember name, email, book title, loan date, due date, and current status.
select 
m.Members_FullName,
m.Members_email,
b.Book_title,
lo.loan_date,
lo.due_date,
lo.Loan_Status as current_status
FROM Members m
 JOIN Loan lo
 ON m.Members_ID = lo.Members_ID
 JOIN Book b
 ON lo.Book_ID = b.Book_ID
WHERE lo.Loan_Status IN ('Issued', 'Overdue')

-- 3. Overdue Loans with Member Details
-- Retrieve all overdue loans showing member name, phone number, book title, library name, days overdue (calculated as difference between current date and due date), and any fines paid for that loan.
select
m.Members_FullName,
m.Members_PhoneNumber,
b.Book_title,
l.library_name,
DATEDIFF(day, lo.due_date, GETDATE()) AS Days_Overdue,
isnull(p.amount,0)  as fines
from loan lo
join Members m
on m.Members_ID = lo.Members_ID
join Book b
on b.Book_ID = lo.Book_ID
join library1 l
on l.library_ID = b.library_ID
join payment p
on p.loan_id = lo.loan_id
where lo.Loan_Status = 'Overdue'

select * from loan
select * from Members
select * from payment
select * from Book

SELECT
    m.Members_FullName,
    m.Members_PhoneNumber,
    b.Book_title,
    l.library_name,
    DATEDIFF(day, lo.due_date, GETDATE()) AS Days_Overdue,
    ISNULL(p.amount, 0) AS Fines
FROM loan lo
JOIN Members m ON m.Members_ID = lo.Members_ID
JOIN Book b ON b.Book_ID = lo.Book_ID
JOIN library1 l ON l.library_ID = b.library_ID
LEFT JOIN payment p ON p.loan_id = lo.loan_id
WHERE lo.Loan_Status = 'Overdue'

select * from Loan

INSERT INTO Payment (payment_date, amount, method, loan_id)
VALUES('2025-12-05', 25.500, 'Cash', 1),
('2025-12-06', 18.750, 'Credit Card', 2),
('2025-12-07', 30.000, 'Debit Card', 3),
('2025-12-08', 20.000, 'Online Transfer', 4),
('2025-12-09', 15.250, 'Cash', 5),
('2025-12-10', 22.500, 'Credit Card', 22);

-- 4. Staff Performance Overview
-- For each library, show the library name, staff member names, their positions, and count of books managed at that library.
select
l.library_name,
s.staff_FullName,
s.staff_position,
count (b.Book_ID) as count_book
from library1 l
join Staff s 
on l.library_ID = s.library_ID
 join Book b 
on l.library_ID = b.library_ID
group by l.library_name, s.staff_FullName,s.staff_position


SELECT * FROM Staff;
SELECT * FROM review
SELECT * FROM library1;

-- 5. Book Popularity Report
-- Display books that have been loaned at least 3 times. Include book title, ISBN, genre, total number of times loaned, and average review rating (if any reviews exist).
select 
b.Book_title,
b.Book_ISBN,
b.Book_Genre,
count (l.loan_id) as total_loaned,
avg (r.review_rate) avg_review_rate
from Book b
join loan l
on b.Book_ID = l.Book_ID
join review r
on b.Book_ID = r.Book_ID
group by b.Book_title, b.Book_ISBN, b.Book_Genre
having count (l.loan_id) >=  2 -- i have not more than 3

-- 6. Member Reading History
--Create a query that shows each member's complete borrowing history including:
--member name, book titles borrowed (including currently borrowed and previously
--returned), loan dates, return dates, and any reviews they left for those books.
select
m.Members_FullName,
b.Book_title,
l.loan_date,
l.return_date,
l.Loan_Status,
r.review_rate,
r.review_comments
 from loan l 
 join Book b
on b.Book_ID = l.Book_ID
 left join review r
on b.Book_ID = r.Book_ID
join Members m
on m.Members_ID = l.Members_ID

SELECT
    m.Members_FullName,
    b.Book_title,
    l.loan_date,
    l.return_date,
    l.Loan_Status,
    r.review_rate,
    r.review_comments
FROM loan l
JOIN Members m
    ON m.Members_ID = l.Members_ID
JOIN Book b
    ON b.Book_ID = l.Book_ID
LEFT JOIN review r
    ON r.Book_ID = b.Book_ID
   AND r.Members_ID = m.Members_ID --  the join condition ensures the review belongs to the same member and book

  -- 7. Revenue Analysis by Genre
-- Calculate total fine payments collected for each book genre. Show genre name, total
-- number of loans for that genre, total fine amount collected, and average fine per loan.
select
b.Book_Genre,
count (l.loan_id) as total_genre,
    SUM(ISNULL(p.amount, 0)) AS Total_Fine,
    AVG(ISNULL(p.amount, 0.0)) AS Avg_Fine
from Book b
join loan l
ON b.Book_ID = l.Book_ID
left join payment p
on l.loan_id = p.loan_id
group by b.Book_Genre

-- Section 2: Aggregate Functions and Grouping
-- 8. Monthly Loan Statistics
-- Generate a report showing the number of loans issued per month for the current year.
--Include month name, total loans, total returned, and total still issued/overdue
select

