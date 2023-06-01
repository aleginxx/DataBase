-- un-waitlist available books
UPDATE Book_Demand bd
JOIN Book b ON bd.isbn = b.isbn
SET bd.state = 'active'
WHERE bd.category = 'B' AND bd.state = 'waitlisted' AND b.available_copies >= 1;
