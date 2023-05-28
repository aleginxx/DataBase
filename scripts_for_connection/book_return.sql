-- book return 

DELIMITER //

DROP PROCEDURE IF EXISTS book_return //

CREATE PROCEDURE book_return (
	IN input_username VARCHAR(100) ,
    IN input_title VARCHAR(100) 
)
BEGIN 
	DECLARE find_borrowing INT ;
    DECLARE copies INT;
    DECLARE isbn_index VARCHAR(12);

	SELECT b.isbn INTO isbn_index
    FROM Book b
    WHERE b.title = input_title;

	SELECT COUNT(*) INTO find_borrowing
	FROM Book_Demand bd
	WHERE bd.username_su = input_username AND bd.isbn = isbn_index;

	IF find_borrowing = 0 THEN SELECT 'There is no such borrowing registered.' AS Message;

	ELSE
		SELECT b.available_copies INTO copies
		FROM Book b
		WHERE b.title = input_title;
        
        UPDATE Book SET available_copies = copies-1 WHERE isbn = isbn_index;
        
        DELETE FROM Book_Demand WHERE username_su = input_username AND isbn = isbn_index;
        
	END IF;

END //

DELIMITER ;

CALL book_return('smcgourtyo', 'Ten'); 
