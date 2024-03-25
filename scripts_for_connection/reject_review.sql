DELIMITER //

DROP PROCEDURE IF EXISTS reject_review //

CREATE PROCEDURE reject_review(
	IN input_title VARCHAR(100),
    IN input_username VARCHAR(100) ,
    IN input_description MEDIUMTEXT
)
BEGIN
    DECLARE isbn_index VARCHAR(12);

	UPDATE Review r
    SET approved = 'rejected' 
    WHERE r.username_su = input_username AND r.description = input_description AND r.isbn = isbn_index ;
    
    END //
    
    DELIMITER ;
    
-- CALL reject_review('Beautiful Girl', 'cpechan2', 'It was very interesting.'); 


