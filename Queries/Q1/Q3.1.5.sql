-- edw sou gurnaw th lista me tous daneismous pou exoyn kanei oi library managers, opote meta esu ston kwdika tha prepei na deis poioi kai an exoun iso arithmo daneismwn kapoioi apo autous
-- einai sorted se descending order h lista gia na se voithisei

select unit.phone_number, lm.username_libm, count(bd.isbn) as borrowing_count_per_unit
 from school_user user, school_unit unit, book b, book_demand bd, library_manager lm
 where bd.isbn=b.isbn
	and bd.username_su=user.username_su
    and user.phone_number=unit.phone_number
    and lm.username_libm=unit.username_libm
    and bd.category='B'
group by unit.username_libm
having borrowing_count_per_unit >= 20
order by borrowing_count_per_unit desc;