-- COME 381 - Assignment 2
-- Invalid data tests: These statements should fail.

-- 1. first_name cannot be NULL
INSERT INTO student (first_name, last_name, email, department)
VALUES (NULL, 'Test', 'nullname@example.com', 'Computer Engineering');

-- 2. Student email must be unique
INSERT INTO student (first_name, last_name, email, department)
VALUES ('Test', 'User', 'ayse@example.com', 'Computer Engineering');

-- 3. Club name must be unique
INSERT INTO club (club_name, description)
VALUES ('Software Club', 'Duplicate club');

-- 4. Event capacity cannot be 0
INSERT INTO event (club_id, event_name, event_date, event_end_date, location, capacity)
VALUES (1, 'Invalid Event 1', '2026-12-01', '2026-12-01', 'Lab 101', 0);

-- 5. Event capacity cannot exceed 500
INSERT INTO event (club_id, event_name, event_date, event_end_date, location, capacity)
VALUES (1, 'Invalid Event 2', '2026-12-02', '2026-12-02', 'Lab 101', 501);

-- 6. Event end date cannot be before event date
INSERT INTO event (club_id, event_name, event_date, event_end_date, location, capacity)
VALUES (1, 'Invalid Event 3', '2026-12-05', '2026-12-04', 'Lab 101', 30);

-- 7. Same club cannot have duplicate event name on the same date
INSERT INTO event (club_id, event_name, event_date, event_end_date, location, capacity)
VALUES (1, 'SQL Workshop', '2026-11-20', '2026-11-20', 'Lab 101', 30);

-- 8. Registration status must be valid
INSERT INTO event_registration (student_id, event_id, registration_date, status)
VALUES (1, 1, '2026-11-12', 'invalid_status');

-- 9. Membership join_date cannot be NULL
INSERT INTO membership (student_id, club_id, join_date, role)
VALUES (1, 2, NULL, 'Member');

-- 10. Student must exist before membership is created
INSERT INTO membership (student_id, club_id, join_date, role)
VALUES (9999, 1, '2026-11-12', 'Member');