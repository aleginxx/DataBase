SELECT a.first_name, a.last_name, COUNT(*) AS book_count
FROM Author a
JOIN Book_Has_Author bha ON a.author_id = bha.author_author_id
JOIN Book b ON bha.book_isbn = b.isbn
GROUP BY a.author_id, a.last_name, a.first_name
ORDER BY book_count DESC
LIMIT 1;