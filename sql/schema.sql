-- Üniversite Kulüp Yönetim Sistemi
-- Veritabanı tablolarının oluşturulması

CREATE TABLE student (
    student_id INTEGER GENERATED ALWAYS AS IDENTITY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(255),
    department VARCHAR(100),
    city VARCHAR(100),
    CONSTRAINT pk_student PRIMARY KEY (student_id)
);

CREATE TABLE club (
    club_id INTEGER GENERATED ALWAYS AS IDENTITY,
    club_name VARCHAR(100),
    description TEXT,
    CONSTRAINT pk_club PRIMARY KEY (club_id)
);

CREATE TABLE membership (
    student_id INTEGER,
    club_id INTEGER,
    join_date DATE,
    role VARCHAR(50),
    CONSTRAINT pk_membership PRIMARY KEY (student_id, club_id),
    CONSTRAINT fk_membership_student
        FOREIGN KEY (student_id) REFERENCES student(student_id),
    CONSTRAINT fk_membership_club
        FOREIGN KEY (club_id) REFERENCES club(club_id)
);

CREATE TABLE event (
    event_id INTEGER GENERATED ALWAYS AS IDENTITY,
    club_id INTEGER,
    event_name VARCHAR(150),
    event_date DATE,
    location VARCHAR(150),
    capacity INTEGER,
    category VARCHAR(50),
    CONSTRAINT pk_event PRIMARY KEY (event_id),
    CONSTRAINT fk_event_club
        FOREIGN KEY (club_id) REFERENCES club(club_id)
);

CREATE TABLE event_registration (
    student_id INTEGER,
    event_id INTEGER,
    registration_date DATE,
    status VARCHAR(30),
    CONSTRAINT pk_event_registration PRIMARY KEY (student_id, event_id),
    CONSTRAINT fk_registration_student
        FOREIGN KEY (student_id) REFERENCES student(student_id),
    CONSTRAINT fk_registration_event
        FOREIGN KEY (event_id) REFERENCES event(event_id)
);