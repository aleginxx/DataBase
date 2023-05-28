-- supervise book demands

DELIMITER //

DROP PROCEDURE IF EXISTS get_list_book_demands //

CREATE PROCEDURE get_list_book_demands (
	IN search_username VARCHAR(100)
)
BEGIN 
	DECLARE stmt VARCHAR(1000);

	SET @t1 = 'SELECT b.title, bd.category
          FROM School_User su
          JOIN Book_Demand bd ON su.username_su = bd.username_su
          JOIN Book b ON b.isbn = bd.isbn';


	IF search_username != '' THEN 
		SET @t1 = CONCAT(@t1, ' WHERE su.username_su LIKE ''%', search_username, '%''');
        
        SET @t1 = CONCAT(@t1, ' ORDER BY su.username_su, b.title;');
        
		SET @stmt = @t1;
		PREPARE stmt FROM @stmt;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
    
	ELSE 
		SELECT title FROM Book ORDER BY title ASC;
	END IF;


END //

DELIMITER ;

-- CALL get_list_book_demands('apiggen0');