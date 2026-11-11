İlişkisel Cebir (Relational Algebra)

Bu çalışmada Üniversite Kulüp Yönetim Sistemi veritabanı kullanılmıştır.

D1 - Seçme (Selection) ve İzdüşüm (Projection)

Soru: Bilgisayar Mühendisliği bölümündeki öğrencilerin adlarını ve soyadlarını listeleyiniz.

İlişkisel Cebir:

[
\pi_{first_name,last_name}
(\sigma_{department=‘Computer\ Engineering’}(student))
]

SQL:

SELECT first_name, last_name
FROM student
WHERE department = 'Computer Engineering';

Beklenen sonuç:

first_name	last_name
Ayse	Yilmaz
Zeynep	Kaya

Tuple Relational Calculus:

[
{t \mid student(t) \land t.department=‘Computer\ Engineering’}
]

DISTINCT açıklaması: DISTINCT gerekli değildir çünkü student tablosunda her öğrencinin benzersiz bir student_id değeri vardır.

⸻

D2 - Birleştirme (Join)

Soru: Kulüplere üye olan öğrencilerin adlarını ve üye oldukları kulüplerin adlarını listeleyiniz.

İlişkisel Cebir:

[
student \bowtie membership \bowtie club
]

Birleştirme işlemleri student_id ve club_id alanları üzerinden yapılır.

SQL:

SELECT s.first_name, s.last_name, c.club_name
FROM student s
JOIN membership m ON s.student_id = m.student_id
JOIN club c ON m.club_id = c.club_id;

Beklenen sonuç:

Öğrenci	Kulüp
Ayse Yilmaz	Software Club
Mehmet Demir	Software Club
Zeynep Kaya	Photography Club
Ali Celik	Environment Club
Ayse Yilmaz	Sports Club
Mehmet Demir	Sports Club
Zeynep Kaya	Career Club

DISTINCT açıklaması: DISTINCT gerekli değildir çünkü membership tablosundaki birleşik birincil anahtar aynı öğrencinin aynı kulübe birden fazla kez üye olmasını engeller.

⸻

D3 - Birleşim (Union)

Soru: SQL Workshop etkinliğine veya herhangi bir Sports kategorisindeki etkinliğe kayıt yaptıran öğrencileri listeleyiniz.

İlişkisel Cebir:

[
\pi_{student_id}(\sigma_{event_name=‘SQL\ Workshop’}(event \bowtie event_registration))
]

[
\cup
]

[
\pi_{student_id}(\sigma_{category=‘Sports’}(event \bowtie event_registration))
]

SQL:

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
);

Beklenen sonuç:

first_name	last_name
Ayse	Yilmaz
Mehmet	Demir
Zeynep	Kaya

DISTINCT açıklaması: UNION aynı öğrenciyi iki tarafta da bulunsa bile bir kez döndürür. Bu nedenle ayrıca DISTINCT gerekmez.

⸻

D4 - Fark (Difference)

Soru: Hiçbir etkinliğe kayıt yaptırmamış öğrencileri listeleyiniz.

İlişkisel Cebir:

[
\pi_{student_id}(student)

\pi_{student_id}(event_registration)
]

SQL - EXCEPT yöntemi:

SELECT student_id
FROM student
EXCEPT
SELECT student_id
FROM event_registration;

SQL - NOT EXISTS yöntemi:

SELECT s.student_id
FROM student s
WHERE NOT EXISTS (
    SELECT 1
    FROM event_registration er
    WHERE er.student_id = s.student_id
);

Beklenen sonuç:

student_id

5

Bu öğrenci Elif Sahin’dir.

DISTINCT açıklaması: EXCEPT tekrarlanan sonuçları kaldırır. NOT EXISTS ise student tablosundaki her öğrenciyi bir kez kontrol eder. Bu nedenle iki sorguda da ayrıca DISTINCT gerekli değildir.

⸻

D5 - Yeniden Adlandırma (Rename) ve Self-Join

Soru: Aynı şehirde yaşayan farklı öğrencilerin adlarını listeleyiniz.

İlişkisel Cebir:

[
\rho_{S1}(student)
\bowtie_{S1.city=S2.city \land S1.student_id<S2.student_id}
\rho_{S2}(student)
]

SQL:

SELECT
    s1.first_name AS student1,
    s2.first_name AS student2,
    s1.city
FROM student s1
JOIN student s2
    ON s1.city = s2.city
   AND s1.student_id < s2.student_id;

Beklenen sonuç:

student1	student2	city
Ayse	Zeynep	Istanbul
Mehmet	Elif	Ankara

DISTINCT açıklaması: DISTINCT gerekli değildir çünkü student_id karşılaştırması aynı öğrencinin kendisiyle eşleşmesini ve aynı çiftin ters sırayla tekrar oluşmasını engeller.

⸻

D6 - Bölme (Division)

Soru: Sports kategorisindeki bütün etkinliklere katılmış öğrencileri listeleyiniz.

İlişkisel Cebir:

[
R =
\pi_{student_id,event_id}
(\sigma_{category=‘Sports’ \land status=‘attended’}
(event_registration \bowtie event))
]

[
S = \pi_{event_id}(\sigma_{category=‘Sports’}(event))
]

[
R \div S
]

SQL:

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
);

Beklenen sonuç:

student_id	first_name	last_name
1	Ayse	Yilmaz
2	Mehmet	Demir

DISTINCT açıklaması: Student tablosunda her öğrenci bir kez bulunduğu için DISTINCT gerekli değildir.

Neden NOT EXISTS kullandım?

İçteki NOT EXISTS, öğrencinin ilgili etkinliğe katıldığını kontrol eder. Dıştaki NOT EXISTS ise katılmadığı hiçbir Sports etkinliği bulunmamasını sağlar. Böylece öğrenci bütün Sports etkinliklerine katılmışsa sonuçta listelenir.

Zeynep yalnızca bir Sports etkinliğine katıldığı için sonuçta yer almaz. Bu durum, sorgunun bütün etkinlikleri kontrol ettiğini gösterir.