-- edit personal info

DELIMITER //

DROP PROCEDURE IF EXISTS edit_personal_info //

CREATE PROCEDURE edit_personal_info (
	IN current_username VARCHAR(100) ,
	IN search_username VARCHAR(100) ,
    IN search_first_name VARCHAR(100) ,
    IN search_last_name VARCHAR(100) ,
    IN search_birth_date date
)
BEGIN
	DECLARE value_role INT;
    
    SELECT COUNT(*) INTO value_role
    FROM School_User su
    WHERE su.username_su = current_username and su.role = 'T';
    
    IF value_role = 0 THEN SELECT 'This account does not exist or cannot modify their personal information.' AS Message;
    
	ELSE 
		IF search_username != '' THEN
			UPDATE School_User su
            SET su.username_su = search_username
            WHERE su.username_su = current_username;
		END IF;
        
        IF search_first_name != '' THEN
			UPDATE School_User su
			SET su.first_name = search_first_name
			WHERE su.username_su = current_username;
		END IF;
        
        IF search_last_name != '' THEN 
			UPDATE School_User su
			SET su.last_name = search_last_name
			WHERE su.username_su = current_username;
		END IF;
        
        IF search_birth_date IS NOT NULL THEN
			UPDATE School_User su
            SET su.birth_date = search_birth_date
            WHERE su.username_su = current_username;
		END IF;

	END IF; 
    
	END //
        
DELIMITER ;

-- CALL edit_personal_info('ndallinder01', '', '9sw5nGaKAG', '', NULL);