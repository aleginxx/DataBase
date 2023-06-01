-- make book borrowing 
-- if a book borrowing is overdue user is not allowed to make a reservation 
-- if user is teacher, they are allowed up to 1 reservation
-- if user is student, they are allowed up to 2 reservations

DELIMITER //

DROP PROCEDURE IF EXISTS make_reservation_borrowing //

CREATE PROCEDURE make_reservation_borrowing(
	IN input_title VARCHAR(100),
    IN input_username VARCHAR(100)
)
BEGIN
	DECLARE role_value VARCHAR(1);
    DECLARE count_b INT;
    DECLARE isbn_index VARCHAR(12);
    DECLARE Lib_Man VARCHAR(100);
    DECLARE check_borrowings INT;
    DECLARE count_existing INT;
    DECLARE phone_number VARCHAR(100);
    
    -- store the school phone into variable phone_number
    SELECT su.phone_number INTO phone_number 
    FROM school_user su
    WHERE su.username_su = input_username;
    
    -- search for school unit with that phone number and load the username of its library manager
    SELECT sun.username_libm INTO Lib_Man
    FROM School_Unit sun
    WHERE sun.phone_number = phone_number;
    
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
		SELECT 'I am sorry, but seeing as you have delayed the return of a book(s), you cannot place any more reservations.' AS Message;
        
	ELSE
		IF role_value = 'S' THEN
			SELECT COUNT(*) INTO count_b
            FROM Book_Demand bd
            WHERE bd.category = 'B' AND bd.username_su = input_username;
                        
            IF count_b > 2 THEN
				SELECT 'You cannot place any more book reservations.' AS Message;
			ELSE 
				-- Check if the record already exists
				SELECT COUNT(*) INTO count_existing
				FROM Book_Demand bd
				WHERE bd.username_su = input_username AND bd.isbn = isbn_index AND bd.category = 'B';
                    
				IF count_existing = 0 THEN 
					SELECT 'You can place a book reservation.' AS Message;
					                    
					INSERT INTO Book_Demand (category, username_su, datetime, isbn, username_libm, state) VALUES ('B', input_username, CURRENT_DATE(), isbn_index, Lib_Man, 'active');
                ELSE
					SELECT 'You have already placed a book reservation for this book.' AS Message;
				END IF;
			END IF;
			
		ELSEIF role_value = 'T' THEN
			SELECT COUNT(*) INTO count_b
            FROM Book_Demand bd
            WHERE bd.category = 'B' AND bd.username_su = input_username;
                
            IF count_b >= 1 THEN
				SELECT 'You cannot place any more book reservations.' AS Message;
			ELSE 
				-- Check if the record already exists
				SELECT COUNT(*) INTO count_existing
				FROM Book_Demand bd
				WHERE bd.username_su = input_username AND bd.isbn = isbn_index AND bd.category = 'B';
                    
				IF count_existing = 0 THEN 
					SELECT 'You can place a book reservation.' AS Message;
                        
					INSERT INTO Book_Demand (category, username_su, datetime, isbn, username_libm, state) VALUES ('B', input_username, CURRENT_DATE(), isbn_index, Lib_Man, 'active');
				ELSE
					SELECT 'You have already placed a book reservation for this book.' AS Message;
				END IF;
			END IF;
		END IF;
    END IF;
    
END //

DELIMITER ;
    
-- CALL make_reservation_borrowing('Beautiful Girl', 'mwhittall1');