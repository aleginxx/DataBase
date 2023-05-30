DELIMITER //

DROP PROCEDURE IF EXISTS get_average_ratings //

CREATE PROCEDURE get_average_ratings(
    IN search_first_name VARCHAR(100),
    IN search_last_name VARCHAR(100),
    IN search_genre VARCHAR(100)
)
BEGIN
    SET @t1 = CONCAT('SELECT CONCAT(su.first_name, " ", su.last_name) AS user_name,
                (SELECT GROUP_CONCAT(DISTINCT g.category SEPARATOR ", ")
                 FROM Review r
                 JOIN Book b ON r.isbn = b.isbn
                 JOIN Book_Has_Genre bhg ON b.isbn = bhg.Book_isbn
                 JOIN Genre g ON bhg.Genre_genre_id = g.genre_id
                 WHERE r.approved IN ("not needed", "accepted")
                   AND r.username_su = su.username_su) AS categories,
                (SELECT AVG(rating)
                 FROM Review r
                 WHERE r.approved IN ("not needed", "accepted")
                   AND r.username_su = su.username_su) AS average_rating
                FROM School_User su');

    IF search_first_name != '' THEN
        SET @t1 = CONCAT(@t1, ' WHERE su.first_name LIKE "%', search_first_name, '%"');
    END IF;

    IF search_last_name != '' THEN
        IF search_first_name != '' THEN
            SET @t1 = CONCAT(@t1, ' AND su.last_name LIKE "%', search_last_name, '%"');
        ELSE
            SET @t1 = CONCAT(@t1, ' WHERE su.last_name LIKE "%', search_last_name, '%"');
        END IF;
    END IF;

    SET @t1 = CONCAT(@t1, ' GROUP BY su.username_su');

    -- Prepare and execute the dynamic SQL statement
    PREPARE stmt3 FROM @t1;
    EXECUTE stmt3;
    DEALLOCATE PREPARE stmt3;
END //

DELIMITER ;

-- CALL get_average_ratings('Mel', '', '');