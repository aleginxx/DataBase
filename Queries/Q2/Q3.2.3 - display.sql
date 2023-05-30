SELECT r.username_su, AVG(r.rating) AS average_rating
FROM Review r
WHERE r.approved IN ('not needed', 'accepted')
GROUP BY r.username_su;

SELECT g.category, AVG(r.rating) AS average_rating
FROM Genre g
JOIN Book_Has_Genre bhg ON g.genre_id = bhg.Genre_genre_id
JOIN Book b ON bhg.Book_isbn = b.isbn
JOIN Review r ON b.isbn = r.isbn
WHERE r.approved IN ('not needed', 'accepted')
GROUP BY g.category;
