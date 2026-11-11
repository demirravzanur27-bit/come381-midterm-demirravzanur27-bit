-- COME 381 - Odev 2
-- Veri tabani kisitlamalari

-- Etkinlik bitis tarihini ekliyoruz.
ALTER TABLE event
ADD COLUMN IF NOT EXISTS event_end_date DATE;

-- NOT NULL KISITLAMALARI

-- Ogrenci adi bos birakilamaz.
ALTER TABLE student ALTER COLUMN first_name SET NOT NULL;

-- Ogrenci soyadi bos birakilamaz.
ALTER TABLE student ALTER COLUMN last_name SET NOT NULL;

-- Ogrenci e-posta adresi bos birakilamaz.
ALTER TABLE student ALTER COLUMN email SET NOT NULL;

-- Ogrenci bolumu bos birakilamaz.
ALTER TABLE student ALTER COLUMN department SET NOT NULL;

-- Ogrenci sehri bos birakilamaz.
ALTER TABLE student ALTER COLUMN city SET NOT NULL;

-- Kulup adi bos birakilamaz.
ALTER TABLE club ALTER COLUMN club_name SET NOT NULL;

-- Uyelik tarihi bos birakilamaz.
ALTER TABLE membership ALTER COLUMN join_date SET NOT NULL;

-- Uyelik rolu bos birakilamaz.
ALTER TABLE membership ALTER COLUMN role SET NOT NULL;

-- Etkinlik kulubu bos birakilamaz.
ALTER TABLE event ALTER COLUMN club_id SET NOT NULL;

-- Etkinlik adi bos birakilamaz.
ALTER TABLE event ALTER COLUMN event_name SET NOT NULL;

-- Etkinlik tarihi bos birakilamaz.
ALTER TABLE event ALTER COLUMN event_date SET NOT NULL;

-- Etkinlik bitis tarihi bos birakilamaz.
ALTER TABLE event ALTER COLUMN event_end_date SET NOT NULL;

-- Etkinlik konumu bos birakilamaz.
ALTER TABLE event ALTER COLUMN location SET NOT NULL;

-- Etkinlik kapasitesi bos birakilamaz.
ALTER TABLE event ALTER COLUMN capacity SET NOT NULL;

-- Kayit tarihi bos birakilamaz.
ALTER TABLE event_registration ALTER COLUMN registration_date SET NOT NULL;

-- Kayit durumu bos birakilamaz.
ALTER TABLE event_registration ALTER COLUMN status SET NOT NULL;


-- UNIQUE KISITLAMALARI

-- Ogrenci e-posta adresi benzersiz olmalidir.
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'uq_student_email') THEN
        ALTER TABLE student ADD CONSTRAINT uq_student_email UNIQUE (email);
    END IF;
END $$;

-- Kulup adi benzersiz olmalidir.
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'uq_club_name') THEN
        ALTER TABLE club ADD CONSTRAINT uq_club_name UNIQUE (club_name);
    END IF;
END $$;

-- Ayni kulup ayni tarihte ayni isimli iki etkinlik duzenleyemez.
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'uq_event_club_name_date') THEN
        ALTER TABLE event ADD CONSTRAINT uq_event_club_name_date
        UNIQUE (club_id, event_name, event_date);
    END IF;
END $$;


-- CHECK KISITLAMALARI

-- Etkinlik kapasitesi 1 ile 500 arasinda olmalidir.
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'ck_event_capacity') THEN
        ALTER TABLE event ADD CONSTRAINT ck_event_capacity
        CHECK (capacity BETWEEN 1 AND 500);
    END IF;
END $$;

-- Etkinlik bitis tarihi baslangic tarihinden once olamaz.
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'ck_event_dates') THEN
        ALTER TABLE event ADD CONSTRAINT ck_event_dates
        CHECK (event_end_date >= event_date);
    END IF;
END $$;

-- Etkinlik kategorisi belirlenen degerlerden biri olmalidir; NULL olabilir.
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'ck_event_category') THEN
        ALTER TABLE event ADD CONSTRAINT ck_event_category
        CHECK (category IN ('Technology', 'Arts', 'Environment', 'Career', 'Sports'));
    END IF;
END $$;

-- Etkinlik kayit durumu gecerli degerlerden biri olmalidir.
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'ck_registration_status') THEN
        ALTER TABLE event_registration ADD CONSTRAINT ck_registration_status
        CHECK (status IN ('registered', 'attended', 'cancelled'));
    END IF;
END $$;


-- FOREIGN KEY SILME POLITIKALARI

-- Ogrenci silinince uyelikleri de silinir.
ALTER TABLE membership DROP CONSTRAINT IF EXISTS fk_membership_student;
ALTER TABLE membership ADD CONSTRAINT fk_membership_student
FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE;

-- Uyelik bulunan kulup silinemez.
ALTER TABLE membership DROP CONSTRAINT IF EXISTS fk_membership_club;
ALTER TABLE membership ADD CONSTRAINT fk_membership_club
FOREIGN KEY (club_id) REFERENCES club(club_id) ON DELETE RESTRICT;

-- Etkinligi bulunan kulup silinemez.
ALTER TABLE event DROP CONSTRAINT IF EXISTS fk_event_club;
ALTER TABLE event ADD CONSTRAINT fk_event_club
FOREIGN KEY (club_id) REFERENCES club(club_id) ON DELETE RESTRICT;

-- Ogrenci silinince etkinlik kayitlari da silinir.
ALTER TABLE event_registration DROP CONSTRAINT IF EXISTS fk_registration_student;
ALTER TABLE event_registration ADD CONSTRAINT fk_registration_student
FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE;

-- Etkinlik silinince katilim kayitlari da silinir.
ALTER TABLE event_registration DROP CONSTRAINT IF EXISTS fk_registration_event;
ALTER TABLE event_registration ADD CONSTRAINT fk_registration_event
FOREIGN KEY (event_id) REFERENCES event(event_id) ON DELETE CASCADE;