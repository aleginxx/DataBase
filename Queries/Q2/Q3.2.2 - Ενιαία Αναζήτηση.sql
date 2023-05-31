UPDATE Book_Demand bd
SET bd.state = 'overdue'
WHERE bd.category = 'B' AND DATEDIFF(CURDATE(), bd.datetime) >= 7 AND bd.state = 'active';

UPDATE Book_Demand bd
SET bd.state = 'active'
WHERE bd.category = 'B' AND DATEDIFF(CURDATE(), bd.datetime) < 7 AND bd.state = 'overdue';

DELIMITER //

DROP PROCEDURE IF EXISTS get_list //

CREATE PROCEDURE get_list(
    IN search_first_name VARCHAR(100),
    IN search_last_name VARCHAR(100),
    IN search_overdue_borrowings INT
)
BEGIN

    SET @t1 = 'SELECT DISTINCT b.title, DATEDIFF(bd.datetime, CURDATE()) AS days_passed, CONCAT(su.first_name, " ", su.last_name) AS user_name, bd.state
        FROM book b, school_user su, book_demand bd
        WHERE bd.isbn = b.isbn AND bd.username_su = su.username_su';

    IF @t1 != '' THEN
        SET @t1 = CONCAT(@t1, ' AND su.first_name LIKE "%', search_first_name, '%"');
    END IF;

    IF search_last_name != '' THEN
        SET @t1 = CONCAT(@t1, ' AND su.last_name LIKE "%', search_last_name, '%"');
    END IF;

    IF search_overdue_borrowings != 0 THEN
		SET @t1 = CONCAT(@t1, ' AND DATEDIFF(bd.datetime, CURDATE()) = ', CAST(search_overdue_borrowings AS CHAR));
    END IF;

	SET @t1 = CONCAT(@t1, ' AND bd.state = ''overdue'' ');
    SET @t1 = CONCAT(@t1, ' GROUP BY user_name, b.title, bd.datetime, bd.state');

    -- Prepare and execute the dynamic SQL statement
    PREPARE stmt3 FROM @t1;
		EXECUTE stmt3;
    DEALLOCATE PREPARE stmt3;
END //

DELIMITER ;

CALL get_list('r', '', 0);