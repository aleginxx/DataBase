DELIMITER //

DROP PROCEDURE IF EXISTS get_list //

CREATE PROCEDURE get_list(
    IN search_username VARCHAR(100)
)
BEGIN

SET @t1 = 'SELECT DISTINCT b.title, CONCAT(su.first_name, " ", su.last_name) AS user_name, bd.state 
        FROM book b
        JOIN book_demand bd ON bd.isbn = b.isbn
        JOIN school_user su ON bd.username_su = su.username_su
        JOIN Book_has_Genre bhg ON b.isbn = bhg.Book_isbn
        JOIN genre g ON bhg.Genre_genre_id = g.genre_id';

IF search_username != '' THEN
	SET @t1 = CONCAT(@t1, ' AND bd.username_su LIKE ''%', search_username, '%''');
END IF;

SET @t1 = CONCAT(@t1, ' AND bd.state IN ("active", "overdue")  AND bd.category = ''B'' ');
SET @t1 = CONCAT(@t1, ' GROUP BY b.title, user_name, bd.state');

-- Prepare and execute the dynamic SQL statement
PREPARE stmt3 FROM @t1;
EXECUTE stmt3;
DEALLOCATE PREPARE stmt3;

END //

DELIMITER ;

CALL get_list('z');