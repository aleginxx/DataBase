-- submit review
-- if user is teacher, they don't need permission
-- if user is student, demand is labeled 'pending' and has to be approved by Library_Manager

DELIMITER //

DROP PROCEDURE IF EXISTS submit_review //

CREATE PROCEDURE submit_review(
	IN input_title VARCHAR(100),
    IN input_username VARCHAR(100) ,
    IN input_description MEDIUMTEXT,
    IN input_rating INT
)
BEGIN
	DECLARE role_value VARCHAR(1);
    DECLARE isbn_index VARCHAR(12);
    DECLARE Lib_Man VARCHAR(100);
    DECLARE phone_number VARCHAR(100);
    DECLARE check_review VARCHAR(100);
    
    SELECT su.role INTO role_value
    FROM school_user su
    WHERE su.username_su = input_username;
    
    -- store the school phone into variable phone_number
    SELECT su.phone_number INTO phone_number 
    FROM school_user su
    WHERE su.username_su = input_username;
    
    -- search for school unit with that phone number and load the username of its library manager
    SELECT sun.username_libm INTO Lib_Man
    FROM School_Unit sun
    WHERE sun.phone_number = phone_number;
    
    SELECT b.isbn INTO isbn_index
    FROM Book b
    WHERE b.title = input_title;
    
    -- Check if this user has made a review on this book
    SELECT COUNT(*) INTO check_review
	FROM Review r
	WHERE r.isbn = isbn_index AND r.username_su = input_username;
    
    IF check_review > 0 THEN
		SELECT 'You have already placed a review for this book. Sorry :) ' AS Message ;
		IF role_value = 'T' THEN
			INSERT INTO Review (isbn, username_su, description, rating, approved, username_libm) VALUES (isbn_index, input_username, input_description, input_rating, 'not needed', Lib_Man);
		ELSE 
			INSERT INTO Review (isbn, username_su, description, rating, approved, username_libm) VALUES (isbn_index, input_username, input_description, input_rating, 'pending', Lib_Man);
		END IF;
	END IF;
    
    END //
    
DELIMITER ;

-- CALL submit_review('Beautiful Girl', 'cpechan2', 'It was very interesting.', 4);