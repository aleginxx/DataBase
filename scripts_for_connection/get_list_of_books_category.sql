-- get book list + category

SELECT b.title, a.first_name, a.last_name, GROUP_CONCAT(DISTINCT g.category SEPARATOR ", ") AS genre
FROM Book b
JOIN Book_Has_Author bha ON b.isbn = bha.Book_isbn
JOIN Author a ON bha.Author_author_id = a.author_id
JOIN Book_Has_Genre bhg ON b.isbn = bhg.Book_isbn
JOIN Genre g ON bhg.Genre_genre_id = g.genre_id
GROUP BY b.title, a.first_name, a.last_name
ORDER BY b.title ASC;

