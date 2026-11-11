-- COME 381 - Assignment 2
-- Sample data (seed data)

INSERT INTO student (first_name, last_name, email, department)
VALUES
('Ayse', 'Yilmaz', 'ayse@example.com', 'Computer Engineering'),
('Mehmet', 'Demir', 'mehmet@example.com', 'Industrial Engineering'),
('Zeynep', 'Kaya', 'zeynep@example.com', 'Computer Engineering'),
('Ali', 'Celik', 'ali@example.com', 'Business Administration'),
('Elif', 'Sahin', 'elif@example.com', 'Industrial Engineering');

INSERT INTO club (club_name, description)
VALUES
('Software Club', 'Technology and software activities'),
('Photography Club', 'Photography workshops and events'),
('Environment Club', 'Environmental awareness activities');

INSERT INTO membership (student_id, club_id, join_date, role)
VALUES
(1, 1, '2026-09-01', 'Member'),
(2, 1, '2026-09-02', 'President'),
(3, 2, '2026-09-03', 'Member'),
(4, 3, '2026-09-04', 'Member'),
(5, 2, '2026-09-05', 'Member');

INSERT INTO event
(club_id, event_name, event_date, location, capacity, event_end_date)
VALUES
(1, 'SQL Workshop', '2026-11-20', 'Lab 101', 30, '2026-11-20'),
(2, 'Photo Exhibition', '2026-11-22', 'Main Hall', 100, '2026-11-23'),
(3, 'Clean Campus', '2026-11-25', 'Campus Garden', 50, '2026-11-25');

INSERT INTO event_registration
(student_id, event_id, registration_date, status)
VALUES
(1, 1, '2026-11-10', 'registered'),
(2, 1, '2026-11-10', 'attended'),
(3, 2, '2026-11-11', 'registered'),
(4, 3, '2026-11-11', 'cancelled'),
(5, 2, '2026-11-11', 'registered');