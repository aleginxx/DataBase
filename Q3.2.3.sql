DELIMITER //

DROP PROCEDURE IF EXISTS get_average_ratings_by_user //

CREATE PROCEDURE get_average_ratings_by_user(
    IN search_first_name VARCHAR(100),
    IN search_last_name VARCHAR(100),
    IN search_genre VARCHAR(100)
)
BEGIN
    -- Declare variables
    DECLARE sql_statement VARCHAR(1000);

    -- Build the SQL statement dynamically
    SET sql_statement = 'SELECT distinct g.category, AVG(r.rating) AS average_rating, CONCAT(su.first_name, " ", su.last_name) AS user_name
        FROM review r, school_user su, genre g, Book_has_Genre bhg
        WHERE r.username_su = su.username_su AND r.isbn = bhg.Book_isbn';
        
	IF search_first_name != '' THEN
        SET sql_statement = CONCAT(sql_statement, ' AND su.first_name LIKE "%', search_first_name, '%"');
    END IF;
    
    IF search_last_name != '' THEN
        SET sql_statement = CONCAT(sql_statement, ' AND su.last_name LIKE "%', search_last_name, '%"');
    END IF;
    
    IF search_genre != '' THEN
        SET sql_statement = CONCAT(sql_statement, ' AND g.category LIKE "%', search_genre, '%"');
    END IF;
    
	SET sql_statement = CONCAT(sql_statement, ' GROUP BY user_name');

    -- Prepare and execute the dynamic SQL statement
    PREPARE stmt FROM sql_statement;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;

-- CALL get_average_ratings_by_user('', '', 'Action');