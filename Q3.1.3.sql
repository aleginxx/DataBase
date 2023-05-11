-- an thelei mono to megisto tote kratas auto
select max(ret.max_count) from (select count(b.isbn) as max_count
 from school_user su, book b, book_demand bd
 where su.username_su=bd.username_su
    and bd.isbn=b.isbn
    and year(su.birth_date) <= year(CURDATE()) - 40
    and su.role='T'
    and bd.category='B'
group by su.username_su) as ret;

-- diaforetika gurnas mia lista me descending order tou counter
select count(b.isbn) as booking_count
 from school_user su, book b, book_demand bd
 where su.username_su=bd.username_su
    and bd.isbn=b.isbn
    and year(su.birth_date) <= year(CURDATE()) - 40
    and su.role='T'
    and bd.category='B'
group by su.username_su
order by booking_count desc;