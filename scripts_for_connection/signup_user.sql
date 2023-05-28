-- signup for teacher-student

DELIMITER //

DROP PROCEDURE IF EXISTS signup_user //

CREATE PROCEDURE signup_user (
	IN input_username VARCHAR(100),
    IN input_password VARCHAR(100) ,
    IN input_first_name VARCHAR(100),
    IN input_last_name VARCHAR(100),
    IN input_birth_date date,
    IN input_phone_number VARCHAR(30) ,
    IN input_role VARCHAR(1)
)
BEGIN
	DECLARE username_check INT;
    
    SELECT COUNT(*) INTO username_check
    FROM School_User su
    WHERE su.username_su = input_username;
    
    IF username_check > 0 THEN 
		SELECT 'This username already exists. Please choose a different one.' AS Message; 
    
    ELSE 
		SELECT COUNT(*) INTO username_check
		FROM Library_Manager lm
		WHERE lm.username_libm = input_username;
		
        IF username_check > 0 THEN 
			INSERT INTO School_User (username_su, password, first_name, last_name, birth_date, role, phone_number, is_lm, approved) VALUES (input_username, input_password, input_first_name, input_last_name, input_birth_date, input_role, input_phone_number, 1, 'pending');
		ELSE 
			INSERT INTO School_User (username_su, password, first_name, last_name, birth_date, role, phone_number, is_lm, approved) VALUES (input_username, input_password, input_first_name, input_last_name, input_birth_date, input_role, input_phone_number, 0, 'pending');
		
        END IF;
        
	END IF;
    
    END //
    
DELIMITER ;
    
-- CALL signup_user('godinternal', '8QvDwYh3F!kSPS3b', 'John', 'Stefanopoulos', '1974-04-22', '148-108-2401', 'S');