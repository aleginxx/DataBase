DELIMITER //

DROP PROCEDURE IF EXISTS delete_reservation //

CREATE PROCEDURE delete_reservation (
	IN input_isbn VARCHAR(12),
    IN input_username VARCHAR(100)
)
BEGIN
	DELETE FROM Book_Demand 
    WHERE isbn = input_isbn AND username_su = input_username AND category = 'R';
END //

DELIMITER ;

-- CALL delete_reservation('576974821-4', 'bbaniard8');