SELECT DISTINCT COUNT(bd.isbn) AS borrowing_count_per_unit, CONCAT(user.first_name, " ", user.last_name) AS user_name
FROM school_user user, school_unit unit, book b, book_demand bd, library_manager lm
WHERE bd.isbn = b.isbn
	AND bd.username_su = user.username_su
	AND lm.username_libm = bd.username_libm
	AND bd.category = 'B'
GROUP BY unit.username_libm, lm.username_libm
HAVING borrowing_count_per_unit > 20
ORDER BY borrowing_count_per_unit DESC;
