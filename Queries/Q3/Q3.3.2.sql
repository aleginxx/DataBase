DELIMITER //

DROP PROCEDURE IF EXISTS get_list //

CREATE PROCEDURE get_list(
    IN search_name VARCHAR(100)
)
BEGIN

    SET @t1 = 'SELECT DISTINCT b.title, CONCAT(su.first_name, " ", su.last_name) AS user_name, g.category
        FROM book b, school_user su, book_demand bd, genre g
        WHERE bd.isbn = b.isbn AND bd.username_su = su.username_su';

    IF search_name != '' THEN
	SET @t1 = CONCAT(@t1, ' and CONCAT(su.first_name, '' '', su.last_name) LIKE ''%', search_name,'%''');
	END IF;
    
    SET @t1 = CONCAT(@t1, ' GROUP BY user_name');

    -- Prepare and execute the dynamic SQL statement
    PREPARE stmt3 FROM @t1;
		EXECUTE stmt3;
    DEALLOCATE PREPARE stmt3;
END //

DELIMITER ;

-- CALL get_list('z');