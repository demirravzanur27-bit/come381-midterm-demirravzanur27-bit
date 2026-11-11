-- COME 381 - Odev 2
-- Iliskisel Cebir SQL sorgulari

-- D1: Secme (Selection) ve izdüşüm (Projection)
-- Bilgisayar Muhendisligi ogrencilerinin ad ve soyadlari.

SELECT first_name, last_name
FROM student
WHERE department = 'Computer Engineering';


-- D2: Birlesim (Join)
-- Ogrencilerin uye olduklari kulupleri listeleme.

SELECT s.first_name, s.last_name, c.club_name
FROM student s
JOIN membership m ON s.student_id = m.student_id
JOIN club c ON m.club_id = c.club_id
ORDER BY s.student_id, c.club_id;


-- D3: Birlesim (Union)
-- SQL Workshop veya Sports etkinliklerine kayit yaptiran ogrenciler.

SELECT s.first_name, s.last_name
FROM student s
WHERE s.student_id IN (
    SELECT er.student_id
    FROM event_registration er
    JOIN event e ON er.event_id = e.event_id
    WHERE e.event_name = 'SQL Workshop'

    UNION

    SELECT er.student_id
    FROM event_registration er
    JOIN event e ON er.event_id = e.event_id
    WHERE e.category = 'Sports'
)
ORDER BY s.first_name;


-- D4: Fark (Difference)
-- Hicbir etkinlige kayit yaptirmamis ogrenciler.
-- Birinci yontem: EXCEPT

SELECT student_id
FROM student

EXCEPT

SELECT student_id
FROM event_registration;


-- D4: Ikinci yontem: NOT EXISTS
-- Ayni sorunun farkli SQL cozum yolu.

SELECT s.student_id
FROM student s
WHERE NOT EXISTS (
    SELECT 1
    FROM event_registration er
    WHERE er.student_id = s.student_id
);


-- D5: Yeniden adlandirma (Rename) ve Self-Join
-- Ayni sehirde yasayan farkli ogrenciler.

SELECT
    s1.first_name AS student1,
    s2.first_name AS student2,
    s1.city
FROM student s1
JOIN student s2
    ON s1.city = s2.city
   AND s1.student_id < s2.student_id;


-- D6: Bolme (Division)
-- Butun Sports etkinliklerine katilmis ogrenciler.

SELECT s.student_id, s.first_name, s.last_name
FROM student s
WHERE NOT EXISTS (
    SELECT 1
    FROM event e
    WHERE e.category = 'Sports'
      AND NOT EXISTS (
          SELECT 1
          FROM event_registration er
          WHERE er.student_id = s.student_id
            AND er.event_id = e.event_id
            AND er.status = 'attended'
      )
)
ORDER BY s.student_id;