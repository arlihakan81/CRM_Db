--- SCRIPTED DATE 2023-11-04 18:42
USE CRM

SELECT 
	EmployeeID AS 'Personel No', 
	Name AS 'Adý',
	Surname AS 'Soyadý',
	CASE
		WHEN Gender='E' THEN 'Erkek'
		WHEN Gender='K' THEN 'Kadýn'
	END AS 'Cinsiyet',
	BirthDate AS 'Doðum Tarihi',
	HireDate AS 'Ýþe Giriþ Tarihi',
	Phone AS 'Telefon',
	Address AS 'Adres',
	CASE 
		WHEN DepartmentID=1 THEN 'Ýnsan Kaynaklarý'
		WHEN DepartmentID=2 THEN 'IT(Information Technologies)'
		WHEN DepartmentID=3 THEN 'Güvenlik'
		WHEN DepartmentID=4 THEN 'Genel Hizmetler'
		WHEN DepartmentID=5 THEN 'Kalite Kontrol'
		WHEN DepartmentID=6 THEN 'Muhasebe'
		WHEN DepartmentID=7 THEN 'Pazarlama'
		WHEN DepartmentID=8 THEN 'Satýn Alma'
		WHEN DepartmentID=9 THEN 'Yönetim'
		WHEN DepartmentID=10 THEN 'Sevkiyat'			
	END AS 'Departman',
	CI.CityName AS 'Þehir'
	FROM EMPLOYEES E JOIN CITIES CI ON E.City=CI.CityID

	SELECT * FROM DEPARTMENTS

SELECT 
	CustomerID AS 'Müþteri No', 
	Name AS 'Müþteri Adý', 
	Surname AS 'Müþteri Soyadý', 
	FORMAT((CONVERT(DATETIME,BirthDate)),'D') AS 'Doðum Tarihi',
	Phone AS 'Telefon',
	Address AS 'Adresi',
	Email AS 'Eposta',
	CI.CityName AS 'Þehir',
	CO.CountryName AS 'Ülke',
CASE
	WHEN Gender = 'K' THEN 'Kadýn'
	WHEN Gender = 'E' THEN 'Erkek'
END AS 'Cinsiyet'
FROM CUSTOMERS CU JOIN CITIES CI ON CU.City=CI.CityID
JOIN COUNTRIES CO ON CO.CountryID=CI.CountryID 
 

SELECT 
	ProductID AS 'Ürün No', 
	ProductName AS 'Ürün Adý',
	CASE 
		WHEN StockUnit=1 THEN 'Adet'
		WHEN StockUnit=2 THEN 'Kilogram'
	END AS 'Birim',
	QuantityInUnit AS 'Birim Miktarý',
	QuantityInStock AS 'Stok Miktarý',
	UnitPrice AS 'Birim Fiyatý',
	Cost AS 'Maliyet',
	C.CategoryName AS 'Kategori',
	S.CompanyName AS 'Tedarikçi'	
FROM PRODUCTS P
	JOIN CATEGORIES C ON P.CategoryID=C.CategoryID 
	JOIN SUPPLIERS S ON P.SupplierID=S.SupplierID

--- Kategorisi Cep Telefonu olan ürünleri listele
SELECT CategoryName AS 'Kategori', ProductName AS 'Ürün Adý' FROM PRODUCTS P 
JOIN CATEGORIES C ON P.CategoryID=C.CategoryID
WHERE C.CategoryName in('Cep Telefonu')

--- Birim Fiyatý 5000 tl nin üzerinde olan ürünlerin tedarikçi firmalarýný listeleyin
SELECT 
	C.CategoryName AS 'Kategori',	
	ProductName AS 'Ürün Adý',
	S.CompanyName	
FROM PRODUCTS P
	JOIN CATEGORIES C ON P.CategoryID=C.CategoryID
	JOIN SUPPLIERS S ON S.SupplierID=P.SupplierID
WHERE UnitPrice >5000

--- Maliyeti en az olan ürünlerin kategorisi bulunuz
SELECT TOP 1 SUM(Cost) AS 'Maliyeti', CategoryName AS 'Kategori' FROM PRODUCTS P
JOIN  CATEGORIES C ON P.CategoryID=C.CategoryID  
GROUP BY CategoryName ORDER BY SUM(Cost)

--- Kategorilere göre ürün sayýsýný listeleyin (Ürün sayýsýný kategori bazýnda listele)
SELECT COUNT(ProductID) AS 'Ürün Sayýsý', C.CategoryName AS 'Kategori' FROM PRODUCTS P 
JOIN CATEGORIES C ON P.CategoryID=C.CategoryID 
GROUP BY C.CategoryName

--- Adý 'A' harfi ile baþlayan ürünleri listele
SELECT * FROM PRODUCTS WHERE ProductName LIKE 'A%'

--- Stok Adedi 0-50 arasý olanlarý düþük 50-200 arasý olanlarý normal ve 200 den fazla olanlarý iyi þeklinde listeleyin 
SELECT ProductName, 
CASE 
	WHEN QuantityInStock BETWEEN 0 AND 50 THEN 'Düþük'
	WHEN QuantityInStock BETWEEN 50 AND 200 THEN 'Normal'
	WHEN QuantityInStock >200 THEN 'Ýyi'
END AS 'Stok Durumu'
FROM PRODUCTS 

--- Adresi Ceyhan olan müþterileri kadýn erkek olarak gruplayýn
SELECT Name, Surname, 
	CASE 
		WHEN Gender='E' THEN 'Erkek'
		WHEN Gender='K' THEN 'Kadýn'
	END AS 'Cinsiyet'
FROM CUSTOMERS WHERE Address in('Ceyhan')
GROUP BY Gender, Name, Surname

--- Hangi tedarikçi firmadan hangi ürünler alýnýyor listeleyin ve firma bazýnda gruplayýn
SELECT 
	ProductName AS 'Ürün Adý',
	S.CompanyName AS 'Tedarikçi Firma'
FROM SUPPLIERS S
	JOIN PRODUCTS P ON S.SupplierID=P.SupplierID
GROUP BY S.CompanyName, ProductName

--- Çalýþanlarýn yaþlarýný hesaplayýp listeleyin
SELECT 
	Name AS 'Adý',Surname AS 'Soyadý',
	CASE 
		WHEN Gender='E' THEN 'Erkek'
		WHEN Gender='K' THEN 'Kadýn'
	END AS 'Cinsiyet',
	DATEDIFF(YEAR,BirthDate,GETDATE()) AS 'Yaþ'
FROM EMPLOYEES

-- Kadýn Çalýþanlarýn çalýþtýðý departman/larý listeleyin 
SELECT E.Name AS 'Adý',
	Surname AS 'Soyadý',
	D.Name AS 'Departman'
FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DepartmentID=D.DepartmentID
WHERE Gender in('K')

--- Adresi Maltepe olan ve en az 3 yýllýk çalýþanlarýn bilgilerini listeleyin
SELECT 
	EmployeeID AS 'Personel No',
	E.Name AS 'Adý',
	Surname AS 'Soyadý',
	BirthDate AS 'Doðum Tarihi',
	HireDate AS 'Ýþe Giriþ Tarihi',
	Phone AS 'Telefon',
	Address AS 'Adres',
	D.Name AS 'Departman',
	C.CityName AS 'Þehir'
FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DepartmentID=D.DepartmentID
				 JOIN CITIES C ON E.City=C.CityID
	WHERE Address in ('Maltepe') AND DATEDIFF(YEAR,HireDate,GETDATE())>=3

--- Beyaz Eþya kategorisinde bulunan ürünlerin maliyetini hesaplayýn ve en az maliyeti olan ürünü getirin
SELECT SUM(Cost) AS 'Maliyeti', ProductName
FROM PRODUCTS P JOIN CATEGORIES C ON P.CategoryID=C.CategoryID 
WHERE C.CategoryName in ('Beyaz Eþya')
GROUP BY ProductName

--- Bilgisayar kategorisine ait ürünlerin ortalama fiyatýný bulun
SELECT AVG(UnitPrice) FROM PRODUCTS P JOIN CATEGORIES C 
ON P.CategoryID=C.CategoryID WHERE C.CategoryName in('Bilgisayar')

--- Sipariþ Adresi Beykoz olan sipariþleri listeleyin
SELECT 
	O.OrderID AS 'Sipariþ No',
	C.Name+' '+C.Surname AS 'Müþteri Adý',
	P.ProductName AS 'Ürün Adý',
	O.OrderDate AS 'Sipariþ Tarihi',
	O.RequireDate AS 'Teslim Tarihi',
	OS.Status AS 'Sipariþ Durumu',
	O.Address+'/'+CI.CityName AS 'Adres'

FROM ORDERS O
JOIN CUSTOMERS C ON O.CustomerID=C.CustomerID
JOIN [ORDER DETAILS] OD ON O.OrderID=OD.OrderID
JOIN PRODUCTS P ON OD.ProductID=P.ProductID
JOIN CITIES CI ON O.City=CI.CityID
JOIN [ORDER STATUS] OS ON O.OrderStatus=OS.OrderStatusID
	WHERE O.Address in ('Beykoz')

--- Müþteri bazýnda alýnan ürünleri listeleyin en fazla ürün alan 5 müþteriyi getirin
SELECT TOP 5 C.Name, C.Surname, ProductName, SUM(Quantity*UnitPrice) FROM ORDERS O
	JOIN [ORDER DETAILS] OD ON O.OrderID=OD.OrderID
	JOIN CUSTOMERS C ON O.CustomerID=C.CustomerID
	JOIN PRODUCTS P ON P.ProductID=OD.ProductID
GROUP BY C.Name, C.Surname, ProductName ORDER BY SUM(Quantity*UnitPrice) DESC

--- Beþiktaþ ilçesinden alýnan ve hazýr durumda olan sipariþlerin hangi müþteriler tarafýndan verildiðini ve hangi ürünleri aldýklarýný bulunuz.
SELECT C.Name, C.Surname, ProductName, OD.Quantity FROM ORDERS O 
	JOIN [ORDER STATUS] OS ON O.OrderStatus=OS.OrderStatusID
	JOIN CUSTOMERS C ON O.CustomerID=C.CustomerID
	JOIN [ORDER DETAILS] OD ON O.OrderID=OD.OrderID
	JOIN PRODUCTS P ON OD.ProductID=P.ProductID
WHERE O.Address in ('Beþiktaþ') AND OS.Status in ('Hazýr')

--- Oyun Bilgisayarý kategorisinden ürün alan müþterileri listeleyin
SELECT CS.Name, CS.Surname, ProductName FROM ORDERS O
	JOIN [ORDER DETAILS] OD ON O.OrderID=OD.OrderID
	JOIN CUSTOMERS CS ON O.CustomerID=CS.CustomerID
	JOIN PRODUCTS P ON OD.ProductID=P.ProductID
	JOIN CATEGORIES C ON P.CategoryID=C.CategoryID
		WHERE C.CategoryName='Oyun Bilgisayarý'

--- Burcu YILDIZ isimli müþterinin aldýðý ürünler hangi kategoride yer almaktadýr ve sipariþ alan çalýþan ad ve soyadý
SELECT 
	CS.Name AS 'Müþteri Adý', 
	CS.Surname AS 'Müþteri Soyadý', 
	ProductName AS 'Ürün Adý', 
	CategoryName AS 'Kategori', 
	E.Name AS 'Personel Adý', 
	E.Surname AS 'Personel Soyadý'
	FROM ORDERS O
	JOIN [ORDER DETAILS] OD ON O.OrderID=OD.OrderID
	JOIN PRODUCTS P ON OD.ProductID=P.ProductID
	JOIN CUSTOMERS CS ON O.CustomerID=CS.CustomerID
	JOIN EMPLOYEES E ON O.EmployeeID=E.EmployeeID
	JOIN CATEGORIES C ON P.CategoryID=C.CategoryID
	WHERE CS.Name in ('Burcu') AND CS.Surname in ('YILDIZ')

--- Kadýköy ilçesinde kaç adet müþteri vardýr ?
SELECT COUNT(*) FROM CUSTOMERS WHERE Address in ('Kadýköy')

--- Temmuz ayýnda verilen sipariþleri listeleyin
SELECT * FROM ORDERS WHERE OrderDate BETWEEN '2023-07-01' AND '2023-07-31'

--- Caner ÇELEBÝ isimli müþteriden kim veya kimler sipariþ almýþtýr
SELECT DISTINCT C.Name,C.Surname,E.Name,E.Surname FROM ORDERS O
	JOIN CUSTOMERS C ON O.CustomerID=C.CustomerID
	JOIN EMPLOYEES E ON O.EmployeeID=E.EmployeeID
		WHERE C.Name in('Caner') AND C.Surname in('ÇELEBÝ')

--- Çalýþanlar ne kadarlýk bir satýþ yapmýþlardýr ? (Personel bazýnda sipariþ tutarlarý)
SELECT E.Name AS 'Adý',E.Surname AS 'Soyadý',SUM(Quantity*UnitPrice) AS 'Toplam Satýþ' FROM ORDERS O 
	JOIN EMPLOYEES E ON E.EmployeeID=O.EmployeeID
	JOIN [ORDER DETAILS] OD ON O.OrderID=OD.OrderID
	JOIN PRODUCTS P ON P.ProductID=OD.ProductID 
		GROUP BY E.Name,E.Surname ORDER BY 3

--- Yýlmaz Biliþim isimli tedarikçi firmadan satýn alýnan ürünler hangi kategoriye aittir? 
SELECT ProductName,CategoryName FROM PRODUCTS P JOIN SUPPLIERS S ON P.SupplierID=S.SupplierID
JOIN CATEGORIES C ON C.CategoryID=P.CategoryID WHERE S.CompanyName in ('Yýlmaz Biliþim') 

--- Ülkelere göre müþterileri listeleyin
SELECT Name, Surname, CO.CountryName FROM CUSTOMERS C JOIN CITIES CI ON C.City=CI.CityID 
JOIN COUNTRIES CO ON CI.CountryID=CO.CountryID

CREATE TRIGGER Discrease_Stock ON [ORDER DETAILS] 
AFTER INSERT 
AS 
BEGIN
	DECLARE @pID SMALLINT
	DECLARE @soldQty SMALLINT
	SELECT @pID=ProductID,@soldQty=Quantity FROM inserted
	UPDATE PRODUCTS SET QuantityInStock-=@soldQty WHERE ProductID=@pID
END
 
CREATE TRIGGER Increase_Stock ON [ORDER DETAILS]
AFTER DELETE
AS
BEGIN
	DECLARE @pID SMALLINT
	DECLARE @soldQty SMALLINT
	SELECT @pID=ProductID,@soldQty=Quantity FROM deleted
	UPDATE PRODUCTS SET QuantityInStock+=@soldQty WHERE ProductID=@pID	
END

CREATE TRIGGER Delete_Sale_Update_Stock ON [ORDER DETAILS]
AFTER UPDATE
AS
BEGIN
	DECLARE @pID SMALLINT
	DECLARE @soldQty SMALLINT
	DECLARE @newSoldQty SMALLINT
	SELECT @pID=ProductID,@soldQty=Quantity FROM deleted
	SELECT @pID=ProductID,@newSoldQty=Quantity FROM inserted
	UPDATE PRODUCTS SET QuantityInStock=@soldQty+(@soldQty-@newSoldQty) WHERE ProductID=@pID	
END

SELECT * FROM PRODUCTS

EXEC sp_Insert_Order 1,15,'2023-11-03','2023-11-04',1,'Ceyhan',3
SELECT * FROM ORDERS

EXEC sp_Insert_Order_Detail 127,1,10

--- Ürün bazýnda satýþ raporu oluþturun
SELECT ProductName AS 'Ürün Adý', SUM(Quantity) AS 'Satýþ Adedi', SUM(Quantity*UnitPrice) 
AS 'Satýþ Tutarý' FROM [ORDER DETAILS] OD JOIN ORDERS O ON OD.OrderID=O.OrderID
JOIN [ORDER STATUS] OS ON O.OrderStatus=OS.OrderStatusID
JOIN PRODUCTS P ON OD.ProductID=P.ProductID WHERE OS.Status in ('Sevk Edildi')
GROUP BY ProductName

--- Onay Bekleyen sipariþler hangi müþteriler tarafýndan verilmiþtir?
SELECT C.Name,C.Surname FROM ORDERS O JOIN [ORDER STATUS] OS ON O.OrderStatus=OS.OrderStatusID
JOIN CUSTOMERS C ON O.CustomerID=C.CustomerID 
WHERE OS.Status in ('Onay Bekliyor')

--- Kartal ilçesine sevk edilen sipariþleri ürün bazýnda listeleyin
SELECT 
	ProductName AS 'Ürün Adý',
	StockUnitName AS 'Birim',
	UnitPrice AS 'Birim Fiyatý',
	Quantity AS 'Satýþ Adedi',
	Quantity*UnitPrice AS 'Satýþ Tutarý'
FROM ORDERS O JOIN [ORDER STATUS] OS ON O.OrderStatus=OS.OrderStatusID
JOIN [ORDER DETAILS] OD ON O.OrderID=OD.OrderID JOIN PRODUCTS P ON OD.ProductID=P.ProductID
JOIN [STOCK UNITS] SU ON P.StockUnit=SU.StockUnitID
WHERE OS.Status in ('Sevk Edildi') AND O.Address in ('Kartal')
 
--- Ersin KAYNAK isimli müþterinin verdiði sipariþlerden hazýr olanlardaki ürünlerin hangi kategoride olduklarýný listeleyin
SELECT CategoryName FROM ORDERS O JOIN [ORDER DETAILS] OD ON O.OrderID=OD.OrderID
JOIN CUSTOMERS C ON O.CustomerID=C.CustomerID JOIN PRODUCTS P ON P.ProductID=OD.ProductID
JOIN CATEGORIES CA ON CA.CategoryID=P.CategoryID WHERE Name in ('Ersin') AND Surname in('KAYNAK')

--- Mehmet YASÝN isimli müþteriden hangi çalýþanlar sipariþ almýþlardýr?
SELECT E.Name,E.Surname FROM ORDERS O JOIN CUSTOMERS C ON O.CustomerID=C.CustomerID JOIN EMPLOYEES E
ON E.EmployeeID=O.EmployeeID WHERE C.Name in('Mehmet') AND C.Surname in('YASÝN')

--- Osman Ticaret adlý tedarikçi firmadan alýnan ürünlerin sevk edildiði müþteriler ve sevk edildiði þehirleri listeleyin
SELECT 
	CompanyName AS 'Tedarikçi Adý',
	ProductName AS 'Ürün Adý',
	Name+' '+Surname AS 'Müþteri Adý',
	O.Address AS 'Adres',
	CityName AS 'Þehir'
FROM PRODUCTS P JOIN SUPPLIERS S ON P.SupplierID=S.SupplierID JOIN [ORDER DETAILS] OD
ON OD.ProductID=P.ProductID JOIN ORDERS O ON O.OrderID=OD.OrderID JOIN CITIES CI ON CI.CityID=O.City
JOIN CUSTOMERS C ON C.CustomerID=O.CustomerID JOIN [ORDER STATUS] OS ON O.OrderStatus=OS.OrderStatusID
WHERE CompanyName in('Osman Ticaret') AND Status in('Sevk Edildi')

--- SarýKýrmýzý Bilgisayar isimli tedarikçi firmadan alýnan ürünler kaç farklý kategoride yer almaktadýr
SELECT COUNT(DISTINCT CategoryName) FROM PRODUCTS P JOIN SUPPLIERS S ON P.SupplierID=S.SupplierID 
JOIN CATEGORIES C ON C.CategoryID=P.CategoryID
WHERE CompanyName in('SarýKýrmýzý Bilgisayar') 

--- Ekim ayýnda sevk edilen sipariþlerden sipariþ tutarý 2000 den fazla olanlarý listeleyin
SELECT Name 'Müþteri Adý',Surname 'Müþteri Soyadý',ProductName 'Ürün Adý',
SU.StockUnitName 'Birim',UnitPrice 'Birim Fiyatý',Quantity 'Miktarý',Quantity*UnitPrice 'Tutar',
O.Address+'/'+CI.CityName 'Adres',RequireDate 'Sevk Tarihi'
FROM ORDERS O JOIN [ORDER DETAILS] OD ON O.OrderID=OD.OrderID JOIN [ORDER STATUS] OS
ON O.OrderStatus=OS.OrderStatusID JOIN PRODUCTS P ON P.ProductID=OD.ProductID
JOIN CUSTOMERS C ON C.CustomerID=O.CustomerID JOIN CITIES CI ON CI.CityID=O.City
JOIN [STOCK UNITS] SU ON SU.StockUnitID=P.StockUnit
WHERE RequireDate BETWEEN '2023-10-01' AND '2023-10-31' 
	AND Status in('Sevk Edildi') AND (Quantity*UnitPrice)>2000

-- Aylara göre satýþ raporu oluþturan procedure yazýn.
CREATE PROCEDURE sp_Month_Indexed_Sales AS
BEGIN
	SELECT ProductName,SUM(Quantity*UnitPrice),MONTH(RequireDate) FROM ORDERS O 
	JOIN [ORDER DETAILS] OD ON O.OrderID=OD.OrderID
	JOIN PRODUCTS P ON P.ProductID=OD.ProductID JOIN [ORDER STATUS] OS 
	ON O.OrderStatus=OS.OrderStatusID
	WHERE RequireDate BETWEEN '2023-07-01' AND '2023-10-31' AND Status in('Sevk Edildi')
	GROUP BY MONTH(RequireDate),ProductName ORDER BY MONTH(RequireDate)
END

EXEC sp_Month_Indexed_Sales

--- En genç müþteriyi bulan procedure
CREATE PROCEDURE sp_Find_Youngest_Customer AS
BEGIN
	SELECT TOP 1 * FROM CUSTOMERS ORDER BY BirthDate DESC
END

EXEC sp_Find_Youngest_Customer

--- Sipariþ adresi Ankara'nýn Altýndað ilçesi olan ve onay bekleyen sipariþleri listeleyin
SELECT C.Name+' '+C.Surname 'Müþteri Adý',E.Name+' '+E.Surname 'Personel Adý',OrderDate 'Sipariþ Tarihi',
Status 'Sipariþ Durumu',O.Address+'/'+CI.CityName 'Sevk Adresi'   
FROM ORDERS O JOIN [ORDER STATUS] OS ON O.OrderStatus=OS.OrderStatusID
JOIN CUSTOMERS C ON C.CustomerID=O.CustomerID JOIN [ORDER DETAILS] OD ON O.OrderID=OD.OrderID
JOIN EMPLOYEES E ON E.EmployeeID=O.EmployeeID JOIN CITIES CI ON CI.CityID=O.City
WHERE O.Address in('Altýndað') AND Status in('Onay Bekliyor')

--- Tablet PC kategorisinde bulunan ürünleri en çok sipariþ veren müþteriyi bulunuz
SELECT TOP 1 Name+' '+Surname 'Müþteri Adý' FROM ORDERS O JOIN [ORDER DETAILS] OD ON O.OrderID=OD.OrderID
JOIN CUSTOMERS C ON C.CustomerID=O.OrderID JOIN PRODUCTS P ON P.ProductID=OD.ProductID 
JOIN CATEGORIES CAT ON CAT.CategoryID=P.CategoryID WHERE CategoryName in('Tablet PC') 
ORDER BY Quantity DESC










