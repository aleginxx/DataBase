-- accepting library manager signup

DELIMITER //

DROP PROCEDURE IF EXISTS accept_signup_library_manager //

CREATE PROCEDURE accept_signup_library_manager(
	IN input_username VARCHAR(100),
    IN input_password VARCHAR(100) ,
    IN input_first_name VARCHAR(100),
    IN input_last_name VARCHAR(100),
    IN input_birth_date date,
    IN input_phone_number VARCHAR(30)
)
BEGIN 
    UPDATE Library_Manager lm
    SET approved = 'accepted' 
    WHERE lm.username_libm = input_username AND lm.password = input_password;
    
    UPDATE School_User su
    SET approved = 'accepted' 
    WHERE su.username_su = input_username AND su.password = input_password;
    
    END //
    
    DELIMITER ;
    
-- CALL accept_signup_library_manager('godinternal', '8QvDwYh3F!kSPS3b', 'John', 'Stefanopoulos', '1974-04-22', '477-778-5386');
    
