DELIMITER //

DROP PROCEDURE IF EXISTS make_book_demand //

CREATE PROCEDURE make_book_demand(
    IN input_title VARCHAR(100),
    IN input_username VARCHAR(100)
)
BEGIN
    DECLARE role_value VARCHAR(1);
    DECLARE count_b INT;
    DECLARE count_r INT;
    DECLARE count_existing INT;
    DECLARE isbn_index VARCHAR(12);
    DECLARE copies INT;
    DECLARE Lib_Man VARCHAR(100);
    
    SELECT su.role INTO role_value
    FROM school_user su
    WHERE su.username_su = input_username;
    
    SELECT b.isbn INTO isbn_index
    FROM Book b
    WHERE b.title = input_title;
        
    SELECT b.available_copies INTO copies
    FROM Book b
    WHERE b.title = input_title;
    
    IF copies = 0 THEN 
        SELECT 'The book is unavailable' AS Message;
	
    ELSE  
        IF role_value = 'S' THEN
            SELECT COUNT(*) INTO count_b
            FROM Book_Demand bd
            WHERE bd.category = 'B' AND bd.username_su = input_username;
                
            IF count_b = 2 THEN
                SELECT COUNT(*) INTO count_r
                FROM Book_Demand bd
                WHERE bd.category = 'R' AND bd.username_su = input_username;
                        
                IF count_r = 2 THEN
                    SELECT 'You cannot place any more book reservations.' AS Message;
                
                ELSEIF count_r < 2 THEN
                    -- Check if the record already exists
					SELECT COUNT(*) INTO count_existing
					FROM Book_Demand bd
					WHERE bd.username_su = input_username AND bd.isbn = isbn_index;
                                        
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
            
            ELSEIF count_b < 2 THEN
                SELECT lm.username_libm INTO Lib_Man
                FROM Library_Manager lm
                ORDER BY RAND()
                LIMIT 1;
                
                -- Check if the record already exists
				SELECT COUNT(*) INTO count_existing
				FROM Book_Demand bd
				WHERE bd.username_su = input_username AND bd.isbn = isbn_index;
									
				IF count_existing = 0 THEN 
					-- SELECT 'You can borrow this book.' AS Message;
					SELECT lm.username_libm INTO Lib_Man
					FROM Library_Manager lm
					ORDER BY RAND()
					LIMIT 1;
					
					INSERT INTO Book_Demand (category, username_su, datetime, isbn, username_libm) VALUES ('R', input_username, current_date(), isbn_index, Lib_Man);
                    UPDATE Book SET available_copies = copies-1 WHERE isbn = isbn_index;
                    SELECT 'You can pickup the book from the school library.' AS Message;
				ELSE
					SELECT 'You have already placed a book reservation for this book.' AS Message;
				END IF;
            END IF;
        END IF;
    END IF; 
END // 

DELIMITER ;

CALL make_book_demand('Ten', 'smcgourtyo');
