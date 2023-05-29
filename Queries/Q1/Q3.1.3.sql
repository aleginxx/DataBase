select count(b.isbn) as borrowings, concat(su.first_name, " ", su.last_name) as user_name
	from school_user su, book b, book_demand bd
		where su.username_su=bd.username_su
        and bd.isbn=b.isbn
        and year(su.birth_date) > year(CURDATE()) - 40
        and su.role='T'
        and bd.category='B'
group by su.username_su 
order by borrowings desc;