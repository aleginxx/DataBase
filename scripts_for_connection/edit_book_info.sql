-- edit book info

DELIMITER //

DROP PROCEDURE IF EXISTS edit_book_info //

CREATE PROCEDURE edit_book_info (
    IN input_isbn VARCHAR(12),
    IN change_title VARCHAR(100),
    IN change_publisher VARCHAR(100),
    IN change_no_of_pages INT,
    IN change_available_copies INT,
    IN change_image VARCHAR(100),
    IN change_language VARCHAR(100),
    IN change_author_first_name VARCHAR(100),
    IN change_author_last_name VARCHAR(100),
    IN change_genre VARCHAR(100)
)
BEGIN

    DECLARE new_genre_id INT;
    DECLARE current_author_id INT;
    
    SET @t1 = CONCAT('SELECT b.title, b.isbn, b.publisher, b.no_of_pages, b.available_copies, b.language, b.image,
            GROUP_CONCAT(DISTINCT g.category SEPARATOR ", ") AS genre,
            CONCAT(a.first_name, " ", a.last_name) AS author_name
            FROM author a, genre g, book b, Book_has_Genre bhg, Book_has_Author bha
            WHERE b.isbn = "', input_isbn, '" AND bhg.Book_isbn = b.isbn AND g.genre_id = bhg.Genre_genre_id
               AND bha.Book_isbn = b.isbn AND a.author_id = bha.Author_author_id');
               
    IF change_title != '' THEN
        UPDATE Book
        SET title = change_title
        WHERE isbn = input_isbn;
    END IF;    

    IF change_publisher != '' THEN
        UPDATE Book
        SET publisher = change_publisher
        WHERE isbn = input_isbn;
    END IF;

    IF change_no_of_pages != 0 THEN
        UPDATE Book
        SET no_of_pages = change_no_of_pages
        WHERE isbn = input_isbn;
    END IF;

    IF change_available_copies != 0 THEN
        UPDATE Book
        SET available_copies = change_available_copies
        WHERE isbn = input_isbn;
    END IF;

    IF change_image != '' THEN
        UPDATE Book
        SET image = change_image
        WHERE isbn = input_isbn;
    END IF;

    IF change_language != '' THEN
        UPDATE Book
        SET language = change_language
        WHERE isbn = input_isbn;
    END IF;

    IF change_author_first_name != '' THEN
        SELECT Author_author_id INTO current_author_id
        FROM Book_Has_Author
        WHERE Book_isbn = input_isbn;

        UPDATE Author
        SET first_name = change_author_first_name
        WHERE author_id = current_author_id;
    END IF;

    IF change_author_last_name != '' THEN
        SELECT Author_author_id INTO current_author_id
        FROM Book_Has_Author
        WHERE Book_isbn = input_isbn;

        UPDATE Author
        SET last_name = change_author_last_name
        WHERE author_id = current_author_id;
    END IF;

    IF change_genre != '' THEN

        SELECT genre_id INTO new_genre_id
        FROM Genre
        WHERE category = change_genre;

        UPDATE Book_Has_Genre
        SET Genre_genre_id = new_genre_id
        WHERE Book_isbn = input_isbn;

    END IF;

    SET @t1 = CONCAT(@t1, ' GROUP BY b.title, b.isbn, b.publisher, b.no_of_pages, b.available_copies, b.language, b.image, author_name;');

    PREPARE stmt3 FROM @t1;
    EXECUTE stmt3;
    DEALLOCATE PREPARE stmt3;
END //

DELIMITER ;

-- CALL edit_book_info('958166669-9', '', '', 0, 0, '', '', '', '', '');