--- SCRIPTED DATE 2023-11-04 18:42
USE CRM

SELECT 
	EmployeeID AS 'Personel No', 
	Name AS 'Ad�',
	Surname AS 'Soyad�',
	CASE
		WHEN Gender='E' THEN 'Erkek'
		WHEN Gender='K' THEN 'Kad�n'
	END AS 'Cinsiyet',
	BirthDate AS 'Do�um Tarihi',
	HireDate AS '��e Giri� Tarihi',
	Phone AS 'Telefon',
	Address AS 'Adres',
	CASE 
		WHEN DepartmentID=1 THEN '�nsan Kaynaklar�'
		WHEN DepartmentID=2 THEN 'IT(Information Technologies)'
		WHEN DepartmentID=3 THEN 'G�venlik'
		WHEN DepartmentID=4 THEN 'Genel Hizmetler'
		WHEN DepartmentID=5 THEN 'Kalite Kontrol'
		WHEN DepartmentID=6 THEN 'Muhasebe'
		WHEN DepartmentID=7 THEN 'Pazarlama'
		WHEN DepartmentID=8 THEN 'Sat�n Alma'
		WHEN DepartmentID=9 THEN 'Y�netim'
		WHEN DepartmentID=10 THEN 'Sevkiyat'			
	END AS 'Departman',
	CI.CityName AS '�ehir'
	FROM EMPLOYEES E JOIN CITIES CI ON E.City=CI.CityID

	SELECT * FROM DEPARTMENTS

SELECT 
	CustomerID AS 'M��teri No', 
	Name AS 'M��teri Ad�', 
	Surname AS 'M��teri Soyad�', 
	FORMAT((CONVERT(DATETIME,BirthDate)),'D') AS 'Do�um Tarihi',
	Phone AS 'Telefon',
	Address AS 'Adresi',
	Email AS 'Eposta',
	CI.CityName AS '�ehir',
	CO.CountryName AS '�lke',
CASE
	WHEN Gender = 'K' THEN 'Kad�n'
	WHEN Gender = 'E' THEN 'Erkek'
END AS 'Cinsiyet'
FROM CUSTOMERS CU JOIN CITIES CI ON CU.City=CI.CityID
JOIN COUNTRIES CO ON CO.CountryID=CI.CountryID 
 

SELECT 
	ProductID AS '�r�n No', 
	ProductName AS '�r�n Ad�',
	CASE 
		WHEN StockUnit=1 THEN 'Adet'
		WHEN StockUnit=2 THEN 'Kilogram'
	END AS 'Birim',
	QuantityInUnit AS 'Birim Miktar�',
	QuantityInStock AS 'Stok Miktar�',
	UnitPrice AS 'Birim Fiyat�',
	Cost AS 'Maliyet',
	C.CategoryName AS 'Kategori',
	S.CompanyName AS 'Tedarik�i'	
FROM PRODUCTS P
	JOIN CATEGORIES C ON P.CategoryID=C.CategoryID 
	JOIN SUPPLIERS S ON P.SupplierID=S.SupplierID

--- Kategorisi Cep Telefonu olan �r�nleri listele
SELECT CategoryName AS 'Kategori', ProductName AS '�r�n Ad�' FROM PRODUCTS P 
JOIN CATEGORIES C ON P.CategoryID=C.CategoryID
WHERE C.CategoryName in('Cep Telefonu')

--- Birim Fiyat� 5000 tl nin �zerinde olan �r�nlerin tedarik�i firmalar�n� listeleyin
SELECT 
	C.CategoryName AS 'Kategori',	
	ProductName AS '�r�n Ad�',
	S.CompanyName	
FROM PRODUCTS P
	JOIN CATEGORIES C ON P.CategoryID=C.CategoryID
	JOIN SUPPLIERS S ON S.SupplierID=P.SupplierID
WHERE UnitPrice >5000

--- Maliyeti en az olan �r�nlerin kategorisi bulunuz
SELECT TOP 1 SUM(Cost) AS 'Maliyeti', CategoryName AS 'Kategori' FROM PRODUCTS P
JOIN  CATEGORIES C ON P.CategoryID=C.CategoryID  
GROUP BY CategoryName ORDER BY SUM(Cost)

--- Kategorilere g�re �r�n say�s�n� listeleyin (�r�n say�s�n� kategori baz�nda listele)
SELECT COUNT(ProductID) AS '�r�n Say�s�', C.CategoryName AS 'Kategori' FROM PRODUCTS P 
JOIN CATEGORIES C ON P.CategoryID=C.CategoryID 
GROUP BY C.CategoryName

--- Ad� 'A' harfi ile ba�layan �r�nleri listele
SELECT * FROM PRODUCTS WHERE ProductName LIKE 'A%'

--- Stok Adedi 0-50 aras� olanlar� d���k 50-200 aras� olanlar� normal ve 200 den fazla olanlar� iyi �eklinde listeleyin 
SELECT ProductName, 
CASE 
	WHEN QuantityInStock BETWEEN 0 AND 50 THEN 'D���k'
	WHEN QuantityInStock BETWEEN 50 AND 200 THEN 'Normal'
	WHEN QuantityInStock >200 THEN '�yi'
END AS 'Stok Durumu'
FROM PRODUCTS 

--- Adresi Ceyhan olan m��terileri kad�n erkek olarak gruplay�n
SELECT Name, Surname, 
	CASE 
		WHEN Gender='E' THEN 'Erkek'
		WHEN Gender='K' THEN 'Kad�n'
	END AS 'Cinsiyet'
FROM CUSTOMERS WHERE Address in('Ceyhan')
GROUP BY Gender, Name, Surname

--- Hangi tedarik�i firmadan hangi �r�nler al�n�yor listeleyin ve firma baz�nda gruplay�n
SELECT 
	ProductName AS '�r�n Ad�',
	S.CompanyName AS 'Tedarik�i Firma'
FROM SUPPLIERS S
	JOIN PRODUCTS P ON S.SupplierID=P.SupplierID
GROUP BY S.CompanyName, ProductName

--- �al��anlar�n ya�lar�n� hesaplay�p listeleyin
SELECT 
	Name AS 'Ad�',Surname AS 'Soyad�',
	CASE 
		WHEN Gender='E' THEN 'Erkek'
		WHEN Gender='K' THEN 'Kad�n'
	END AS 'Cinsiyet',
	DATEDIFF(YEAR,BirthDate,GETDATE()) AS 'Ya�'
FROM EMPLOYEES

-- Kad�n �al��anlar�n �al��t��� departman/lar� listeleyin 
SELECT E.Name AS 'Ad�',
	Surname AS 'Soyad�',
	D.Name AS 'Departman'
FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DepartmentID=D.DepartmentID
WHERE Gender in('K')

--- Adresi Maltepe olan ve en az 3 y�ll�k �al��anlar�n bilgilerini listeleyin
SELECT 
	EmployeeID AS 'Personel No',
	E.Name AS 'Ad�',
	Surname AS 'Soyad�',
	BirthDate AS 'Do�um Tarihi',
	HireDate AS '��e Giri� Tarihi',
	Phone AS 'Telefon',
	Address AS 'Adres',
	D.Name AS 'Departman',
	C.CityName AS '�ehir'
FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DepartmentID=D.DepartmentID
				 JOIN CITIES C ON E.City=C.CityID
	WHERE Address in ('Maltepe') AND DATEDIFF(YEAR,HireDate,GETDATE())>=3

--- Beyaz E�ya kategorisinde bulunan �r�nlerin maliyetini hesaplay�n ve en az maliyeti olan �r�n� getirin
SELECT SUM(Cost) AS 'Maliyeti', ProductName
FROM PRODUCTS P JOIN CATEGORIES C ON P.CategoryID=C.CategoryID 
WHERE C.CategoryName in ('Beyaz E�ya')
GROUP BY ProductName

--- Bilgisayar kategorisine ait �r�nlerin ortalama fiyat�n� bulun
SELECT AVG(UnitPrice) FROM PRODUCTS P JOIN CATEGORIES C 
ON P.CategoryID=C.CategoryID WHERE C.CategoryName in('Bilgisayar')

--- Sipari� Adresi Beykoz olan sipari�leri listeleyin
SELECT 
	O.OrderID AS 'Sipari� No',
	C.Name+' '+C.Surname AS 'M��teri Ad�',
	P.ProductName AS '�r�n Ad�',
	O.OrderDate AS 'Sipari� Tarihi',
	O.RequireDate AS 'Teslim Tarihi',
	OS.Status AS 'Sipari� Durumu',
	O.Address+'/'+CI.CityName AS 'Adres'

FROM ORDERS O
JOIN CUSTOMERS C ON O.CustomerID=C.CustomerID
JOIN [ORDER DETAILS] OD ON O.OrderID=OD.OrderID
JOIN PRODUCTS P ON OD.ProductID=P.ProductID
JOIN CITIES CI ON O.City=CI.CityID
JOIN [ORDER STATUS] OS ON O.OrderStatus=OS.OrderStatusID
	WHERE O.Address in ('Beykoz')

--- M��teri baz�nda al�nan �r�nleri listeleyin en fazla �r�n alan 5 m��teriyi getirin
SELECT TOP 5 C.Name, C.Surname, ProductName, SUM(Quantity*UnitPrice) FROM ORDERS O
	JOIN [ORDER DETAILS] OD ON O.OrderID=OD.OrderID
	JOIN CUSTOMERS C ON O.CustomerID=C.CustomerID
	JOIN PRODUCTS P ON P.ProductID=OD.ProductID
GROUP BY C.Name, C.Surname, ProductName ORDER BY SUM(Quantity*UnitPrice) DESC

--- Be�ikta� il�esinden al�nan ve haz�r durumda olan sipari�lerin hangi m��teriler taraf�ndan verildi�ini ve hangi �r�nleri ald�klar�n� bulunuz.
SELECT C.Name, C.Surname, ProductName, OD.Quantity FROM ORDERS O 
	JOIN [ORDER STATUS] OS ON O.OrderStatus=OS.OrderStatusID
	JOIN CUSTOMERS C ON O.CustomerID=C.CustomerID
	JOIN [ORDER DETAILS] OD ON O.OrderID=OD.OrderID
	JOIN PRODUCTS P ON OD.ProductID=P.ProductID
WHERE O.Address in ('Be�ikta�') AND OS.Status in ('Haz�r')

--- Oyun Bilgisayar� kategorisinden �r�n alan m��terileri listeleyin
SELECT CS.Name, CS.Surname, ProductName FROM ORDERS O
	JOIN [ORDER DETAILS] OD ON O.OrderID=OD.OrderID
	JOIN CUSTOMERS CS ON O.CustomerID=CS.CustomerID
	JOIN PRODUCTS P ON OD.ProductID=P.ProductID
	JOIN CATEGORIES C ON P.CategoryID=C.CategoryID
		WHERE C.CategoryName='Oyun Bilgisayar�'

--- Burcu YILDIZ isimli m��terinin ald��� �r�nler hangi kategoride yer almaktad�r ve sipari� alan �al��an ad ve soyad�
SELECT 
	CS.Name AS 'M��teri Ad�', 
	CS.Surname AS 'M��teri Soyad�', 
	ProductName AS '�r�n Ad�', 
	CategoryName AS 'Kategori', 
	E.Name AS 'Personel Ad�', 
	E.Surname AS 'Personel Soyad�'
	FROM ORDERS O
	JOIN [ORDER DETAILS] OD ON O.OrderID=OD.OrderID
	JOIN PRODUCTS P ON OD.ProductID=P.ProductID
	JOIN CUSTOMERS CS ON O.CustomerID=CS.CustomerID
	JOIN EMPLOYEES E ON O.EmployeeID=E.EmployeeID
	JOIN CATEGORIES C ON P.CategoryID=C.CategoryID
	WHERE CS.Name in ('Burcu') AND CS.Surname in ('YILDIZ')

--- Kad�k�y il�esinde ka� adet m��teri vard�r ?
SELECT COUNT(*) FROM CUSTOMERS WHERE Address in ('Kad�k�y')

--- Temmuz ay�nda verilen sipari�leri listeleyin
SELECT * FROM ORDERS WHERE OrderDate BETWEEN '2023-07-01' AND '2023-07-31'

--- Caner �ELEB� isimli m��teriden kim veya kimler sipari� alm��t�r
SELECT DISTINCT C.Name,C.Surname,E.Name,E.Surname FROM ORDERS O
	JOIN CUSTOMERS C ON O.CustomerID=C.CustomerID
	JOIN EMPLOYEES E ON O.EmployeeID=E.EmployeeID
		WHERE C.Name in('Caner') AND C.Surname in('�ELEB�')

--- �al��anlar ne kadarl�k bir sat�� yapm��lard�r ? (Personel baz�nda sipari� tutarlar�)
SELECT E.Name AS 'Ad�',E.Surname AS 'Soyad�',SUM(Quantity*UnitPrice) AS 'Toplam Sat��' FROM ORDERS O 
	JOIN EMPLOYEES E ON E.EmployeeID=O.EmployeeID
	JOIN [ORDER DETAILS] OD ON O.OrderID=OD.OrderID
	JOIN PRODUCTS P ON P.ProductID=OD.ProductID 
		GROUP BY E.Name,E.Surname ORDER BY 3

--- Y�lmaz Bili�im isimli tedarik�i firmadan sat�n al�nan �r�nler hangi kategoriye aittir? 
SELECT ProductName,CategoryName FROM PRODUCTS P JOIN SUPPLIERS S ON P.SupplierID=S.SupplierID
JOIN CATEGORIES C ON C.CategoryID=P.CategoryID WHERE S.CompanyName in ('Y�lmaz Bili�im') 

--- �lkelere g�re m��terileri listeleyin
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

--- �r�n baz�nda sat�� raporu olu�turun
SELECT ProductName AS '�r�n Ad�', SUM(Quantity) AS 'Sat�� Adedi', SUM(Quantity*UnitPrice) 
AS 'Sat�� Tutar�' FROM [ORDER DETAILS] OD JOIN ORDERS O ON OD.OrderID=O.OrderID
JOIN [ORDER STATUS] OS ON O.OrderStatus=OS.OrderStatusID
JOIN PRODUCTS P ON OD.ProductID=P.ProductID WHERE OS.Status in ('Sevk Edildi')
GROUP BY ProductName

--- Onay Bekleyen sipari�ler hangi m��teriler taraf�ndan verilmi�tir?
SELECT C.Name,C.Surname FROM ORDERS O JOIN [ORDER STATUS] OS ON O.OrderStatus=OS.OrderStatusID
JOIN CUSTOMERS C ON O.CustomerID=C.CustomerID 
WHERE OS.Status in ('Onay Bekliyor')

--- Kartal il�esine sevk edilen sipari�leri �r�n baz�nda listeleyin
SELECT 
	ProductName AS '�r�n Ad�',
	StockUnitName AS 'Birim',
	UnitPrice AS 'Birim Fiyat�',
	Quantity AS 'Sat�� Adedi',
	Quantity*UnitPrice AS 'Sat�� Tutar�'
FROM ORDERS O JOIN [ORDER STATUS] OS ON O.OrderStatus=OS.OrderStatusID
JOIN [ORDER DETAILS] OD ON O.OrderID=OD.OrderID JOIN PRODUCTS P ON OD.ProductID=P.ProductID
JOIN [STOCK UNITS] SU ON P.StockUnit=SU.StockUnitID
WHERE OS.Status in ('Sevk Edildi') AND O.Address in ('Kartal')
 
--- Ersin KAYNAK isimli m��terinin verdi�i sipari�lerden haz�r olanlardaki �r�nlerin hangi kategoride olduklar�n� listeleyin
SELECT CategoryName FROM ORDERS O JOIN [ORDER DETAILS] OD ON O.OrderID=OD.OrderID
JOIN CUSTOMERS C ON O.CustomerID=C.CustomerID JOIN PRODUCTS P ON P.ProductID=OD.ProductID
JOIN CATEGORIES CA ON CA.CategoryID=P.CategoryID WHERE Name in ('Ersin') AND Surname in('KAYNAK')

--- Mehmet YAS�N isimli m��teriden hangi �al��anlar sipari� alm��lard�r?
SELECT E.Name,E.Surname FROM ORDERS O JOIN CUSTOMERS C ON O.CustomerID=C.CustomerID JOIN EMPLOYEES E
ON E.EmployeeID=O.EmployeeID WHERE C.Name in('Mehmet') AND C.Surname in('YAS�N')

--- Osman Ticaret adl� tedarik�i firmadan al�nan �r�nlerin sevk edildi�i m��teriler ve sevk edildi�i �ehirleri listeleyin
SELECT 
	CompanyName AS 'Tedarik�i Ad�',
	ProductName AS '�r�n Ad�',
	Name+' '+Surname AS 'M��teri Ad�',
	O.Address AS 'Adres',
	CityName AS '�ehir'
FROM PRODUCTS P JOIN SUPPLIERS S ON P.SupplierID=S.SupplierID JOIN [ORDER DETAILS] OD
ON OD.ProductID=P.ProductID JOIN ORDERS O ON O.OrderID=OD.OrderID JOIN CITIES CI ON CI.CityID=O.City
JOIN CUSTOMERS C ON C.CustomerID=O.CustomerID JOIN [ORDER STATUS] OS ON O.OrderStatus=OS.OrderStatusID
WHERE CompanyName in('Osman Ticaret') AND Status in('Sevk Edildi')

--- Sar�K�rm�z� Bilgisayar isimli tedarik�i firmadan al�nan �r�nler ka� farkl� kategoride yer almaktad�r
SELECT COUNT(DISTINCT CategoryName) FROM PRODUCTS P JOIN SUPPLIERS S ON P.SupplierID=S.SupplierID 
JOIN CATEGORIES C ON C.CategoryID=P.CategoryID
WHERE CompanyName in('Sar�K�rm�z� Bilgisayar') 

--- Ekim ay�nda sevk edilen sipari�lerden sipari� tutar� 2000 den fazla olanlar� listeleyin
SELECT Name 'M��teri Ad�',Surname 'M��teri Soyad�',ProductName '�r�n Ad�',
SU.StockUnitName 'Birim',UnitPrice 'Birim Fiyat�',Quantity 'Miktar�',Quantity*UnitPrice 'Tutar',
O.Address+'/'+CI.CityName 'Adres',RequireDate 'Sevk Tarihi'
FROM ORDERS O JOIN [ORDER DETAILS] OD ON O.OrderID=OD.OrderID JOIN [ORDER STATUS] OS
ON O.OrderStatus=OS.OrderStatusID JOIN PRODUCTS P ON P.ProductID=OD.ProductID
JOIN CUSTOMERS C ON C.CustomerID=O.CustomerID JOIN CITIES CI ON CI.CityID=O.City
JOIN [STOCK UNITS] SU ON SU.StockUnitID=P.StockUnit
WHERE RequireDate BETWEEN '2023-10-01' AND '2023-10-31' 
	AND Status in('Sevk Edildi') AND (Quantity*UnitPrice)>2000

-- Aylara g�re sat�� raporu olu�turan procedure yaz�n.
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

--- En gen� m��teriyi bulan procedure
CREATE PROCEDURE sp_Find_Youngest_Customer AS
BEGIN
	SELECT TOP 1 * FROM CUSTOMERS ORDER BY BirthDate DESC
END

EXEC sp_Find_Youngest_Customer

--- Sipari� adresi Ankara'n�n Alt�nda� il�esi olan ve onay bekleyen sipari�leri listeleyin
SELECT C.Name+' '+C.Surname 'M��teri Ad�',E.Name+' '+E.Surname 'Personel Ad�',OrderDate 'Sipari� Tarihi',
Status 'Sipari� Durumu',O.Address+'/'+CI.CityName 'Sevk Adresi'   
FROM ORDERS O JOIN [ORDER STATUS] OS ON O.OrderStatus=OS.OrderStatusID
JOIN CUSTOMERS C ON C.CustomerID=O.CustomerID JOIN [ORDER DETAILS] OD ON O.OrderID=OD.OrderID
JOIN EMPLOYEES E ON E.EmployeeID=O.EmployeeID JOIN CITIES CI ON CI.CityID=O.City
WHERE O.Address in('Alt�nda�') AND Status in('Onay Bekliyor')

--- Tablet PC kategorisinde bulunan �r�nleri en �ok sipari� veren m��teriyi bulunuz
SELECT TOP 1 Name+' '+Surname 'M��teri Ad�' FROM ORDERS O JOIN [ORDER DETAILS] OD ON O.OrderID=OD.OrderID
JOIN CUSTOMERS C ON C.CustomerID=O.OrderID JOIN PRODUCTS P ON P.ProductID=OD.ProductID 
JOIN CATEGORIES CAT ON CAT.CategoryID=P.CategoryID WHERE CategoryName in('Tablet PC') 
ORDER BY Quantity DESC










