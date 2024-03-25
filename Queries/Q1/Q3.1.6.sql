SELECT DISTINCT g1.category, g2.category, COUNT(DISTINCT bd.category, bd.isbn) countForCombination
FROM Book_has_Genre bhg1
INNER JOIN Genre g1 ON bhg1.genre_genre_id = g1.genre_id
INNER JOIN Book_has_Genre bhg2 ON bhg1.book_isbn = bhg2.book_isbn
INNER JOIN Genre g2 ON bhg2.genre_genre_id = g2.genre_id
INNER JOIN book b ON b.isbn = bhg1.book_isbn AND b.isbn = bhg2.book_isbn
INNER JOIN book_demand bd ON bd.isbn = bhg2.book_isbn
WHERE bhg1.genre_genre_id < bhg2.genre_genre_id
  AND bd.category = 'B'
GROUP BY bhg1.genre_genre_id, bhg2.genre_genre_id
ORDER BY countForCombination DESC
LIMIT 3;
