DELIMITER //

DROP PROCEDURE IF EXISTS get_list //

CREATE PROCEDURE get_list(
	IN search_title VARCHAR(100),
	IN search_author VARCHAR(100),
	IN search_genre VARCHAR(100)
)
BEGIN
 set @t1 = 'select distinct b.title, concat(a.first_name, '' '', a.last_name) as author_name, g.category
 from author a, genre g, book b, Book_has_Genre bhg, Book_has_Author bha
 where bhg.Book_isbn=b.isbn and g.genre_id=bhg.Genre_genre_id
	and bha.Book_isbn=b.isbn and a.author_id=bha.Author_author_id';
IF search_genre != '' then
	set @t1 = CONCAT(@t1, ' and g.category like ''%', search_genre,'%''');
end if;

IF search_author != '' then
	set @t1 = CONCAT(@t1, ' and CONCAT(a.first_name, '' '', a.last_name) LIKE ''%', search_author,'%''');
end if;

IF search_title != '' then
	set @t1 = CONCAT(@t1, ' and b.title like ''%', search_title,'%''');
end if;
    
set @t1 = concat(@t1, ' group by author_name, b.title;'); 

PREPARE stmt3 FROM @t1;
EXECUTE stmt3;
DEALLOCATE PREPARE stmt3;	
END //

DELIMITER ;


-- CALL get_list('', 'Trelevan', '');
