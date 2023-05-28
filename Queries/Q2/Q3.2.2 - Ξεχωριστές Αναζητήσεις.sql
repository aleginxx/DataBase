DELIMITER //

DROP PROCEDURE IF EXISTS borrowings_overdue_first_name //

CREATE PROCEDURE borrowings_overdue_first_name(
    IN input_first_name VARCHAR(255)
)
BEGIN
    -- Declare variables
    DECLARE done INT DEFAULT FALSE;
    DECLARE user_username_su VARCHAR(255);
    DECLARE cur CURSOR FOR
        SELECT username_su
        FROM School_user su 
        WHERE su.first_name = input_first_name;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Create temporary table to store intermediate results
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_results (
        username_su VARCHAR(255),
        isbn VARCHAR(12),
        days_passed INT
    );

    -- Open the cursor
    OPEN cur;

    -- Fetch the username_su value
    FETCH cur INTO user_username_su;

    -- Loop through the result set and insert into the temporary table
    WHILE NOT done DO
        INSERT INTO temp_results (username_su, isbn, days_passed)
        SELECT username_su, isbn, DATEDIFF(CURDATE(), `datetime`) AS days_passed
        FROM book_demand
        WHERE username_su = user_username_su
        AND category = 'B'
        AND DATEDIFF(CURDATE(), `datetime`) > 7;

        -- Fetch the next username_su value
        FETCH cur INTO user_username_su;
    END WHILE;

    -- Close the cursor
    CLOSE cur;

    -- Select the final result set from the temporary table
    SELECT username_su, isbn, days_passed
    FROM temp_results;

    -- Drop the temporary table
    DROP TEMPORARY TABLE IF EXISTS temp_results;
END //

DELIMITER ;

-- CALL borrowings_overdue_first_name('Zoe');

DELIMITER //

DROP PROCEDURE IF EXISTS borrowings_overdue_last_name //

CREATE PROCEDURE borrowings_overdue_last_name(
    IN input_last_name VARCHAR(255)
)
BEGIN
    -- Declare variables
    DECLARE done INT DEFAULT FALSE;
    DECLARE user_username_su VARCHAR(255);
    DECLARE cur CURSOR FOR
        SELECT username_su
        FROM School_user su 
        WHERE su.last_name = input_last_name;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Create temporary table to store intermediate results
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_results (
        username_su VARCHAR(255),
        isbn VARCHAR(12),
        days_passed INT
    );

    -- Open the cursor
    OPEN cur;

    -- Fetch the username_su value
    FETCH cur INTO user_username_su;

    -- Loop through the result set and insert into the temporary table
    WHILE NOT done DO
        INSERT INTO temp_results (username_su, isbn, days_passed)
        SELECT username_su, isbn, DATEDIFF(CURDATE(), `datetime`) AS days_passed
        FROM book_demand
        WHERE username_su = user_username_su
        AND category = 'B'
        AND DATEDIFF(CURDATE(), `datetime`) > 7;

        -- Fetch the next username_su value
        FETCH cur INTO user_username_su;
    END WHILE;

    -- Close the cursor
    CLOSE cur;

    -- Select the final result set from the temporary table
    SELECT username_su, isbn, days_passed
    FROM temp_results;

    -- Drop the temporary table
    DROP TEMPORARY TABLE IF EXISTS temp_results;
END //

DELIMITER ;

-- CALL borrowings_overdue_last_name('Gkenakou');

DELIMITER //

DROP PROCEDURE IF EXISTS borrowings_overdue_days_passed //

CREATE PROCEDURE borrowings_overdue_days_passed(
    IN input_days_passed INT
)
BEGIN
    -- Create temporary table to store intermediate results
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_results (
        username_su VARCHAR(255),
        isbn VARCHAR(12),
        available_copies INT
    );

    -- Insert into the temporary table
    INSERT INTO temp_results (username_su, isbn, available_copies)
    SELECT bd.username_su, bd.isbn, b.available_copies
    FROM book_demand bd
    JOIN book b ON bd.isbn = b.isbn
    WHERE bd.category = 'B'
    AND DATEDIFF(CURDATE(), bd.datetime) > input_days_passed;

    -- Select the final result set from the temporary table
    SELECT username_su, isbn, available_copies
    FROM temp_results;

    -- Drop the temporary table
    DROP TEMPORARY TABLE IF EXISTS temp_results;
END //

DELIMITER ;


-- CALL borrowings_overdue_days_passed(10);