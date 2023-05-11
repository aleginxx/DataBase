 select a.first_name, a.last_name
 from author a, Book_has_Author bha, book b
 where bha.Book_isbn=b.isbn
	and a.author_id=bha.Author_author_id
    and b.isbn not in (
		select bd.isbn
		from book_demand bd
        where bd.category='B'
	);
