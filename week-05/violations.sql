-- COME 381 - Odev 2
-- Kisit ihlali testleri
-- Beklenen SQLSTATE kodlarini ayrintili gosterir.

\set VERBOSITY verbose

-- 1. Hazirlik: Onceki verileri temizle ve test verilerini ekle.
TRUNCATE TABLE event_registration, membership, event, club, student
RESTART IDENTITY CASCADE;

\echo 'TEST VERILERI EKLENIYOR'
\i 'week-05/seed.sql'


-- TEST 1: NOT NULL
-- Beklenen SQLSTATE: 23502
-- Ogrencinin adi NULL olamaz.

\echo 'TEST 1 - NOT NULL ihlali'
INSERT INTO student (first_name, last_name, email, department, city)
VALUES (NULL, 'Test', 'test1@example.com', 'Computer Engineering', 'Istanbul');


-- TEST 2: UNIQUE student email
-- Beklenen SQLSTATE: 23505
-- Ayni e-posta adresi tekrar kullanilamaz.

\echo 'TEST 2 - Ogrenci e-posta UNIQUE ihlali'
INSERT INTO student (first_name, last_name, email, department, city)
VALUES ('Test', 'User', 'ayse@example.com', 'Computer Engineering', 'Istanbul');


-- TEST 3: UNIQUE club name
-- Beklenen SQLSTATE: 23505
-- Ayni kulup adi tekrar kullanilamaz.

\echo 'TEST 3 - Kulup adi UNIQUE ihlali'
INSERT INTO club (club_name, description)
VALUES ('Software Club', 'Duplicate club');


-- TEST 4: Birlesik UNIQUE
-- Beklenen SQLSTATE: 23505
-- Ayni kulupte ayni ad ve tarihle ikinci etkinlik olusturulamaz.

\echo 'TEST 4 - Etkinlik birlesik UNIQUE ihlali'
INSERT INTO event
(club_id, event_name, event_date, event_end_date, location, capacity, category)
VALUES
(1, 'SQL Workshop', '2026-11-20', '2026-11-20', 'Lab 102', 20, 'Technology');


-- TEST 5: CHECK capacity
-- Beklenen SQLSTATE: 23514
-- Kontenjan 1 ile 500 arasinda olmalidir.

\echo 'TEST 5 - Kontenjan CHECK ihlali'
INSERT INTO event
(club_id, event_name, event_date, event_end_date, location, capacity, category)
VALUES
(1, 'Invalid Capacity', '2026-12-10', '2026-12-10', 'Lab 103', 0, 'Technology');


-- TEST 6: CHECK event dates
-- Beklenen SQLSTATE: 23514
-- Bitis tarihi baslangic tarihinden once olamaz.

\echo 'TEST 6 - Tarih CHECK ihlali'
INSERT INTO event
(club_id, event_name, event_date, event_end_date, location, capacity, category)
VALUES
(1, 'Invalid Dates', '2026-12-15', '2026-12-10', 'Lab 104', 20, 'Technology');


-- TEST 7: CHECK event category
-- Beklenen SQLSTATE: 23514
-- Kategori izin verilen degerlerden biri olmalidir.

\echo 'TEST 7 - Etkinlik kategorisi CHECK ihlali'
INSERT INTO event
(club_id, event_name, event_date, event_end_date, location, capacity, category)
VALUES
(1, 'Invalid Category', '2026-12-16', '2026-12-16', 'Lab 105', 20, 'Invalid');


-- TEST 8: CHECK registration status
-- Beklenen SQLSTATE: 23514
-- Kayit durumu izin verilen degerlerden biri olmalidir.

\echo 'TEST 8 - Kayit durumu CHECK ihlali'
INSERT INTO event_registration (student_id, event_id, registration_date, status)
VALUES (5, 1, '2026-11-17', 'unknown');


-- TEST 9: FOREIGN KEY
-- Beklenen SQLSTATE: 23503
-- Var olmayan ogrenciye uyelik verilemez.

\echo 'TEST 9 - FOREIGN KEY cocuk kayit ihlali'
INSERT INTO membership (student_id, club_id, join_date, role)
VALUES (999999, 1, '2026-11-17', 'Member');


-- TEST 10: FOREIGN KEY DELETE
-- Beklenen SQLSTATE: 23503
-- Uyelik ve etkinliklerle iliskili kulup silinemez (RESTRICT).

\echo 'TEST 10 - FOREIGN KEY ebeveyn silme ihlali'
DELETE FROM club
WHERE club_id = 1;


-- TEST 11: CHECK sinir degeri
-- Beklenen sonuc: INSERT 0 1
-- Kontenjanin minimum degeri olan 1 kabul edilmelidir.

\echo 'TEST 11 - Kontenjan alt sinir degeri kabul edilmeli'
INSERT INTO event
(club_id, event_name, event_date, event_end_date, location, capacity, category)
VALUES
(1, 'Boundary Capacity', '2026-12-20', '2026-12-20', 'Lab 106', 1, 'Technology');


-- TEST 12: CHECK sinir degeri
-- Beklenen sonuc: INSERT 0 1
-- Baslangic ve bitis tarihinin ayni olmasi kabul edilmelidir.

\echo 'TEST 12 - Esit baslangic ve bitis tarihi kabul edilmeli'
INSERT INTO event
(club_id, event_name, event_date, event_end_date, location, capacity, category)
VALUES
(1, 'Boundary Dates', '2026-12-21', '2026-12-21', 'Lab 107', 10, 'Arts');


-- TEST 13: CHECK kolonunda NULL
-- Beklenen sonuc: INSERT 0 1
-- Kategori CHECK kisitlamasi NULL degerini engellemez.

\echo 'TEST 13 - CHECK kolonunda NULL degeri kabul edilmeli'
INSERT INTO event
(club_id, event_name, event_date, event_end_date, location, capacity, category)
VALUES
(1, 'Null Category', '2026-12-22', '2026-12-22', 'Lab 108', 10, NULL);


-- Temizlik: Test verilerini kaldir.
\echo 'TESTLER SONRASI VERITABANI TEMIZLENIYOR'
TRUNCATE TABLE event_registration, membership, event, club, student
RESTART IDENTITY CASCADE;

\echo 'BUTUN TESTLER TAMAMLANDI'