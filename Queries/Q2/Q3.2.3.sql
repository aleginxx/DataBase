DELIMITER //

DROP PROCEDURE IF EXISTS get_average_ratings //

CREATE PROCEDURE get_average_ratings(
    IN search_first_name VARCHAR(100),
    IN search_last_name VARCHAR(100),
    IN search_genre VARCHAR(100)
)
BEGIN
    SET @t1 = 'SELECT AVG(r.rating) AS average_rating, r.username_su AS username, CONCAT(su.first_name, " ", su.last_name) AS user_name
        FROM review r
        JOIN school_user su ON r.username_su = su.username_su
        JOIN Book_has_Genre bhg ON r.isbn = bhg.Book_isbn
        JOIN genre g ON bhg.Genre_genre_id = g.genre_id
        WHERE 1=1';

    IF search_first_name != '' THEN
        SET @t1 = CONCAT(@t1, ' AND su.first_name LIKE "%', search_first_name, '%"');
    END IF;

    IF search_last_name != '' THEN
        SET @t1 = CONCAT(@t1, ' AND su.last_name LIKE "%', search_last_name, '%"');
    END IF;

    IF search_genre != '' THEN
        SET @t1 = CONCAT(@t1, ' AND g.category LIKE "%', search_genre, '%"');
    END IF;

    SET @t1 = CONCAT(@t1, ' AND r.approved IN ("accepted", "not needed")');
    SET @t1 = CONCAT(@t1, ' GROUP BY r.username_su');

    -- Prepare and execute the dynamic SQL statement
    PREPARE stmt3 FROM @t1;
    EXECUTE stmt3;
    DEALLOCATE PREPARE stmt3;
END //

DELIMITER ;

-- CALL get_average_ratings('h', '', '');