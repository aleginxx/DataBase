UPDATE Book_Demand bd
SET bd.state = 'overdue'
WHERE bd.category = 'B' AND DATEDIFF(CURDATE(), bd.datetime) >= 7 AND bd.state = 'active';

UPDATE Book_Demand bd
SET bd.state = 'active'
WHERE bd.category = 'B' AND DATEDIFF(CURDATE(), bd.datetime) < 7 AND bd.state = 'overdue';
