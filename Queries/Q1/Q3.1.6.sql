select distinct bhg1.genre_genre_id, bhg2.genre_genre_id, COUNT(*) countForCombination
from Book_has_Genre bhg1
inner join Book_has_Genre bhg2
on bhg1.book_isbn = bhg2.book_isbn
and bhg1.genre_genre_id < bhg2.genre_genre_id
inner join book_demand bd
on bd.isbn = bhg1.book_isbn
and bd.category='B'
group by bhg1.genre_genre_id, bhg2.genre_genre_id
order by countForCombination desc
limit 3;
