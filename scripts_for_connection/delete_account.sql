-- delete accounts 

DELIMITER //

DROP PROCEDURE IF EXISTS delete_account //

CREATE PROCEDURE delete_account (
	IN input_username VARCHAR(100)
)
BEGIN
	DECLARE check_username INT;
    
    SELECT count(*) INTO check_username
    FROM Central_Manager cm
    WHERE cm.username_cm = input_username;
    
    IF check_username > 0 THEN SELECT 'You cannot delete the Central Manager.' AS Message;
    
    ELSE
		SELECT COUNT(*) INTO check_username
        FROM Library_Manager lm
        WHERE lm.username_libm = input_username;
        
		IF check_username > 0 THEN SELECT 'You cannot delete the Library Manager.' AS Message;
        
        ELSE 
			SELECT COUNT(*) INTO check_username
            FROM School_User su
            WHERE su.username_su = input_username;
            
			IF check_username > 0 THEN 
				DELETE FROM School_User WHERE username_su = input_username ;
			ELSE 
				SELECT 'This account does not exist.' AS Message;
			END IF;
		END IF;
	END IF;

	END //
    
DELIMITER ;

-- CALL delete_account('godinternal');