DELIMITER //

DROP PROCEDURE IF EXISTS get_list //

CREATE PROCEDURE get_list()
BEGIN
    SET @t1 = CONCAT("SELECT DISTINCT b.title, CONCAT(su.first_name, \' \', su.last_name) AS user_name, bd.state 
        FROM book b
        JOIN book_demand bd ON bd.isbn = b.isbn
        JOIN school_user su ON bd.username_su = su.username_su
        WHERE su.username_su = \'", "'.$connectedUsername.'", "\'
        AND bd.state IN (\"active\", \"overdue\")
        GROUP BY b.title, user_name, bd.state");

    -- Prepare and execute the dynamic SQL statement
    PREPARE stmt3 FROM @t1;
    EXECUTE stmt3;
    DEALLOCATE PREPARE stmt3;

END

DELIMITER ;

CALL get_list('z');
