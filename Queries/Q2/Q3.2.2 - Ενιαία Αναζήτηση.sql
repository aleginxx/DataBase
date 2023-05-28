DELIMITER //

DROP PROCEDURE IF EXISTS get_list //

CREATE PROCEDURE get_list(
    IN search_first_name VARCHAR(100),
    IN search_last_name VARCHAR(100),
    IN search_overdue_borrowings INT
)
BEGIN
    -- Declare variables
    DECLARE sql_statement VARCHAR(1000);

    -- Build the SQL statement dynamically
    SET sql_statement = 'SELECT DISTINCT b.title, DATEDIFF(CURDATE(), bd.datetime) AS days_passed, CONCAT(su.first_name, " ", su.last_name) AS user_name
        FROM book b, school_user su, book_demand bd
        WHERE bd.isbn = b.isbn AND bd.username_su = su.username_su';

    IF search_first_name != '' THEN
        SET sql_statement = CONCAT(sql_statement, ' AND su.first_name LIKE "%', search_first_name, '%"');
    END IF;

    IF search_last_name != '' THEN
        SET sql_statement = CONCAT(sql_statement, ' AND su.last_name LIKE "%', search_last_name, '%"');
    END IF;

    IF search_overdue_borrowings != 0 THEN
        SET sql_statement = CONCAT(sql_statement, ' AND DATEDIFF(CURDATE(), bd.datetime) >= ', CAST(search_overdue_borrowings AS CHAR));
    END IF;

    SET sql_statement = CONCAT(sql_statement, ' GROUP BY user_name, b.title');

    -- Prepare and execute the dynamic SQL statement
    PREPARE stmt FROM sql_statement;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;

-- CALL get_list('', 'Axristos', 0);