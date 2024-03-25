SELECT CONCAT(su.first_name, " ", su.last_name) AS user_name, AVG(r.rating) AS average_rating
FROM School_User su
JOIN Review r ON su.username_su = r.username_su
WHERE r.approved IN ('not needed', 'accepted')
GROUP BY su.username_su, su.first_name, su.last_name;

SELECT g.category, AVG(r.rating) AS average_rating
FROM Genre g
JOIN Book_Has_Genre bhg ON g.genre_id = bhg.Genre_genre_id
JOIN Book b ON bhg.Book_isbn = b.isbn
JOIN Review r ON b.isbn = r.isbn
WHERE r.approved IN ('not needed', 'accepted')
GROUP BY g.category;
