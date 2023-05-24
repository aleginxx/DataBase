DELIMITER //

DROP PROCEDURE IF EXISTS get_list_by_title //

CREATE PROCEDURE get_list_by_title(IN search_title VARCHAR(100))
BEGIN
    -- Declare a temporary table to store the results
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_results (
        BookTitle VARCHAR(255),
        AuthorName VARCHAR(255)
    );

    -- Insert distinct book titles and author names into the temporary table
    INSERT INTO temp_results (BookTitle, AuthorName)
    SELECT DISTINCT b.title AS BookTitle, CONCAT(a.first_name, ' ', a.last_name) AS AuthorName
    FROM Book b
    JOIN Book_Has_Author bha ON b.isbn = bha.book_isbn
    JOIN Author a ON bha.author_author_id = a.author_id
    WHERE b.title LIKE CONCAT('%', search_title, '%')
        AND b.available_copies >= 1;

    -- Select all rows from the temporary table as the final result
    SELECT BookTitle, AuthorName FROM temp_results;

    -- Drop the temporary table
    DROP TEMPORARY TABLE IF EXISTS temp_results;
END //

-- CALL get_lst_by_title('Me');

DELIMITER //

DROP PROCEDURE IF EXISTS get_list_by_author //

CREATE PROCEDURE get_list_by_author(IN search_author VARCHAR(100))
BEGIN
    -- Declare a temporary table to store the results
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_results (
        BookTitle VARCHAR(255),
        AuthorName VARCHAR(255)
    );

    -- Insert distinct book titles and author names into the temporary table
    INSERT INTO temp_results (BookTitle, AuthorName)
    SELECT DISTINCT b.title AS BookTitle, CONCAT(a.first_name, ' ', a.last_name) AS AuthorName
    FROM Book b
    JOIN Book_Has_Author bha ON b.isbn = bha.book_isbn
    JOIN Author a ON bha.author_author_id = a.author_id
    WHERE CONCAT(a.first_name, ' ', a.last_name) LIKE CONCAT('%', search_author, '%')
        AND b.available_copies >= 1;

    -- Select all rows from the temporary table as the final result
    SELECT BookTitle, AuthorName FROM temp_results;

    -- Drop the temporary table
    DROP TEMPORARY TABLE IF EXISTS temp_results;
END //

DELIMITER ;

-- CALL get_list_by_author('Rickie Lingley');

DELIMITER //

DROP PROCEDURE IF EXISTS get_list_by_genre //

CREATE PROCEDURE get_list_by_genre(IN search_genre VARCHAR(100))
BEGIN
    -- Declare a temporary table to store the results
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_results (
        BookTitle VARCHAR(255),
        AuthorName VARCHAR(255)
    );

    -- Insert distinct book titles and author names into the temporary table
    INSERT INTO temp_results (BookTitle, AuthorName)
    SELECT DISTINCT b.title AS BookTitle, CONCAT(a.first_name, ' ', a.last_name) AS AuthorName
    FROM Book b
    JOIN Book_Has_Author bha ON b.isbn = bha.book_isbn
    JOIN Author a ON bha.author_author_id = a.author_id
    JOIN Book_Has_Genre bhg ON b.isbn = bhg.book_isbn
    JOIN Genre g ON bhg.genre_genre_id = g.genre_id
    WHERE g.category = search_genre
        AND b.available_copies >= 1;

    -- Select all rows from the temporary table as the final result
    SELECT BookTitle, AuthorName FROM temp_results;

    -- Drop the temporary table
    DROP TEMPORARY TABLE IF EXISTS temp_results;
END //

DELIMITER ;

-- CALL get_list_by_genre('Horror');

DELIMITER //

DROP PROCEDURE IF EXISTS get_list_by_key_word //

CREATE PROCEDURE get_list_by_key_word(IN search_key_word VARCHAR(100))
BEGIN
    -- Declare a temporary table to store the results
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_results (
        BookTitle VARCHAR(255),
        AuthorName VARCHAR(255)
    );

    -- Insert distinct book titles and author names into the temporary table
    INSERT INTO temp_results (BookTitle, AuthorName)
    SELECT DISTINCT b.title AS BookTitle, CONCAT(a.first_name, ' ', a.last_name) AS AuthorName
    FROM Book b
    JOIN Book_Has_Author bha ON b.isbn = bha.book_isbn
    JOIN Author a ON bha.author_author_id = a.author_id
    JOIN Book_has_key_word bhkw ON b.isbn = bhkw.book_isbn
    JOIN Key_Word kw ON bhkw.key_word_kw_id = kw.kw_id
    WHERE kw.phrase = search_key_word
        AND b.available_copies >= 1;

    -- Select all rows from the temporary table as the final result
    SELECT BookTitle, AuthorName FROM temp_results;

    -- Drop the temporary table
    DROP TEMPORARY TABLE IF EXISTS temp_results;
END //

DELIMITER ;

-- CALL get_list_by_key_word('sun');