COME 381 - Ödev 2

Ödevin Amacı

Bu ödevde öğrenci kulüpleri ve etkinlikleri için ilişkisel veritabanı üzerinde kısıtlamalar oluşturulmuş, hatalı veri girişleri test edilmiş ve ilişkisel cebir sorguları uygulanmıştır.

Dosyalar

* constraints.sql: NOT NULL, UNIQUE, CHECK ve FOREIGN KEY kısıtlamaları.
* violations.sql: Kısıtlamaların hatalı ve sınır değerlerle test edilmesi.
* violations_output.txt: Testlerin PostgreSQL çıktıları.
* seed.sql: Örnek verilerin eklenmesi.
* on_delete.md: FOREIGN KEY silme politikalarının açıklanması ve CASCADE testi.
* algebra.md: D1-D6 ilişkisel cebir açıklamaları ve beklenen sonuçlar.
* algebra.sql: D1-D6 sorgularının SQL uygulamaları.

Çalıştırma Sırası

Yeni ve boş bir veritabanında dosyalar şu sırayla çalıştırılmalıdır:

1. sql/schema.sql
2. week-05/constraints.sql
3. week-05/violations.sql
4. week-05/seed.sql
5. week-05/algebra.sql

PowerShell üzerinden örnek çalıştırma komutu:

& "C:\Program Files\PostgreSQL\14\bin\psql.exe" -h localhost -p 5432 -U postgres -d come381 -f ".\week-05\constraints.sql"

Diğer SQL dosyaları da aynı komut yapısıyla çalıştırılabilir; yalnızca dosya adı değiştirilir.

Test Sonuçları

violations.sql dosyasında 10’dan fazla test bulunmaktadır. NOT NULL, UNIQUE, CHECK ve FOREIGN KEY kısıtlamalarının beklenen SQLSTATE hata kodlarıyla çalıştığı görülmüştür.

Kontenjanın minimum değeri olan 1 ve başlangıç-bitiş tarihlerinin eşit olması kabul edilmiştir. Ayrıca CHECK kısıtlaması bulunan category alanına NULL değeri eklenebilmiştir.

CHECK kısıtlamalarında NULL değerinin otomatik olarak reddedilmediğini öğrendim. Bunun nedeni SQL’de CHECK koşulunun NULL için FALSE değil UNKNOWN sonucunu üretmesidir. NULL değerinin de yasaklanması istenirse ayrıca NOT NULL kullanılmalıdır.

İlişkisel Cebir Sonuçları

* D1: Computer Engineering bölümünden 2 öğrenci.
* D2: 7 öğrenci-kulüp eşleşmesi.
* D3: SQL Workshop veya Sports etkinliklerine kayıtlı 3 öğrenci.
* D4: Hiç etkinlik kaydı bulunmayan 1 öğrenci.
* D5: Aynı şehirde yaşayan 2 öğrenci çifti.
* D6: Tüm Sports etkinliklerine katılmış 2 öğrenci.

Tüm sorgular PostgreSQL üzerinde çalıştırılmış ve beklenen sonuçlar elde edilmiştir.