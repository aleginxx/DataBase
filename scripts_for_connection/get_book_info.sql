DELIMITER //

DROP PROCEDURE IF EXISTS get_book_info //

CREATE PROCEDURE get_book_info (
	IN input_title VARCHAR(12)
)
BEGIN
	SELECT
		b.title,
		b.isbn,
		b.publisher,
		b.no_of_pages,
		b.available_copies,
		b.language,
		GROUP_CONCAT(DISTINCT g.category SEPARATOR ", ") AS genre,
		CONCAT(a.first_name, ' ', a.last_name) AS author_name
	FROM
		Book AS b
		JOIN Book_Has_Author AS bha ON b.isbn = bha.Book_isbn
		JOIN Author AS a ON bha.Author_author_id = a.author_id
		JOIN Book_Has_Genre AS bhg ON b.isbn = bhg.Book_isbn
		JOIN Genre AS g ON bhg.Genre_genre_id = g.genre_id
	WHERE
		b.title = input_title;
END //

DELIMITER ;

-- CALL get_book_info('Soap Girl');