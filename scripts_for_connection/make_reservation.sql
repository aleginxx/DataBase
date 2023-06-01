-- make book reservation 
-- if a book borrowing is overdue user is not allowed to make a reservation 
-- if user is teacher, they are allowed up to 1 reservation
-- if user is student, they are allowed up to 2 reservations

DELIMITER //

DROP PROCEDURE IF EXISTS make_reservation //

CREATE PROCEDURE make_reservation(
	IN input_title VARCHAR(100),
    IN input_username VARCHAR(100)
)
BEGIN
	DECLARE role_value VARCHAR(1);
    DECLARE count_r INT;
    DECLARE isbn_index VARCHAR(12);
    DECLARE Lib_Man VARCHAR(100);
    DECLARE check_borrowings INT;
    DECLARE count_existing INT;
    
    SELECT su.role INTO role_value
    FROM school_user su
    WHERE su.username_su = input_username;
    
    SELECT b.isbn INTO isbn_index
    FROM Book b
    WHERE b.title = input_title;
    
    SELECT COUNT(*) INTO check_borrowings
    FROM Book_Demand bd
    WHERE bd.state = 'overdue' AND bd.username_su = input_username;
    
    IF check_borrowings > 0 THEN 
		SELECT 'I am sorry, but seeing as you have delayed the return of a book(s) you cannot place any more reservations.' AS Message;
        
	ELSE
		IF role_value = 'S' THEN
			SELECT COUNT(*) INTO count_r
            FROM Book_Demand bd
            WHERE bd.category = 'R' AND bd.username_su = input_username;
                        
            IF count_r > 2 THEN
				SELECT 'You cannot place any more book reservations.' AS Message;
			ELSE 
				-- Check if the record already exists
				SELECT COUNT(*) INTO count_existing
				FROM Book_Demand bd
				WHERE bd.username_su = input_username AND bd.isbn = isbn_index AND bd.category = 'R';
                    
				IF count_existing = 0 THEN 
					SELECT 'You can place a book reservation.' AS Message;
					SELECT lm.username_libm INTO Lib_Man
					FROM Library_Manager lm
					ORDER BY RAND()
					LIMIT 1;
                        
					INSERT INTO Book_Demand (category, username_su, datetime, isbn, username_libm) VALUES ('R', input_username, current_date(), isbn_index, Lib_Man);
				ELSE
					SELECT 'You have already placed a book reservation for this book.' AS Message;
				END IF;
			END IF;
			
			ELSEIF role_value = 'T' THEN
				SELECT COUNT(*) INTO count_r
                FROM Book_Demand bd
                WHERE bd.category = 'R' AND bd.username_su = input_username;
                
                IF count_r >= 1 THEN
					SELECT 'You cannot place any more book reservations.' AS Message;
				ELSE 
					-- Check if the record already exists
					SELECT COUNT(*) INTO count_existing
					FROM Book_Demand bd
					WHERE bd.username_su = input_username AND bd.isbn = isbn_index AND bd.category = 'R';
                    
					IF count_existing = 0 THEN 
						SELECT 'You can place a book reservation.' AS Message;
						SELECT lm.username_libm INTO Lib_Man
						FROM Library_Manager lm
						ORDER BY RAND()
						LIMIT 1;
                        
						INSERT INTO Book_Demand (category, username_su, datetime, isbn, username_libm) VALUES ('R', input_username, current_date(), isbn_index, Lib_Man);
					ELSE
						SELECT 'You have already placed a book reservation for this book.' AS Message;
					END IF;
				END IF;
			END IF;
    END IF;
    
    END //
    
    DELIMITER ;
    
-- CALL make_reservation('Beautiful Girl', 'mwhittall1');