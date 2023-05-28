-- accepting signup for teacher-student

DELIMITER //

DROP PROCEDURE IF EXISTS accept_signup_user //

CREATE PROCEDURE accept_signup_user (
	IN input_username VARCHAR(100),
    IN input_password VARCHAR(100) ,
    IN input_first_name VARCHAR(100),
    IN input_last_name VARCHAR(100),
    IN input_birth_date date,
    IN input_phone_number VARCHAR(30) ,
    IN input_role VARCHAR(1)
)
BEGIN
UPDATE School_User su
    SET approved = 'accepted' 
    WHERE su.username_su = input_username AND su.password = input_password;
    
    END //
    
    DELIMITER ;
    
-- CALL accept_signup_user('godinternal', '8QvDwYh3F!kSPS3b', 'John', 'Stefanopoulos', '1974-04-22', '148-108-2401', 'S');