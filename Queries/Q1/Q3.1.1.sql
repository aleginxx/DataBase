-- Q1 - group by month or year
DELIMITER //
DROP PROCEDURE IF EXISTS by_month_or_year //
CREATE PROCEDURE 
  by_month_or_year( input_function varchar(45), month_or_year varchar(5) )
BEGIN
  SET @t1 = CONCAT( 'SELECT ', input_function, ' as ', month_or_year, ', unit.name, count(*) from book_demand bd, school_unit unit, school_user suser 
  where bd.username_su = suser.username_su and suser.phone_number = unit.phone_number and bd.category=\'R\' group by unit.phone_number, ', month_or_year );
  PREPARE stmt3 FROM @t1;
  EXECUTE stmt3;
  DEALLOCATE PREPARE stmt3;	
END //
DELIMITER ;

call by_month_or_year('month(datetime)', 'Month');
call by_month_or_year('year(datetime)', 'Year');
