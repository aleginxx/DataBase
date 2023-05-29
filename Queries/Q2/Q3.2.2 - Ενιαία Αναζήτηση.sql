DELIMITER //

DROP PROCEDURE IF EXISTS get_list //

CREATE PROCEDURE get_list(
    IN search_first_name VARCHAR(100),
    IN search_last_name VARCHAR(100),
    IN search_overdue_borrowings INT
)
BEGIN

    SET @t1 = 'SELECT DISTINCT b.title, DATEDIFF(CURDATE(), bd.datetime) AS days_passed, CONCAT(su.first_name, " ", su.last_name) AS user_name
        FROM book b, school_user su, book_demand bd
        WHERE bd.isbn = b.isbn AND bd.username_su = su.username_su';

    IF @t1 != '' THEN
        SET @t1 = CONCAT(@t1, ' AND su.first_name LIKE "%', search_first_name, '%"');
    END IF;

    IF search_last_name != '' THEN
        SET @t1 = CONCAT(@t1, ' AND su.last_name LIKE "%', search_last_name, '%"');
    END IF;

    IF search_overdue_borrowings != 0 THEN
		SET @t1 = CONCAT(@t1, ' AND DATEDIFF(CURDATE(), bd.datetime) = ', CAST(search_overdue_borrowings AS CHAR));
    END IF;

	SET @t1 = CONCAT(@t1, ' AND DATEDIFF(CURDATE(), bd.datetime) >= 7');
    SET @t1 = CONCAT(@t1, ' GROUP BY user_name, b.title, bd.datetime');

    -- Prepare and execute the dynamic SQL statement
    PREPARE stmt3 FROM @t1;
		EXECUTE stmt3;
    DEALLOCATE PREPARE stmt3;
END //

DELIMITER ;

-- CALL get_list('g', '', 0);