DELIMITER //

DROP PROCEDURE IF EXISTS get_list //

CREATE PROCEDURE get_list(
  IN search_title VARCHAR(100) AND OR
  IN search_author VARCHAR(100) AND OR
  IN search_genre VARCHAR(100) AND OR
  IN search_copies INT
)
BEGIN
  SELECT Book.title AS BookTitle, CONCAT(Author.first_name, ' ', Author.last_name) AS AuthorName
  FROM Book
  JOIN Book_Has_Author ON Book.isbn = Book_Has_Author.book_isbn
  JOIN Author ON Book_Has_Author.author_author_id = Author.author_id
  JOIN Book_Has_Genre ON Book.isbn = Book_Has_Genre.book_isbn
  JOIN Genre ON Book_Has_Genre.genre_genre_id = Genre.genre_id
  WHERE Book.title LIKE CONCAT('%', search_title, '%')
    AND Genre.category LIKE CONCAT('%', search_genre, '%')
    AND CONCAT(Author.first_name, ' ', Author.last_name) LIKE CONCAT('%', search_author, '%')
    AND Book.available_copies >= 1
    AND Author.author_id = (
      SELECT Book_Has_Author.author_author_id
      FROM Book_Has_Author
      JOIN Author ON Book_Has_Author.author_author_id = Author.author_id
      GROUP BY Book_Has_Author.author_author_id
      ORDER BY COUNT(Book_Has_Author.book_isbn) DESC
      LIMIT 1
    )
  ORDER BY Book.title DESC, Author.last_name DESC;
END //

DELIMITER ;

CALL get_list('Action');