DELIMITER //

DROP PROCEDURE IF EXISTS get_list //

CREATE PROCEDURE get_list(
  IN search_title VARCHAR(100),
  IN search_author VARCHAR(100),
  IN search_genre VARCHAR(100),
  IN search_copies INT
)
BEGIN
  SET @t1 = 'SELECT DISTINCT CONCAT(a.first_name, '' '', a.last_name) AS author_name, b.title
             FROM author a, genre g, book b, Book_has_Genre bhg, Book_has_Author bha
             WHERE bhg.Book_isbn = b.isbn AND g.genre_id = bhg.Genre_genre_id
               AND bha.Book_isbn = b.isbn AND a.author_id = bha.Author_author_id';

  IF search_genre != '' THEN
    SET @t1 = CONCAT(@t1, ' AND g.category LIKE ''%', search_genre, '%''');
  END IF;

  IF search_author != '' THEN
    SET @t1 = CONCAT(@t1, ' AND CONCAT(a.first_name, '' '', a.last_name) LIKE ''%', search_author, '%''');
  END IF;

  IF search_title != '' THEN
    SET @t1 = CONCAT(@t1, ' AND b.title LIKE ''%', search_title, '%''');
  END IF;

  IF search_copies != 0 THEN
    SET @t1 = CONCAT(@t1, ' AND b.available_copies >= ', search_copies);
  END IF;

  SET @t1 = CONCAT(@t1, ' GROUP BY g.category, author_name, b.title;'); 

  PREPARE stmt3 FROM @t1;
  EXECUTE stmt3;
  DEALLOCATE PREPARE stmt3;	
END //

DELIMITER ;

-- CALL get_list('f', 'g', '', 0);