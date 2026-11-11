-- COME 381 - Assignment 2
-- NOT NULL, UNIQUE ve CHECK constraints

-- Etkinlik bitiş tarihini ekliyoruz.
ALTER TABLE event
ADD COLUMN event_end_date DATE;

-- NOT NULL constraints
ALTER TABLE student
    ALTER COLUMN first_name SET NOT NULL,
    ALTER COLUMN last_name SET NOT NULL,
    ALTER COLUMN email SET NOT NULL,
    ALTER COLUMN department SET NOT NULL;

ALTER TABLE club
    ALTER COLUMN club_name SET NOT NULL;

ALTER TABLE membership
    ALTER COLUMN join_date SET NOT NULL,
    ALTER COLUMN role SET NOT NULL;

ALTER TABLE event
    ALTER COLUMN club_id SET NOT NULL,
    ALTER COLUMN event_name SET NOT NULL,
    ALTER COLUMN event_date SET NOT NULL,
    ALTER COLUMN event_end_date SET NOT NULL,
    ALTER COLUMN location SET NOT NULL,
    ALTER COLUMN capacity SET NOT NULL;

ALTER TABLE event_registration
    ALTER COLUMN registration_date SET NOT NULL,
    ALTER COLUMN status SET NOT NULL;

-- UNIQUE constraints
ALTER TABLE student
    ADD CONSTRAINT uq_student_email UNIQUE (email);

ALTER TABLE club
    ADD CONSTRAINT uq_club_name UNIQUE (club_name);

-- Bir kulüp aynı tarihte aynı isimle iki etkinlik düzenleyemez.
ALTER TABLE event
    ADD CONSTRAINT uq_event_club_name_date
    UNIQUE (club_id, event_name, event_date);

-- CHECK constraints

-- Etkinlik kapasitesi 1 ile 500 arasında olmalı.
ALTER TABLE event
    ADD CONSTRAINT ck_event_capacity
    CHECK (capacity BETWEEN 1 AND 500);

-- Etkinlik bitiş tarihi başlangıç tarihinden önce olamaz.
ALTER TABLE event
    ADD CONSTRAINT ck_event_dates
    CHECK (event_end_date >= event_date);

-- Etkinlik kayıt durumu belirlenen değerlerden biri olmalı.
ALTER TABLE event_registration
    ADD CONSTRAINT ck_registration_status
    CHECK (status IN ('registered', 'attended', 'cancelled'));