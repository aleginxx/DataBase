-- central manager registers School_Unit

DELIMITER //

DROP PROCEDURE IF EXISTS add_school_unit //

CREATE PROCEDURE add_school_unit (
	IN input_phone_number VARCHAR(100) ,
    IN input_name VARCHAR(100) ,
    IN input_postal_code VARCHAR(100) ,
    IN input_city VARCHAR(100) ,
    IN input_email VARCHAR(100) ,
    IN input_principal_name VARCHAR(100) ,
    IN input_username_libm VARCHAR(100) 
)
BEGIN 
	DECLARE phone_check INT;
    
    SELECT COUNT(*) INTO phone_check
    FROM School_Unit su
    WHERE su.phone_number = input_phone_number;
    
    IF phone_check > 0 THEN 
		SELECT 'This School Unit is already registered.' AS Message;
        
	ELSE
		INSERT INTO School_Unit (phone_number, name, postal_code, city, email, principal_name, username_libm) VALUES (input_phone_number, input_name, input_postal_code, input_city, input_email, input_principal_name, input_username_libm);

	END IF;
    
END //

DELIMITER ;

-- CALL  add_school_unit('801-340-6569', '7ο ΕΠΑΛ Κολοκοτρωνιστίου', '45678', 'Arkadia', 'popotas@gmail.com', 'Aglaia Trelh', 'tasouola125');