-- get book list

SELECT b.title, CONCAT(a.first_name, " ", a.last_name) AS author_name
FROM Book b
JOIN Book_Has_Author bha ON b.isbn = bha.Book_isbn
JOIN Author a ON bha.Author_author_id = a.author_id
ORDER BY b.title ASC; 
