DELETE FROM Book_Demand
WHERE DATEDIFF(CURDATE(), datetime) >= 6 AND category = 'R' ;
