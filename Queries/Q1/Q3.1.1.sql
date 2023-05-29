DELIMITER //
DROP PROCEDURE IF EXISTS by_month_or_year //
CREATE PROCEDURE by_month_or_year(input_function VARCHAR(45), month_or_year VARCHAR(5))
BEGIN
  SET @t1 = CONCAT('SELECT ', input_function, ' AS ', month_or_year, ', unit.name, COUNT(*) as borrowings
                    FROM book_demand bd
                    JOIN school_user suser ON bd.username_su = suser.username_su
                    JOIN school_unit unit ON suser.phone_number = unit.phone_number
                    WHERE bd.category = \'B\' 
                    GROUP BY ', input_function, ', unit.name');
  
  PREPARE stmt3 FROM @t1;
  EXECUTE stmt3;
  DEALLOCATE PREPARE stmt3;	
END //
DELIMITER ;

-- call by_month_or_year('month(datetime)', 'Month');
-- call by_month_or_year('year(datetime)', 'Year');
