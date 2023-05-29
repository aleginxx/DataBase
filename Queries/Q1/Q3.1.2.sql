-- Q2 
DELIMITER //
DROP PROCEDURE IF EXISTS get_teachers_authors_by_genre //
CREATE PROCEDURE 
  get_teachers_authors_by_genre( input_category varchar(45) )
BEGIN
 select g.category, a.first_name as author_name, a.last_name as author_last_name, su.username_su as teacher_username
 from author a, genre g, book b, Book_has_Genre bhg, Book_has_Author bha, school_user su, book_demand bd
 where bhg.Book_isbn=b.isbn and g.genre_id=bhg.Genre_genre_id
	and bha.Book_isbn=b.isbn and a.author_id=bha.Author_author_id
    and bd.isbn=b.isbn
    and bd.username_su=su.username_su
    and bd.category='B'
    and year(bd.datetime) >= year(CURDATE()) - 1
    and su.role='T'
    and g.category like CONCAT('%', input_category, '%');
END //
DELIMITER ;

-- Example call of proc
-- call get_teachers_authors_by_genre('Horror');
-- call get_teachers_authors_by_genre('Action');
