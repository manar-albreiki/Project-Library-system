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

SELECT
    m.Members_FullName,
    m.Members_PhoneNumber,
    b.Book_title,
    l.library_name,
    DATEDIFF(day, lo.due_date, GETDATE()) AS Days_Overdue, -- claculate the difference between due date and today
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
count (l.loan_id) as total_loaned, -- calculate the total lone
avg (r.review_rate) avg_review_rate -- -- calculate the avg_review
from Book b
join loan l
on b.Book_ID = l.Book_ID
join review r
on b.Book_ID = r.Book_ID
group by b.Book_title, b.Book_ISBN, b.Book_Genre
having count (l.loan_id) >=  3 

-- 6. Member Reading History
--Create a query that shows each member's complete borrowing history including: member name, book titles borrowed (including currently borrowed and previously returned), loan dates, return dates, and any reviews they left for those books.

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
-- Calculate total fine payments collected for each book genre. Show genre name, total number of loans for that genre, total fine amount collected, and average fine per loan.
select
b.Book_Genre,
count (l.loan_id) as total_genre,
    SUM(p.amount) AS Total_Fine,
    AVG(cast(p.amount as float)) AS Avg_Fine
from Book b
join loan l
ON b.Book_ID = l.Book_ID
left join payment p
on l.loan_id = p.loan_id
group by b.Book_Genre

-- Section 2: Aggregate Functions and Grouping

-- 8. Monthly Loan Statistics
-- Generate a report showing the number of loans issued per month for the current year. Include month name, total loans, total returned, and total still issued/overdue

SELECT
    DATENAME(month, loan_date) AS Month_Name,
    COUNT(loan_id) AS Total_Loans,
    SUM(CASE WHEN Loan_Status = 'Returned' THEN 1 ELSE 0 END) AS Total_Returned,
    SUM(CASE WHEN Loan_Status IN ('Issued', 'Overdue') THEN 1 ELSE 0 END) AS Still_Issued_Or_Overdue
FROM loan
WHERE YEAR(loan_date) = YEAR(GETDATE()) -- to show the loan in current year
GROUP BY DATENAME(month, loan_date)

-- 9. Member Engagement Metrics 
--For each member, calculate: total books borrowed, total books currently on loan, total  fines paid, and average rating they give in reviews. Only include members who have borrowed at least one book. 

SELECT
    m.Members_FullName,
    COUNT(l.loan_id) AS Total_Books_Borrowed,
    SUM(CASE WHEN l.Loan_Status IN ('Issued', 'Overdue') THEN 1  ELSE 0 END) AS Total_Books_Currently_On_Loan,
    SUM(ISNULL(p.amount, 0)) AS Total_Fines_Paid,
    AVG(CAST(r.review_rate AS FLOAT)) AS Average_Rating -- CAST is used to convert INT to FLOAT for accurate average calculation
FROM Members m
JOIN Loan l
    ON m.Members_ID = l.Members_ID
LEFT JOIN Payment p -- to show all members who has fine or not
    ON l.loan_id = p.loan_id
 left JOIN Review r -- to show all members who has review or not
    ON m.Members_ID = r.Members_ID
GROUP BY m.Members_FullName
HAVING COUNT(l.loan_id) >= 1

--10. Library Performance Comparison 
--Compare libraries by showing: library name, total books owned, total active members (members with at least one loan), total revenue from fines, and average books per member.


SELECT
l.library_name,
COUNT (b.Book_ID ) AS total_books_owned,
COUNT(DISTINCT case when lo.loan_id is not null then m.Members_ID end ) AS Total_Active_Members, -- not null mean member is active
SUM (isnull(p.amount, 0)) AS total_revenue_fines,

-- total_books_owned/Total_Active_Members
 CAST(COUNT(b.Book_ID) AS FLOAT) / COUNT(DISTINCT CASE WHEN lo.loan_id IS NOT NULL THEN m.Members_ID END) AS average_books_per_member
FROM library1 l
LEFT JOIN Book b ON l.library_ID = b.library_ID  
LEFT JOIN Loan lo ON b.Book_ID = lo.Book_ID  
LEFT JOIN Members m ON lo.Members_ID = m.Members_ID  
LEFT JOIN payment p ON lo.Loan_ID = p.Loan_ID 
group by l.library_name

--11. High-Value Books Analysis 
--Identify books priced above the average book price in their genre. Show book title, genre, price, genre average price, and difference from average.  
select * from Book

;WITH BookWithAvg AS (
    SELECT
        Book_title,
        Book_Genre,
        Book_price,
        AVG(Book_price) OVER (PARTITION BY Book_Genre) AS genre_average_price -- calculate price for each genre/also i can use avg the group by
    FROM Book
)
SELECT
    Book_title,
    Book_Genre,
    Book_price,
    genre_average_price,
    Book_price - genre_average_price AS difference_from_average
FROM BookWithAvg
WHERE Book_price > genre_average_price --books priced above the average book price in their genre

--12. Payment Pattern Analysis 
-- Group payments by payment method and show: payment method, number of transactions, total amount collected, average payment amount, and percentage of total revenue. 
select * from payment
select 
method as payment_method,
COUNT(*) AS Number_of_Transactions,  -- هذا يحسب عدد المعاملات لكل طريقة دفع
sum (amount) as total_amount_collected,
avg (amount) as average_payment_amount,
CAST(SUM(amount) * 100.0 / SUM(SUM(amount)) OVER () AS FLOAT) AS Percentage_of_Total_Revenue-- SUM(amount) for each method / SUM(SUM(amount)) OVER () for all method togeter
FROM Payment
GROUP BY method
----------------------------------------------------------------------------------------------------------------------
-- Section 3: Views Creation 
-- 13. vw_CurrentLoans 
--A view that shows all currently active loans (status 'Issued' or 'Overdue') with member details, book details, loan information, and calculated days until due (or days overdue).  
CREATE VIEW vw_CurrentLoans AS
SELECT
    L.loan_id,
    L.Loan_Status,
    L.Loan_Date,
    L.Due_Date,
    M.Members_ID,
    M.Members_FullName,
    B.Book_ID,
    B.Book_Title,
    B.Book_Genre,
	    CASE 
        WHEN L.Loan_Status = 'Issued' THEN DATEDIFF(DAY, GETDATE(), L.Due_Date)    
        WHEN L.Loan_Status = 'Overdue' THEN DATEDIFF(DAY, L.Due_Date, GETDATE())    
        ELSE NULL
    END AS Days_Until_DueOrOverdue
FROM Loan L
JOIN Members M ON L.Members_ID = M.Members_ID
JOIN Book B ON L.Book_ID = B.Book_ID
WHERE L.Loan_Status IN ('Issued', 'Overdue')
 
 select * from vw_CurrentLoans
 ---------------------------------------------------

 --14. vw_LibraryStatistics 
--A comprehensive view showing library-level statistics including total books, available books, total members, active loans, total staff, and total revenue from fines.  


create view vw_LibraryStatistics AS

WITH BookStats AS (
    SELECT
        Library_ID,
        COUNT(Book_ID) AS total_books,
        SUM(CASE WHEN Book_IsAvailable = 1 THEN 1 ELSE 0 END) AS available_books
    FROM Book
    GROUP BY Library_ID
),
LoanStats AS (
    SELECT
        b.Library_ID,
        COUNT(DISTINCT CASE WHEN l.Loan_Status IN ('Issued','Overdue') THEN l.loan_id END) AS active_loans, -- DISTINCT take one only (no repate)
        SUM(ISNULL(p.amount, 0)) AS total_fines
    FROM Book b
    LEFT JOIN loan l ON b.Book_ID = l.Book_ID
    LEFT JOIN payment p ON l.loan_id = p.loan_id
    GROUP BY b.Library_ID
)
SELECT
    l.library_name AS libraryName,
    ISNULL(bs.total_books, 0) AS total_books,
    ISNULL(bs.available_books, 0) AS available_books,
    COUNT(DISTINCT m.Members_ID) AS total_members,
    COUNT(DISTINCT s.staff_ID) AS total_staff,
    ISNULL(ls.active_loans, 0) AS active_loans,
    ISNULL(ls.total_fines, 0) AS total_fines
FROM library1 l
LEFT JOIN BookStats bs ON l.library_ID = bs.Library_ID
LEFT JOIN Book b ON l.library_ID = b.Library_ID
LEFT JOIN loan l2 ON b.Book_ID = l2.Book_ID
LEFT JOIN Members m ON l2.Members_ID = m.Members_ID
LEFT JOIN Staff s ON l.library_ID = s.Library_ID
LEFT JOIN LoanStats ls ON l.library_ID = ls.Library_ID
GROUP BY
    l.library_name,
    bs.total_books,
    bs.available_books,
    ls.active_loans,
    ls.total_fines;

	select * from vw_LibraryStatistics
	---------------------------------------------------

--  15. vw_BookDetailsWithReviews 
-- A view combining book information with aggregated review data (average rating, total reviews, latest review date) and current availability status.
CREATE VIEW vw_BookReviewStats AS

SELECT
    b.Book_ID,
    b.Book_ISBN,
    b.Book_title,
    b.Book_price,
    b.Book_Genre,
    b.Shelf_Location,
    b.Library_ID,
    b.Book_IsAvailable,
    AVG(CAST(r.review_rate AS FLOAT)) AS avg_rating,
    COUNT(r.review_id) AS total_reviews,
    MAX(r.review_date) AS latest_review_date

FROM Book b
LEFT JOIN review r ON b.Book_ID = r.Book_ID
GROUP BY
    b.Book_ID,
    b.Book_ISBN,
    b.Book_title,
    b.Book_price,
    b.Book_Genre,
    b.Shelf_Location,
    b.Library_ID,
    b.Book_IsAvailable

	select * from vw_BookReviewStats

--------------------------------------------------------------------------------
-- Section 4: Stored Procedures 
--Q16 sp_IssueBook 

CREATE PROCEDURE spp_ssueBook
    @MemberID INT,
    @BookID INT,
    @DueDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @BookAvailable BIT;
    DECLARE @HasOverdue INT;

    -- Check if book is available 
    SELECT @BookAvailable = Book_IsAvailable
    FROM Book
    WHERE Book_ID = @BookID;

    IF @BookAvailable IS NULL
    BEGIN
        PRINT 'Error: Book not found.';
        RETURN;
    END

    IF @BookAvailable = 0
    BEGIN
        PRINT 'Error: Book is currently not available.';
        RETURN;
    END

    -- Check if member has any overdue loans 
    SELECT @HasOverdue = COUNT(*)
    FROM loan
    WHERE Members_ID = @MemberID
      AND Loan_Status = 'Overdue';

    IF @HasOverdue > 0
    BEGIN
        PRINT 'Error: Member has overdue loans. Cannot issue a new book.';
        RETURN;
    END

    -- If validations pass, create a new loan record and update book availability 
    INSERT INTO loan (loan_date, due_date, Loan_Status, Book_ID, Members_ID)
    VALUES (GETDATE(), @DueDate, 'Issued', @BookID, @MemberID);

    UPDATE Book
    SET Book_IsAvailable = 0
    WHERE Book_ID = @BookID;

    PRINT 'Success: Book has been issued successfully.';
END

EXEC spp_ssueBook 
    @MemberID = 2, 
    @BookID = 2, 
    @DueDate = '2025-12-03'

	
--Q17 sp_ReturnBook 

create procedure sp_ReturnBook 
@loanID int,
@ReturnDate date
as
begin
set nocount on;

    DECLARE @DueDate DATE;
    DECLARE @BookID INT;
    DECLARE @OverdueDays INT;
    DECLARE @FineAmount DECIMAL(8,3);

   -- Get loan details
  select 
  @DueDate = due_date,
  @BookID = Book_ID
  from loan
  where loan_id = @LoanID; -- PK

  IF @DueDate IS NULL
BEGIN
    PRINT 'Error: Loan not found.';
    RETURN;
END

-- Update loan status and return date
update loan
set 
@ReturnDate = return_date,
Loan_Status = 'Returned'
 where loan_id = @LoanID; -- PK

 --  Update book availability to TRUE 
 update Book
 set 
 Book_IsAvailable = 'True'
 where Book_ID = @BookID; --PK

 -- Calculate if there's a fine (e.g., $2 per day overdue) 

    SET @OverdueDays = DATEDIFF(DAY, @DueDate, @ReturnDate);

    IF @OverdueDays > 0
    BEGIN
       SET @FineAmount = @OverdueDays * 2;  -- Fine = $2 per overdue day


 -- Create payment record with Pending status
         INSERT INTO payment (payment_date, amount, method, loan_id)
        VALUES (GETDATE(), @FineAmount, 'Pending', @LoanID);
    END
    ELSE
    BEGIN
        SET @FineAmount = 0; -- if no fine
    END

    -- Return total fine amount
    SELECT @FineAmount AS Total_Fine;
END

EXEC sp_ReturnBook 
    @LoanID = 18,
    @ReturnDate = '2025-12-21';

--Q18

create procedure sp_GetMemberReport
    @MemberID INT
	as 
	begin
	set nocount on;

	--  Member basic information 
	select 
        M.Members_ID,
        M.Members_FullName,
        M.Members_email,
        M.Members_PhoneNumber,
        M.membership_StartDate
    FROM Members M
    WHERE M.Members_ID = @MemberID; -- PK

	--  Current loans (Issued or Overdue)
	select 
	    L.loan_ID,
        L.Book_ID,
        B.Book_title,
        L.loan_date,
        L.due_date,
        L.Loan_Status
		from Book B
		join loan L
		ON L.Book_ID = B.Book_ID
		WHERE L.Members_ID = @MemberID -- PK
		AND L.Loan_Status IN ('Issued', 'Overdue');

 -- Loan history with return status
 select
	    L.loan_ID,
        B.Book_title,
        L.loan_date,
        L.due_date,
        L.return_date,
        L.Loan_Status
		from loan L
		join Book B
		on L.Book_ID = B.Book_ID
		where L.Members_ID = @MemberID -- PK
	


-- Total fines paid
SELECT
    SUM(P.amount) AS TotalPaidFines
FROM payment P
JOIN loan L ON P.loan_ID = L.loan_ID
WHERE L.Members_ID = @MemberID; -- PK

	--Reviews written by the member 
	    SELECT
        R.review_ID,
        R.Book_ID,
        B.Book_title,
        R.review_rate,
        R.review_date,
        R.review_comments
    FROM review R
    JOIN Book B ON R.Book_ID = B.Book_ID
    WHERE R.Members_ID = @MemberID;

END

select * from payment
select * from loan
select * from review
select * from Book
select * from Members



EXEC sp_GetMemberReport @MemberID = 412; --the review does not show 
EXEC sp_GetMemberReport @MemberID = 3;

-- Q19
create procedure sp_MonthlyLibraryReport
    @LibraryID int,
    @Month int,
    @Year int
AS
BEGIN
    SET NOCOUNT ON;

	-- Total loans issued in that month 
	select 
	 count(*) AS TotalLoansIssued
    FROM loan L
    JOIN Book B ON L.Book_ID = B.Book_ID --  loan table doesn't know which library has the loan.
    WHERE B.library_ID = @LibraryID
      AND MONTH(L.loan_date) = @Month
      AND YEAR(L.loan_date) = @Year;

-- Total books returned in that month 
    select
        count (*) AS TotalBooksReturned
    FROM loan L
    JOIN Book B ON L.Book_ID = B.Book_ID
    WHERE B.library_ID = @LibraryID
      AND L.return_date IS NOT NULL
      AND MONTH(L.return_date) = @Month
      AND YEAR(L.return_date) = @Year;

	--Total revenue collected
	    select 
        SUM(P.amount) AS TotalRevenue
    FROM payment P
    JOIN loan L ON P.loan_ID = L.loan_ID
    JOIN Book B ON L.Book_ID = B.Book_ID
    WHERE B.library_ID = @LibraryID
      AND MONTH(P.payment_date) = @Month
      AND YEAR(P.payment_date) = @Year;
 
 -- Most borrowed genre 
     SELECT TOP 1
        B.Book_Genre,
        COUNT(*) AS BorrowCount
    FROM loan L
    JOIN Book B ON L.Book_ID = B.Book_ID
    WHERE B.library_ID = @LibraryID
      AND MONTH(L.loan_date) = @Month
      AND YEAR(L.loan_date) = @Year
    GROUP BY B.Book_Genre
    ORDER BY COUNT(*) DESC;

	-- Top 3 most active members (by number of loans) 
	    SELECT TOP 3
        M.Members_ID,
        M.Members_FullName,
        COUNT(*) AS TotalLoans
    FROM loan L
    JOIN Members M ON L.Members_ID = M.Members_ID
    JOIN Book B ON L.Book_ID = B.Book_ID
    WHERE B.library_ID = @LibraryID
      AND MONTH(L.loan_date) = @Month
      AND YEAR(L.loan_date) = @Year
    GROUP BY M.Members_ID, M.Members_FullName
    ORDER BY COUNT(*) DESC;

END;


EXEC sp_MonthlyLibraryReport 
    @LibraryID = 1,
    @Month = 12,
    @Year = 2025;
