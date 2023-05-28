-- change password

DELIMITER //

DROP PROCEDURE IF EXISTS change_password //

CREATE PROCEDURE change_password (
	IN input_username VARCHAR(100),
    IN current_password VARCHAR(100),
    IN new_password VARCHAR(100)
    )
BEGIN
DECLARE username_check INT;
    
SELECT COUNT(*) INTO username_check
FROM Library_Manager lm
WHERE lm.username_libm = input_username AND lm.password = current_password;
    
IF username_check > 0 THEN 
	UPDATE Library_Manager lm
    SET lm.password = new_password
    WHERE lm.username_libm = input_username;

ELSE 
	SELECT COUNT(*) INTO username_check
	FROM School_User su
	WHERE su.username_su = input_username AND su.password = current_password;
    
    IF username_check > 0 THEN 
		UPDATE School_User su
		SET su.password = new_password
		WHERE su.username_su = input_username;
        
	ELSE 
		SELECT 'Your login information is not correct.' AS Message;
        
	END IF;
    
END IF;

END //

DELIMITER ;

-- CALL change_password('kpym7', 'USdkpqxHi12', 'x3G991cY');