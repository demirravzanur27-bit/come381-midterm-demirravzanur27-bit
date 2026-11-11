-- COME 381 - Ödev 2
-- Örnek veriler

-- Öğrenciler
INSERT INTO student (first_name, last_name, email, department, city)
VALUES
('Ayse', 'Yilmaz', 'ayse@example.com', 'Computer Engineering', 'Istanbul'),
('Mehmet', 'Demir', 'mehmet@example.com', 'Industrial Engineering', 'Ankara'),
('Zeynep', 'Kaya', 'zeynep@example.com', 'Computer Engineering', 'Istanbul'),
('Ali', 'Celik', 'ali@example.com', 'Business Administration', 'Izmir'),
('Elif', 'Sahin', 'elif@example.com', 'Industrial Engineering', 'Ankara');

-- Kulüpler
INSERT INTO club (club_name, description)
VALUES
('Software Club', 'Technology and software activities'),
('Photography Club', 'Photography workshops and events'),
('Environment Club', 'Environmental awareness activities'),
('Sports Club', 'Sports activities'),
('Career Club', 'Career development activities');

-- Kulüp üyelikleri
INSERT INTO membership (student_id, club_id, join_date, role)
VALUES
(1, 1, '2026-09-01', 'Member'),
(2, 1, '2026-09-02', 'President'),
(3, 2, '2026-09-03', 'Member'),
(4, 3, '2026-09-04', 'Member'),
(1, 4, '2026-09-05', 'Member'),
(2, 4, '2026-09-06', 'Member'),
(3, 5, '2026-09-07', 'Member');

-- Etkinlikler
INSERT INTO event
(club_id, event_name, event_date, event_end_date, location, capacity, category)
VALUES
(1, 'SQL Workshop', '2026-11-20', '2026-11-20', 'Lab 101', 30, 'Technology'),
(2, 'Photo Exhibition', '2026-11-22', '2026-11-23', 'Main Hall', 100, 'Arts'),
(3, 'Clean Campus', '2026-11-25', '2026-11-25', 'Campus Garden', 50, 'Environment'),
(5, 'Career Panel', '2026-11-27', '2026-11-27', 'Conference Hall', 80, 'Career'),
(4, 'Football Tournament', '2026-12-01', '2026-12-01', 'Sports Field', 40, 'Sports'),
(4, 'Basketball Tournament', '2026-12-05', '2026-12-05', 'Sports Hall', 40, 'Sports');

-- Etkinlik kayıtları
INSERT INTO event_registration
(student_id, event_id, registration_date, status)
VALUES
(1, 1, '2026-11-10', 'attended'),
(2, 1, '2026-11-10', 'attended'),
(3, 2, '2026-11-11', 'registered'),
(4, 3, '2026-11-11', 'cancelled'),
(1, 5, '2026-11-15', 'attended'),
(1, 6, '2026-11-15', 'attended'),
(2, 5, '2026-11-15', 'attended'),
(2, 6, '2026-11-15', 'attended'),
(3, 5, '2026-11-16', 'attended'),
(4, 4, '2026-11-16', 'registered');