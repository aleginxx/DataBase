-- view personal info 

DELIMITER //

DROP PROCEDURE IF EXISTS get_personal_info //

CREATE PROCEDURE get_personal_info (
	IN input_username VARCHAR(100) 
)
BEGIN 
	SELECT username_su, first_name, last_name, birth_date
    FROM School_User su
    WHERE su.username_su = input_username;
    
END //

DELIMITER ;

CALL get_personal_info('hbenitezq');
    