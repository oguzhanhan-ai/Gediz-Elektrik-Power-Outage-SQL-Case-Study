
-- Soru 1: GEDİZ adında bir veritabanı ve veri setindeki değişkenleri içeren KESİNTİ isimli bir tablo oluşturunuz.

CREATE DATABASE GEDIZ;

-- Soru 2: "KESİNTİ_NEDENİNE_İLİŞKİN_AÇIKLAMA" sütununda yer alan benzersiz kesinti nedenlerini listeleyin.

SELECT DISTINCT KESİNTİ_NEDENİNE_İLİŞKİN_AÇIKLAMA FROM KESINTI;

-- Soru 3: "BAŞLAMA_TARİHİ_VE_ZAMANI" sütununda en erken ve en geç başlama tarihlerini bulunuz.

SELECT 
MIN(BAŞLAMA_TARİHİ_VE_ZAMANI) AS En_Erken_Baslama_Tarihi, 
Max(BAŞLAMA_TARİHİ_VE_ZAMANI) AS En_Gec_Baslama_Tarihi FROM KESINTI;

-- Soru 4: "KESİNTİ_SÜRESİ" sütunundaki kesinti süresi ortalamasını hesaplayın.

SELECT İL, AVG(KESİNTİ_SÜRESİ) AS Ortalama_Kesinti_Suresi FROM KESINTI
GROUP BY İL;

-- Soru 5: "KENTSEL_OG" ve "KENTSEL_AG" sütunlarını toplayarak "TOPLAM_KENTSEL_OG" sütununu oluşturun. 

UPDATE KESINTI SET TOPLAM_KENTSEL_OG = KENTSEL_OG + KENTSEL_AG;

-- Soru 6: "SÜREYE_GÖRE" sütununda yer alan kesintileri, kısa süreli ve uzun süreli olarak gruplandırın.

SELECT SÜREYE_GÖRE, COUNT(*) AS Kesinti_Sayisi
FROM KESINTI
GROUP BY SÜREYE_GÖRE;

-- Soru 7: "KAYNAĞA_GÖRE" sütununda en çok tekrar eden kaynakları ve bu kaynakların sayısını bulunuz.

SELECT KAYNAĞA_GÖRE, COUNT(*) AS Kaynak_Sayisi 
FROM KESINTI
GROUP BY KAYNAĞA_GÖRE
ORDER BY Kaynak_Sayisi DESC;

-- Soru 8: "BİLDİRİME_GÖRE" sütununda "21-07-2021" tarihinden sonraki kesinti bildirimlerini listeleyin.

SELECT * FROM KESINTI 
WHERE BİLDİRİME_GÖRE > '21-07-2021';

-- Soru 9: "BAŞLAMA_TARİHİ_VE_ZAMANI" ve "SONA_ERME_TARİHİ_VE_ZAMANI" sütunlarını kullanarak kesinti süresini hesaplayın ve "KESİNTİ_SÜRESİ" adında yeni bir sütun oluşturunuz.

UPDATE KESINTI SET KESİNTİ_SÜRESİ = DATEDIFF(HOUR, BAŞLAMA_TARİHİ_VE_ZAMANI, SONA_ERME_TARİHİ_VE_ZAMANI);

--Soru 10: "KENTSEL_OG", "KENTSEL_AG", "KENTALTI_OG" ve "KENTALTI_AG" sütunlarındaki değerleri toplayarak kentsel ve kırsal alanlarda toplam kesinti sayısını hesaplayınız.

SELECT
SUM(KENTSEL_OG + KENTSEL_AG) AS TOPLAM_KENTSEL,
SUM(KENTALTI_OG + KENTALTI_AG) AS TOPLAM_KIRSAL
FROM KESINTI;

-- Soru 11: "SEBEBE_GÖRE" sütununda yer alan kesintileri, belirli bir sebep listesine göre gruplayın ve bu sebeplerin toplam kesinti süresini hesaplayınız.

SELECT SEBEBE_GÖRE,
SUM(KESİNTİ_SÜRESİ) AS Toplam_Kesinti_Suresi
FROM KESINTI
WHERE SEBEBE_GÖRE IN ('Şebeke İşletmecisi', 'Dışsal', 'Güvenlik')
Group BY SEBEBE_GÖRE
ORDER BY Toplam_Kesinti_Suresi DESC;

-- Soru 12: "BAŞLAMA_TARİHİ_VE_ZAMANI" sütununda yer alan kesintileri, yıl ve ay bazında gruplayın ve her bir yıl/ay için toplam kesinti süresini hesaplayınız.

SELECT 
YEAR(BAŞLAMA_TARİHİ_VE_ZAMANI) AS Yıl,
MONTH(BAŞLAMA_TARİHİ_VE_ZAMANI) AS Ay,
SUM(KESİNTİ_SÜRESİ) AS Toplam_Kesinti_Suresi
FROM KESINTI
GROUP BY YEAR(BAŞLAMA_TARİHİ_VE_ZAMANI), MONTH(BAŞLAMA_TARİHİ_VE_ZAMANI)
ORDER BY Toplam_Kesinti_Suresi DESC;

-- Soru 13: "BAŞLAMA_TARİHİ_VE_ZAMANI" sütununda yer alan tarihleri kullanarak, haftalık kesinti sayısını ve toplam kesinti süresini bulunuz.

SELECT 
DATEPART(WEEK, BAŞLAMA_TARİHİ_VE_ZAMANI) AS Hafta,
COUNT(*) AS Kesinti_Sayisi,
SUM(KESİNTİ_SÜRESİ) AS Toplam_Kesinti_Suresi
FROM KESINTI
GROUP BY DATEPART(WEEK, BAŞLAMA_TARİHİ_VE_ZAMANI)
ORDER BY Kesinti_Sayisi DESC, Toplam_Kesinti_Suresi DESC;









