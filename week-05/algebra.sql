-- COME 381 - Assignment 2
-- SQL equivalents of the relational algebra queries

-- Query 1: Find all Computer Engineering students
SELECT *
FROM student
WHERE department = 'Computer Engineering';


-- Query 2: List all clubs and their members
SELECT c.club_name, s.first_name, s.last_name
FROM club c
JOIN membership m ON c.club_id = m.club_id
JOIN student s ON m.student_id = s.student_id;


-- Query 3: Find all events organized by the Software Club
SELECT e.event_name, e.event_date, e.location
FROM event e
JOIN club c ON e.club_id = c.club_id
WHERE c.club_name = 'Software Club';


-- Query 4: Find students registered for the SQL Workshop
SELECT s.first_name, s.last_name
FROM student s
JOIN event_registration er ON s.student_id = er.student_id
JOIN event e ON er.event_id = e.event_id
WHERE e.event_name = 'SQL Workshop';


-- Query 5: Find students who belong to both clubs
SELECT s.student_id, s.first_name, s.last_name
FROM student s
JOIN membership m ON s.student_id = m.student_id
JOIN club c ON m.club_id = c.club_id
WHERE c.club_name IN ('Software Club', 'Photography Club')
GROUP BY s.student_id, s.first_name, s.last_name
HAVING COUNT(DISTINCT c.club_name) = 2;


-- Query 6: Find events with a capacity of at least 50
SELECT event_name, event_date, capacity
FROM event
WHERE capacity >= 50;