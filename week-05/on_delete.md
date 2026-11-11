ON DELETE Politikaları

1. Kullanılan silme politikaları

Veritabanında iki farklı silme politikası kullanılmıştır: CASCADE ve RESTRICT.

1.1. Foreign Key ilişkileri

Foreign Key	İlişki	ON DELETE politikası	Seçilme nedeni
fk_membership_student	membership → student	CASCADE	Öğrenci silinirse ona ait üyelikler de silinmelidir.
fk_membership_club	membership → club	RESTRICT	Üyesi bulunan bir kulübün yanlışlıkla silinmesi önlenmelidir.
fk_event_club	event → club	RESTRICT	Etkinlikleri bulunan bir kulüp silinmemelidir.
fk_registration_student	event_registration → student	CASCADE	Öğrenci silinirse ona ait etkinlik kayıtları da silinmelidir.
fk_registration_event	event_registration → event	CASCADE	Etkinlik silinirse o etkinliğe ait katılım kayıtları da silinmelidir.

1.2. Neden bu politikalar seçildi?

CASCADE: Bir öğrenci veya etkinlik silindiğinde artık anlamı kalmayan ilişkili kayıtların otomatik silinmesini sağlar. Böylece veritabanında sahipsiz kayıtlar kalmaz.

RESTRICT: Üyeliği veya etkinliği bulunan bir kulübün silinmesini engeller. Böylece önemli ilişkili kayıtların yanlışlıkla kaybolması önlenir.

1.3. Neden diğer politikalar seçilmedi?

* CASCADE yerine RESTRICT kullanılsaydı, öğrenci silinirken ona bağlı üyelik ve etkinlik kayıtlarının silinmesi engellenebilirdi.
* RESTRICT yerine CASCADE kullanılsaydı, bir kulüp silindiğinde ona bağlı etkinlik ve üyelikler de otomatik olarak kaybolabilirdi.
* SET NULL seçilmedi çünkü ilişkili kayıtların kulüp, öğrenci veya etkinlik bağlantısının boş kalmasını istemiyoruz.
* SET DEFAULT seçilmedi çünkü ilişkiler için uygun bir varsayılan kayıt tanımlamadık.

1.4. RESTRICT ve NO ACTION farkı

RESTRICT, ilişkili kayıt varsa silme işlemini hemen engeller. NO ACTION ise kontrolü SQL komutunun sonunda yapar; yabancı anahtar ertelenebilir olarak tanımlanmışsa kontrol işlem sonuna kadar ertelenebilir.

2. CASCADE davranışının kanıtı

CASCADE politikasını öğrenci silme işlemi üzerinden test ettim.

Önce öğrenciye bağlı üyelik ve etkinlik kayıtlarının sayısını kontrol ettim. Daha sonra öğrenciyi sildim ve ilişkili kayıtların otomatik silinip silinmediğini tekrar kontrol ettim.

Testte kullanılan SQL komutları:

BEGIN;
SELECT COUNT(*) FROM student WHERE student_id = 1;
SELECT COUNT(*) FROM membership WHERE student_id = 1;
SELECT COUNT(*) FROM event_registration WHERE student_id = 1;
DELETE FROM student WHERE student_id = 1;
SELECT COUNT(*) FROM student WHERE student_id = 1;
SELECT COUNT(*) FROM membership WHERE student_id = 1;
SELECT COUNT(*) FROM event_registration WHERE student_id = 1;
ROLLBACK;

ROLLBACK komutu test sırasında yapılan silme işlemini geri alır. Böylece gerçek veriler korunur.

Test sonucu: Bu testin gerçek çıktıları çalıştırıldıktan sonra rapora eklenecektir.



2.1. Gerçek test çıktıları

Test sırasında elde edilen sonuçlar:

Kontrol	Silme öncesi	Silme sonrası
Öğrenci 1	1	0
Öğrenci 1’in üyelikleri	1	0
Öğrenci 1’in etkinlik kayıtları	1	0

DELETE komutu DELETE 1 sonucunu verdi. Öğrenci silindikten sonra üç COUNT sorgusu da 0 sonucunu verdi.

Bu sonuçlar, CASCADE politikasının öğrenci silindiğinde ilişkili üyelik ve etkinlik kayıtlarını otomatik olarak sildiğini göstermektedir.

Testin sonunda ROLLBACK komutu çalıştırılarak silme işlemi geri alındı ve gerçek veriler korundu.