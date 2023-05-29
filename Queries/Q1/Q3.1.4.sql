SELECT DISTINCT a.first_name, a.last_name
FROM author a
JOIN Book_has_Author bha ON a.author_id = bha.Author_author_id
JOIN book b ON bha.Book_isbn = b.isbn
WHERE b.isbn NOT IN (
    SELECT bd.isbn
    FROM book_demand bd
    WHERE bd.category = 'B'
)
ORDER BY a.last_name ASC;
