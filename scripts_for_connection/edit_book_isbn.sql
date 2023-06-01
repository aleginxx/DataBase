DELIMITER //

DROP PROCEDURE IF EXISTS edit_book_isbn //

CREATE PROCEDURE edit_book_isbn (
    IN input_isbn VARCHAR(12),
    IN change_isbn VARCHAR(12)
)
BEGIN
	SET @t1 = CONCAT('SELECT b.title, b.isbn, b.publisher, b.no_of_pages, b.available_copies, b.language, b.image,
            GROUP_CONCAT(DISTINCT g.category SEPARATOR ", ") AS genre,
            CONCAT(a.first_name, " ", a.last_name) AS author_name
            FROM author a, genre g, book b, Book_has_Genre bhg, Book_has_Author bha
            WHERE b.isbn = "', input_isbn, '" AND bhg.Book_isbn = b.isbn AND g.genre_id = bhg.Genre_genre_id
			AND bha.Book_isbn = b.isbn AND a.author_id = bha.Author_author_id');
	
	IF change_isbn != '' THEN
		
		-- Update the Book table first
		UPDATE Book
		SET isbn = change_isbn
		WHERE isbn = input_isbn;

		-- Update the referencing tables
		UPDATE Book_Has_Author
		SET Book_isbn = change_isbn
		WHERE Book_isbn = input_isbn;

		UPDATE Book_Has_Genre
		SET Book_isbn = change_isbn
		WHERE Book_isbn = input_isbn;

		UPDATE Book_Demand
		SET isbn = change_isbn
		WHERE isbn = input_isbn;

		UPDATE Review
		SET isbn = change_isbn
		WHERE isbn = input_isbn;

		UPDATE Book_Has_Key_Word
		SET Book_isbn = change_isbn
		WHERE Book_isbn = input_isbn;
	END IF;
    
    SET @t1 = CONCAT(@t1, ' GROUP BY b.title, b.isbn, b.publisher, b.no_of_pages, b.available_copies, b.language, b.image, author_name;');
    
END //

DELIMITER ; 

-- CALL edit_book_isbn('958166669-7', '958166669-9');