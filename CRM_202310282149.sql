--- SCRIPTED DATE 2023-10-28 
IF (NOT EXISTS(SELECT * FROM sys.databases WHERE Name='CRM'))
	CREATE DATABASE CRM
ELSE
	USE CRM

	IF (NOT EXISTS (SELECT * FROM sys.tables WHERE Name='CATEGORIES'))
		CREATE TABLE CATEGORIES (
			CategoryID TINYINT IDENTITY,
			CategoryName NVARCHAR(50) NOT NULL
			PRIMARY KEY(CategoryID)
		)

	IF (NOT EXISTS (SELECT * FROM sys.tables WHERE Name='DEPARTMENTS'))
		CREATE TABLE DEPARTMENTS (
			DepartmentID TINYINT IDENTITY,
			Name NVARCHAR(50) NOT NULL
			PRIMARY KEY(DepartmentID)
		)
 
	IF (NOT EXISTS (SELECT * FROM sys.tables WHERE Name='COUNTRIES'))
		CREATE TABLE COUNTRIES (
			CountryID TINYINT IDENTITY,
			CountryName NVARCHAR(50) NOT NULL
			PRIMARY KEY(CountryID)
		)

	IF (NOT EXISTS (SELECT * FROM sys.tables WHERE NAME='CITIES'))
		CREATE TABLE CITIES (
			CityID SMALLINT Identity,
			CityName NVARCHAR(50) NOT NULL,
			CountryID TINYINT
			PRIMARY KEY(CityID)
			FOREIGN KEY(CountryID) REFERENCES COUNTRIES(CountryID)
		)

	IF (NOT EXISTS (SELECT * FROM sys.tables WHERE NAME='STOCK UNITS'))
		CREATE TABLE [STOCK UNITS] (
			StockUnitID TINYINT IDENTITY,
			StockUnitName NVARCHAR(50) NOT NULL
			PRIMARY KEY(StockUnitID)
		)

	IF (NOT EXISTS (SELECT * FROM sys.tables WHERE NAME='ORDER STATUS'))
		CREATE TABLE [ORDER STATUS] (
			OrderStatusID TINYINT IDENTITY,
			Status NVARCHAR(30) NOT NULL
			PRIMARY KEY(OrderStatusID)
		)
 
	IF (NOT EXISTS (SELECT * FROM sys.tables WHERE NAME='SUPPLIERS'))
		CREATE TABLE SUPPLIERS (
			SupplierID SMALLINT Identity,
			CompanyName NVARCHAR(50) NOT NULL,
			ContactName NVARCHAR(50),
			Phone VARCHAR(15),
			Address NVARCHAR(100),
			City SMALLINT
			PRIMARY KEY(SupplierID)
			FOREIGN KEY(City) REFERENCES CITIES(CityID)
		)
 
	IF (NOT EXISTS (SELECT * FROM sys.tables WHERE NAME='CUSTOMERS'))
		CREATE TABLE CUSTOMERS (
			CustomerID INT Identity,
			Name NVARCHAR(50) NOT NULL,
			Surname NVARCHAR(50) NOT NULL,
			Gender CHAR(1),
			BirthDate Date,
			Phone VARCHAR(15),
			Email NVARCHAR(50),
			Address NVARCHAR(100),
			City SMALLINT
			PRIMARY KEY(CustomerID)
			FOREIGN KEY(City) REFERENCES CITIES(CityID)
		)
--ALTER TABLE CUSTOMERS ADD Email NVARCHAR(50) 
	IF (NOT EXISTS (SELECT * FROM sys.tables WHERE NAME='EMPLOYEES'))
		CREATE TABLE EMPLOYEES (
			EmployeeID SMALLINT IDENTITY,
			Name NVARCHAR(50) NOT NULL,
			Surname NVARCHAR(50) NOT NULL,
			Gender CHAR(1),
			BirthDate DATE,
			HireDate DATE,
			Phone VARCHAR(15),
			Address NVARCHAR(100),
			DepartmentID tinyint,
			City smallint
			PRIMARY KEY(EmployeeID)
			FOREIGN KEY(City) REFERENCES CITIES(CityID)
		)
 
	IF (NOT EXISTS (SELECT * FROM sys.tables WHERE NAME='PRODUCTS'))
		CREATE TABLE PRODUCTS (
			ProductID SMALLINT IDENTITY,
			ProductName NVARCHAR(50) NOT NULL,
			StockUnit TINYINT,
			QuantityInUnit SMALLINT,
			QuantityInStock SMALLINT,
			UnitPrice MONEY,
			Cost MONEY,
			CategoryID TINYINT,
			SupplierID SMALLINT
			PRIMARY KEY(ProductID)
			FOREIGN KEY(StockUnit) REFERENCES [STOCK UNITS](StockUnitID),
			FOREIGN KEY(CategoryID) REFERENCES CATEGORIES(CategoryID),
			FOREIGN KEY(SupplierID) REFERENCES SUPPLIERS(SupplierID)
		)
 
	IF (NOT EXISTS (SELECT * FROM sys.tables WHERE NAME='ORDERS'))
		CREATE TABLE ORDERS (
			OrderID INT IDENTITY,
			CustomerID INT,
			EmployeeID SMALLINT,
			OrderDate DATE,
			RequireDate DATE,
			OrderStatus TINYINT,
			Address NVARCHAR(100),
			City SMALLINT
			PRIMARY KEY(OrderID)
			FOREIGN KEY(CustomerID) REFERENCES CUSTOMERS(CustomerID),
			FOREIGN KEY(EmployeeID) REFERENCES EMPLOYEES(EmployeeID),
			FOREIGN KEY(OrderStatus) REFERENCES [ORDER STATUS](OrderStatusID)
		)
 
	IF (NOT EXISTS(SELECT * FROM sys.tables WHERE NAME='ORDER DETAILS'))
		CREATE TABLE [ORDER DETAILS] (
			OrderID INT,
			ProductID SMALLINT,
			Quantity SMALLINT
			FOREIGN KEY(OrderID) REFERENCES ORDERS(OrderID),
			FOREIGN KEY(ProductID) REFERENCES PRODUCTS(ProductID)
		)
		 
	CREATE PROC sp_Insert_Category @categoryName varchar(max)
	AS
	BEGIN 
		IF(NOT EXISTS(SELECT * FROM CATEGORIES WHERE CategoryName=@categoryName))
			INSERT INTO CATEGORIES (CategoryName) VALUES (@categoryName)
		ELSE
			PRINT @categoryName+' isimli kategori zaten mevcut'
	END

	EXEC sp_Insert_Category 'Cep Telefonu'
	EXEC sp_Insert_Category 'Bilgisayar'
	EXEC sp_Insert_Category 'Tablet PC'
	EXEC sp_Insert_Category 'Oyun Bilgisayarý'
	EXEC sp_Insert_Category 'Ofis & Kýrtasiye'
	EXEC sp_Insert_Category 'Beyaz Eþya'

 
	CREATE PROC sp_Insert_Department @dName varchar(max) 
	AS 
	BEGIN 
		IF(NOT EXISTS(SELECT * FROM DEPARTMENTS WHERE Name=@dName))
			INSERT INTO DEPARTMENTS (Name) VALUES (@dName)
		ELSE
			PRINT @dName+' isimli departman zaten mevcut'
	END

	EXEC sp_Insert_Department 'Ýnsan Kaynaklarý'
	EXEC sp_Insert_Department 'IT (Information Technologies)'
	EXEC sp_Insert_Department 'Güvenlik'
	EXEC sp_Insert_Department 'Genel Hizmetler'
	EXEC sp_Insert_Department 'Kalite Kontrol'
	EXEC sp_Insert_Department 'Muhasebe'
	EXEC sp_Insert_Department 'Pazarlama'
	EXEC sp_Insert_Department 'Satýn Alma'
	EXEC sp_Insert_Department 'Yönetim'
	EXEC sp_Insert_Department 'Sevkiyat'

	CREATE PROC sp_Insert_Country @countryName varchar(max)
	AS
	BEGIN
		IF (NOT EXISTS (SELECT * FROM COUNTRIES WHERE CountryName=@countryName))
			INSERT INTO COUNTRIES (CountryName) VALUES (@countryName)
		ELSE
			PRINT @countryName+' isimli ülke zaten mevcut'
	END

	EXEC sp_Insert_Country 'Türkiye'
	EXEC sp_Insert_Country 'Hollanda'
	EXEC sp_Insert_Country 'Fransa'
	EXEC sp_Insert_Country 'Belçika'
	EXEC sp_Insert_Country 'Ýspanya'
	EXEC sp_Insert_Country 'Portekiz'

	CREATE PROC sp_Insert_City @cityName varchar(max), @countryID tinyint
	AS
	BEGIN
		IF(NOT EXISTS (SELECT * FROM CITIES WHERE CityName=@cityName))
			INSERT INTO CITIES (CityName, CountryID) VALUES (@cityName, @countryID)
		ELSE 
			PRINT @cityName+' isimli þehir zaten mevcut'	
	END

	EXEC sp_Insert_City 'Ýstanbul', 1
	EXEC sp_Insert_City 'Konya', 1
	EXEC sp_Insert_City 'Adana', 1
	EXEC sp_Insert_City 'Ankara', 1
	EXEC sp_Insert_City 'Antalya', 1
	EXEC sp_Insert_City 'Tekirdað', 1
	EXEC sp_Insert_City 'Sakarya', 1
	EXEC sp_Insert_City 'Kocaeli', 1
	EXEC sp_Insert_City 'Ýzmir', 1
	EXEC sp_Insert_City 'Kýrklareli', 1
	EXEC sp_Insert_City 'Düzce', 1
	EXEC sp_Insert_City 'Edirne', 1
	EXEC sp_Insert_City 'Aydýn', 1
	EXEC sp_Insert_City 'Balýkesir', 1
	EXEC sp_Insert_City 'Bilecik', 1
	EXEC sp_Insert_City 'Bursa', 1
	EXEC sp_Insert_City 'Denizli', 1
	EXEC sp_Insert_City 'Eskiþehir', 1
	EXEC sp_Insert_City 'Amsterdam', 2
	EXEC sp_Insert_City 'Rotterdam', 2
	EXEC sp_Insert_City 'Lahey', 2
	EXEC sp_Insert_City 'Eindhoven', 2
	EXEC sp_Insert_City 'Groningen', 2
	EXEC sp_Insert_City 'Tilburg', 2
	EXEC sp_Insert_City 'Almere', 2
	EXEC sp_Insert_City 'Alkmar', 2
	EXEC sp_Insert_City 'Nice', 3
	EXEC sp_Insert_City 'Troyes', 3
	EXEC sp_Insert_City 'Rodez', 3
	EXEC sp_Insert_City 'Marsilya', 3
	EXEC sp_Insert_City 'Caen', 3
	EXEC sp_Insert_City 'Ajaccio', 3
	EXEC sp_Insert_City 'Dijon', 3
	EXEC sp_Insert_City 'Paris', 3
	EXEC sp_Insert_City 'Versay', 3
	EXEC sp_Insert_City 'Toulouse', 3
	EXEC sp_Insert_City 'Bordeaux', 3
	EXEC sp_Insert_City 'Montpellier', 3
	EXEC sp_Insert_City 'Rennes', 3
	EXEC sp_Insert_City 'Saint Etienne', 3
	EXEC sp_Insert_City 'Nantes', 3
	EXEC sp_Insert_City 'Lille', 3
	EXEC sp_Insert_City 'Strazburg', 3
	EXEC sp_Insert_City 'Lyon', 3
	EXEC sp_Insert_City 'Antwerpen', 4
	EXEC sp_Insert_City 'Brüksel', 4
	EXEC sp_Insert_City 'Mechelen', 4
	EXEC sp_Insert_City 'Gent', 4
	EXEC sp_Insert_City 'Brugge', 4
	EXEC sp_Insert_City 'Almeria', 5
	EXEC sp_Insert_City 'Barselona', 5
	EXEC sp_Insert_City 'Bilbao', 5
	EXEC sp_Insert_City 'Cadiz', 5
	EXEC sp_Insert_City 'Cordoba', 5
	EXEC sp_Insert_City 'Palma de Mallorca', 5
	EXEC sp_Insert_City 'Madrid', 5
	EXEC sp_Insert_City 'Valensiya', 5
	EXEC sp_Insert_City 'Granada', 5
	EXEC sp_Insert_City 'Malaga', 5
	EXEC sp_Insert_City 'Sevilla', 5
	EXEC sp_Insert_City 'Setubal', 6
	EXEC sp_Insert_City 'Braga', 6
	EXEC sp_Insert_City 'Lizbon', 6
	EXEC sp_Insert_City 'Porto', 6
	EXEC sp_Insert_City 'Funchal', 6
	EXEC sp_Insert_City 'Almeirim', 6
	EXEC sp_Insert_City 'Aveiro', 6

	CREATE PROC sp_Insert_Supplier 
						@companyName nvarchar(max), 
						@contactName nvarchar(max),
						@phone varchar(15), 
						@address ntext,
						@city smallint
	AS
	BEGIN
		IF(NOT EXISTS(SELECT * FROM SUPPLIERS WHERE CompanyName=@companyName))
			INSERT INTO SUPPLIERS (CompanyName,ContactName,Phone,Address,City) VALUES 
			(@companyName,@contactName,@phone,@address,@city)		
		ELSE 
			PRINT @companyName+' isimli firma zaten mevcut'
	END

	EXEC sp_Insert_Supplier 'Cengiz Ýnþaat ve Yapý Malzemeleri','Cengiz Ünlü','516-558-96-22','Pendik',1
	EXEC sp_Insert_Supplier 'Turgut Yapý','Turgut Ünlü','516-508-95-55','Maltepe',1
	EXEC sp_Insert_Supplier 'Acarer Mühendislik','Barýþ Acarer','516-213-87-69','Kartal',1
	EXEC sp_Insert_Supplier 'Yýlmaz Biliþim','Yýlmaz Tunç','536-545-89-11','Kadýköy',1
	EXEC sp_Insert_Supplier 'Sadýk Giyim','Gülten Sadýk','526-395-55-88','Bahçelievler',1
	EXEC sp_Insert_Supplier 'Ahenk Mühendislik','Barýþ Yýlmaz','544-355-33-55','Sarýyer',1
	EXEC sp_Insert_Supplier 'Tolga Otomasyon','Tolga Acar','546-142-94-28','Beþiktaþ',1
	EXEC sp_Insert_Supplier 'Osman Ticaret','Osman Yalçýn','541-556-16-29','Üsküdar',1
	EXEC sp_Insert_Supplier 'Gönlüyanýk Yapý','Gönül Sarý','545-896-22-30','Beyoðlu',1
	EXEC sp_Insert_Supplier 'SarýKýrmýzý Bilgisayar','Fatih Sarý','526-395-55-88','Sultanbeyli',1

	CREATE PROC sp_Insert_Customer 
							@name nvarchar(max),
							@surname nvarchar(max),
							@gender char(1),
							@birthDate date,
							@phone varchar(15),
							@email nvarchar(max),
							@address varchar(100),
							@city smallint
	AS
	BEGIN
		IF(NOT EXISTS(SELECT * FROM CUSTOMERS WHERE Name=@name and Surname=@surname))
			INSERT INTO CUSTOMERS (Name,Surname,Gender,BirthDate,Phone, Email,Address,City)
			VALUES (@name,@surname,@gender,@birthDate,@phone,@email,@address,@city)
		ELSE 
			PRINT @name+' '+@surname+' isimli müþteri zaten kayýtlý'
	END

EXEC sp_Insert_Customer 'Burcu','YILDIZ','K','1985-10-13','555-444-33-22','burcuyildz@outlook.com','Ceyhan',3 
EXEC sp_Insert_Customer 'Ahmet','KARATAÞ','E','1987-11-25','543-333-22-11','ahmetkrts@outlook.com','Ceyhan',3
EXEC sp_Insert_Customer 'Yasin','ARDIÇ','E','1966-09-15','555-401-33-23','yasinardic@outlook.com','Beyoðlu',1
EXEC sp_Insert_Customer 'Kamil','YÜCESOY','E','1980-02-21','544-380-15-12','kamilyuces@outlook.com','Noord',19
EXEC sp_Insert_Customer 'Mert','YILMAZ','E','1967-03-12','555-444-33-24','mertyil@outlook.com','Maltepe',1
EXEC sp_Insert_Customer 'Yeþim','KALDIRIM','K','1980-03-04','536-379-22-13','yesimkald@outlook.com','Kadýköy',1
EXEC sp_Insert_Customer 'Mehmet','YASÝN','E','1976-05-29','555-414-08-25','mehmetyasin@outlook.com','Beykoz',1
EXEC sp_Insert_Customer 'Narin','KIZMAZ','K','1958-06-09','548-123-45-67','narinkizmaz@outlook.com','Hendek',7
EXEC sp_Insert_Customer 'Nedim','AÐLAMAZ','E','1981-09-11','538-978-22-12','nedimaglamaz@outlook.com','Ceyhan',3
EXEC sp_Insert_Customer 'Kemal','SÖNMEZ','E','1978-10-20','555-007-14-24','kemalsonm@outlook.com','Çorlu',6
EXEC sp_Insert_Customer 'Meltem','YILMAZ','K','1986-11-10','539-333-15-80','meltyilm@outlook.com','Gebze',8
EXEC sp_Insert_Customer 'Mirat','SÖYLEMEZ','E','1968-12-27','540-135-14-28','mtsoy35@outlook.com','Bornova',9
EXEC sp_Insert_Customer 'Engin','DURMAZ','E','1987-10-15','555-456-11-85','engindur@outlook.com','Lüleburgaz',10
EXEC sp_Insert_Customer 'Nergis','YORULMAZ','K','1993-02-18','528-369-25-69','nergisyorulmaz@outlook.com','Balçova',9
EXEC sp_Insert_Customer 'Yunus','BASMAZ','E','1990-01-23','564-589-25-45','yunusbasmaz@outlook.com','Altýndað',4
EXEC sp_Insert_Customer 'Baþak','DURMAZ','K','1989-04-08','586-369-45-25','basakdurmaz@outlook.com','Merkez',19
EXEC sp_Insert_Customer 'Kahraman','YENÝLMEZ','E','1979-03-11','546-258-78-95','kahramanyenilmez@outlook.com','Mamak',4
EXEC sp_Insert_Customer 'Menekþe','SARSILMAZ','K','1980-02-14','536-852-96-36','meneksesarsilmaz@outlook.com','Yenimahalle',4
EXEC sp_Insert_Customer 'Yusuf','KULAKSIZ','E','1985-11-28','548-259-47-25','yusufkulaksiz@outlook.com','Kaþ',5
EXEC sp_Insert_Customer 'Faruk','SÖNMEZ','E','1956-11-25','564-589-36-11','faruksonmez@outlook.com','Karatay',2
EXEC sp_Insert_Customer 'Furkan','YENÝÇERÝ','E','1988-04-20','541-124-85-17','furkanyenicherry@outlook.com','Akseki',5
EXEC sp_Insert_Customer 'Naci','KORKMAZ','E','1996-01-19','526-584-21-99','nacikorkmaz@outlook.com','Aksu',5
EXEC sp_Insert_Customer 'Cihan','BEDEL','E','1995-01-17','554-546-85-96','cihanbedel07@outlook.com','Kemer',5
EXEC sp_Insert_Customer 'Kemal','ÝNCE','E','1990-09-10','546-841-96-58','kemalince@outlook.com','Çine',13
EXEC sp_Insert_Customer 'Macit','IÞIK','E','1997-08-07','511-021-25-36','macitisik@outlook.com','Didim',13
EXEC sp_Insert_Customer 'Mehmet','VARLI','E','1994-06-05','523-963-54-78','mehmetvarli@outlook.com','Ýncirliova',13
EXEC sp_Insert_Customer 'Tarýk','SÖNMEZ','E','1998-04-03','547-584-11-41','tariksonmez@outlook.com','Ayvalýk',14
EXEC sp_Insert_Customer 'Murat','KAHRAMAN','E','1988-08-16','540-890-11-47','muratkahraman@outlook.com','Bozüyük',15
EXEC sp_Insert_Customer 'Beril','TÜRK','K','1992-01-17','533-825-85-77','berilturk@outlook.com','Gerede',16
EXEC sp_Insert_Customer 'Nagihan','TÜRK','K','1994-03-18','543-790-11-48','nagiturk@outlook.com','Gemlik',17
EXEC sp_Insert_Customer 'Deniz','YILDIZ','K','1975-05-19','553-111-66-80','denizyil@outlook.com','Yeniþehir',17
EXEC sp_Insert_Customer 'Zeynep','AKSU','K','1997-01-20','542-113-16-81','zeynepaksu@outlook.com','Gemlik',17
EXEC sp_Insert_Customer 'Pelin','SÖNMEZ','K','1994-08-21','534-256-00-79','pelinsonmez@outlook.com','Merkezefendi',18
EXEC sp_Insert_Customer 'Merve','SAÐLAM','K','1990-07-22','528-890-15-50','mervesaglam@outlook.com','Pamukkale',18
EXEC sp_Insert_Customer 'Hanife','SAÐLAM','K','1989-08-23','533-231-55-80','hanifesaglam@outlook.com','Le Marais',34
EXEC sp_Insert_Customer 'Furkan','VARLI','E','1999-07-24','541-895-12-51','furkanvarli@outlook.com','Montmarte',34
EXEC sp_Insert_Customer 'Nabi','SAYMAZ','E','1996-06-25','512-416-55-81','nabisaymaz@outlook.com','Vorst',46
EXEC sp_Insert_Customer 'Kadriye','KAYMAZ','K','1987-01-26','541-455-11-52','kadriyekaymaz@outlook.com','Ukkel',46
EXEC sp_Insert_Customer 'Yasemin','KORKMAZ','K','1991-01-27','535-712-55-82','yaseminkorkmaz@outlook.com','Binnenstad',48
EXEC sp_Insert_Customer 'Nejdet','ÖTMEZ','E','1992-03-28','542-890-11-53','nejdetotmez@outlook.com','Merkez',49
EXEC sp_Insert_Customer 'Sedat','TÜRKOÐLU','E','1993-04-29','543-125-55-83','sedatturko@outlook.com','Merkez',47
EXEC sp_Insert_Customer 'Selda','TÜRKOÐLU','K','1978-08-30','530-890-11-54','seldaturko@outlook.com','Merkez',26
EXEC sp_Insert_Customer 'Sercan','YILMAZ','E','1980-08-31','528-125-55-84','sercanyilmaz@outlook.com','Merkez',26
EXEC sp_Insert_Customer 'Caner','YILMAZ','E','1982-09-02','545-890-11-55','caneryilmaz@outlook.com','Merkez',51
EXEC sp_Insert_Customer 'Münevver','YILMAZ','K','1984-09-03','553-125-55-85','munevveryilmaz@outlook.com','Merkez',55
EXEC sp_Insert_Customer 'Mihriban','YALÇIN','K','1986-09-05','541-890-11-56','mihribanyalcin@outlook.com','Merkez',56
EXEC sp_Insert_Customer 'Ercan','DUMAN','E','1988-09-06','503-125-55-86','ercanduman@outlook.com','Merkez',57
EXEC sp_Insert_Customer 'Akif','ATAGÜL','E','1990-09-08','540-890-11-57','akifatagul@outlook.com','Merkez',59
EXEC sp_Insert_Customer 'Atakan','ÞENOÐLU','E','1992-09-09','503-125-55-87','atakansenoglu@outlook.com','La Macarena',60
EXEC sp_Insert_Customer 'Arzu','AYCAN','K','1994-09-11','540-890-11-58','arzuaycan@outlook.com','Santa Maria',53
EXEC sp_Insert_Customer 'Zuhal','AYDIN','K','1996-09-12','503-125-55-88','zuhalaydin@outlook.com','Merkez',57
EXEC sp_Insert_Customer 'Meral','TÜRKOÐLU','K','1998-09-14','540-890-11-59','meralturko@outlook.com','Merkez',58
EXEC sp_Insert_Customer 'Leyla','MEYÝLLÝ','K','2000-09-15','503-125-55-89','leylameyilli@outlook.com','Graça',63
EXEC sp_Insert_Customer 'Arif','SÝMÝT','E','1974-09-11','540-890-11-60','arifsimit@outlook.com','Merkez',64
EXEC sp_Insert_Customer 'Rafet','ÜSTÜN','E','1975-09-12','503-125-55-90','rafetustun@outlook.com','Merkez',65
EXEC sp_Insert_Customer 'Gökhan','ALTIN','E','1976-09-12','540-890-11-61','gokhanaltin@outlook.com','Alfama',63
EXEC sp_Insert_Customer 'Gencay','ÞENER','E','1977-09-13','503-125-55-91','gencaysener@outlook.com','Sado',61
EXEC sp_Insert_Customer 'Remzi','ÜNYELÝ','E','1978-09-14','540-890-11-62','remziunyeli@outlook.com','Amadora',66
EXEC sp_Insert_Customer 'Mahmut','ÜNLÜ','E','1979-09-15','503-125-55-92','mahmutunlu@outlook.com','Gambia',61
EXEC sp_Insert_Customer 'Aysu','BURÇAL','K','1980-09-15','540-890-11-63','aysuburcal@outlook.com','Merkez',67
EXEC sp_Insert_Customer 'Ahmet','YOSUN','E','1981-09-16','503-125-55-93','ahmetyosun@outlook.com','Merkez',63
EXEC sp_Insert_Customer 'Hamide','SARAÇ','K','1982-09-17','540-890-11-64','hamidesarac@outlook.com','Lalapaþa',12
EXEC sp_Insert_Customer 'Hande','ÇELÝK','K','1983-09-18','503-125-55-94','handecelik@outlook.com','Merkez',12
EXEC sp_Insert_Customer 'Kenan','DEMÝR','E','1984-09-18','540-890-11-65','kenandemir@outlook.com','Merkez',12
EXEC sp_Insert_Customer 'Yusuf','DEMÝRKAN','E','1985-09-19','503-125-55-95','yusufdemirkan@outlook.com','Merkez',12
EXEC sp_Insert_Customer 'Lale','DEMÝRCÝ','K','1986-09-20','540-890-11-66','laledemirci@outlook.com','Merkez',20
EXEC sp_Insert_Customer 'Nilüfer','CANSEVEN','K','1987-09-21','503-125-55-96','nilüfercanseven@outlook.com','Merkez',20
EXEC sp_Insert_Customer 'Narin','SEVMEZ','K','1988-09-21','535-654-35-11','narinsevmez@outlook.com','Günyüzü',22
EXEC sp_Insert_Customer 'Mahmut','KOYMAZ','E','1989-09-22','563-655-88-99','mahmutkoymaz@outlook.com','Segbroek',21
EXEC sp_Insert_Customer 'Ateþ','YILDIRIM','E','1990-09-23','555-489-65-25','atesyildirim@outlook.com','Merkez',19
EXEC sp_Insert_Customer 'Yýldýz','ÞÝMÞEK','K','1991-09-24','545-4578-90','yildizsimsek@outlook.com','Oost',19
EXEC sp_Insert_Customer 'Emin','AÞIK','E','1992-09-24','551-578-25-45','eminasik@outlook.com','Maltepe',1
EXEC sp_Insert_Customer 'Koray','BAYTAR','E','1993-09-25','564-996-77-45','koraybaytar@outlook.com','Karatay',2
EXEC sp_Insert_Customer 'Hamdi','TOSUN','E','1994-09-26','553-689-23-54','hamditosun@outlook.com','Karatay',2
EXEC sp_Insert_Customer 'Kerem','AKTÜRK','E','1995-09-27','575-789-65-43','keremakturk	@outlook.com','Ferizli',7
EXEC sp_Insert_Customer 'Caner','ÇELEBÝ','E','1996-09-27','511-678-90-12','canercelebi@outlook.com','Beþiktaþ',1
EXEC sp_Insert_Customer 'Yeþim','ÇINAR','K','1997-09-28','513-355-57-79','yesimcinar@outlook.com','Beþiktaþ',1
EXEC sp_Insert_Customer 'Fatih','GÜL','E','1998-09-29','523-234-12-34','fatihgul@outlook.com','Üsküdar',1
EXEC sp_Insert_Customer 'Berat','ARDIÇ','E','1999-09-30','524-567-89-91','beratardic@outlook.com','Beykoz',1
EXEC sp_Insert_Customer 'Pýnar','ÇAMLICA','K','2000-09-30','501-234-56-78','pinarcamlica@outlook.com','Tuzla',1
EXEC sp_Insert_Customer 'Deniz','YAKUT','K','2001-10-01','534-567-89-01','denizyakut@outlook.com','Merkez',37
EXEC sp_Insert_Customer 'Serpil','ZÜMRÜT','K','1981-10-09','551-342-756-98','serpilzumrut@outlook.com','Pendik',1
EXEC sp_Insert_Customer 'Osman','PAÞALI','E','1983-10-10','502-468-01-35','osmanpasali@outlook.com','Pendik',1
EXEC sp_Insert_Customer 'Yiðit','CENGAVER','E','1985-10-10','511-115-55-55','yigitcengaver@outlook.com','Kartal',1
EXEC sp_Insert_Customer 'Güzide','YAMAN','K','1987-10-11','556-654-54-78','guzideyaman@outlook.com','Kartal',1
EXEC sp_Insert_Customer 'Osman','TÜRKOÐLU','E','1989-10-11','554-897-11-45','osmanturko@outlook.com','Maltepe',1
EXEC sp_Insert_Customer 'Yasin','ÖZTÜRK','E','1991-10-12','552-654-78-95','yasinozturk@outlook.com','Kartal',1
EXEC sp_Insert_Customer 'Mehmet','KOÇ','E','1993-10-12','553-456-78-92','mehmetkoc@outlook.com','Sarýyer',1
EXEC sp_Insert_Customer 'Ramazan','KOÇOÐLU','E','1995-10-13','556-589-11-43','ramazankocoglu@outlook.com','Esenler',1
EXEC sp_Insert_Customer 'Mertcan','MÝRZAOÐLU','E','1997-10-13','555-456-65-67','mertcanmirzao@outlook.com','Merkez',35
EXEC sp_Insert_Customer 'Aleyna','KAÞLI','K','1999-10-14','539-718-24-24','aleynakasli@outlook.com','Merkez',36
EXEC sp_Insert_Customer 'Tolga','YAYLA','E','2001-10-14','540-557-15-56','tolgayayla@outlook.com','Þile',1
EXEC sp_Insert_Customer 'Efe','YENÝLMEZ','E','2003-10-15','517-659-89-78','efeyenilmez@outlook.com','Þile',1
EXEC sp_Insert_Customer 'Ayça','ÜSTÜN','K','2005-10-15','537-589-25-45','aycaustun@outlook.com','Þile',1
EXEC sp_Insert_Customer 'Beren','ALTIN','K','1994-10-22','538-589-15-38','berenaltin@outlook.com','Üsküdar',1
EXEC sp_Insert_Customer 'Cemre','BAÞAK','K','1994-10-23','537-987-25-45','cemrebasak@outlook.com','Esenler',1
EXEC sp_Insert_Customer 'Hande','MARAZ','K','1994-10-24','538-123-45-67','handemaraz@outlook.com','Pendik',1
EXEC sp_Insert_Customer 'Gizem','RAMAK','K','1994-10-25','533-580-22-33','gizemramak@outlook.com','Kadýköy',1
EXEC sp_Insert_Customer 'Yasin','TÜRKOÐLU','E','1994-10-26','533-560-78-90','yasinnturkoo@outlook.com','Kadýköy',1
EXEC sp_Insert_Customer 'Ersin','KAYNAK','E','1994-10-27','556-589-25-45','ersinkaynak@outlook.com','Beyoðlu',1
 
	CREATE PROC sp_Insert_Stock_Unit @name varchar(max)
	AS
	BEGIN
		IF(NOT EXISTS(SELECT * FROM [STOCK UNITS] WHERE StockUnitName=@name))
			INSERT INTO [STOCK UNITS] VALUES (@name)
		ELSE 
			PRINT @name+' isminde stok birim zaten mevcut'
	END

	EXEC sp_Insert_Stock_Unit 'Adet'
	EXEC sp_Insert_Stock_Unit 'Kilogram'
	SELECT * FROM [STOCK UNITS]

	CREATE PROC sp_Insert_Order_Status @name varchar(max)
	AS
	BEGIN
		IF(NOT EXISTS(SELECT * FROM [ORDER STATUS] WHERE Status=@name))
			INSERT INTO [ORDER STATUS] VALUES (@name)
		ELSE 
			PRINT @name+' isimli durum zaten mevcut'
	END

	EXEC sp_Insert_Order_Status 'Hazýr'
	EXEC sp_Insert_Order_Status 'Onay Bekliyor'
	EXEC sp_Insert_Order_Status 'Onaylandý'
	EXEC sp_Insert_Order_Status 'Onaylanmadý'
	EXEC sp_Insert_Order_Status 'Sevk Edildi'
	EXEC sp_Insert_Order_Status 'Ertelendi'

	SELECT * FROM [ORDER STATUS]

	CREATE PROC sp_Insert_Employee 
					@name nvarchar(50), 
					@surname nvarchar(50),
					@gender char(1),
					@birthdate date,
					@hiredate date,
					@phone varchar(15),
					@address nvarchar(100),
					@depID tinyint,
					@city smallint
	AS
	BEGIN 
		IF(NOT EXISTS(SELECT * FROM EMPLOYEES WHERE Name in(@name) and Surname in(@surname)))
			INSERT INTO EMPLOYEES 
			(Name,Surname,Gender,BirthDate,HireDate,Phone,Address,DepartmentID,City)
			VALUES (@name,@surname,@gender,@birthdate,@hiredate,@phone,@address,@depID,@city)
		ELSE 
			PRINT @name+' '+@surname+' isimli çalýþan zaten mevcut'
	END

	EXEC sp_Insert_Employee 'Emre','KIRCI','E','1985-04-21','2010-01-03','546-893-11-25','Maltepe',1,1 
	EXEC sp_Insert_Employee 'Çýnar','YALNIZ','E','1987-01-16','2011-02-04','537-847-11-86','Pendik',1,1 
	EXEC sp_Insert_Employee 'Seda','BAÞKAN','K','1978-08-05','2012-03-07','546-893-11-26','Kartal',1,1
	EXEC sp_Insert_Employee 'Mahmut','ÞEVKET','E','1975-07-28','2013-04-08','545-801-10-82','Kadýköy',2,1
	EXEC sp_Insert_Employee 'Mehmet','AYDIN','E','1988-06-12','2014-05-10','537-779-19-77','Bahçelievler',2,1
	EXEC sp_Insert_Employee 'Aylin','KORKUSUZ','K','1980-09-08','2015-06-11','539-855-77-89','Beþiktaþ',4,1
	EXEC sp_Insert_Employee 'Ýnci','MERCAN','K','1974-05-01','2016-07-12','537-123-45-67','Ümraniye',4,1
	EXEC sp_Insert_Employee 'Pýnar','SOYLU','K','1975-05-03','2017-08-13','538-234-56-78','Üsküdar',4,1
	EXEC sp_Insert_Employee 'Betül','KAYMAK','K','1984-06-03','2018-09-14','535-678-90-01','Ataþehir',5,1
	EXEC sp_Insert_Employee 'Hasan','AKKOYUN','E','1971-02-04','2019-10-16','536-789-01-23','Sancaktepe',5,1
	EXEC sp_Insert_Employee 'Hüseyin','ÇINAR','E','1975-05-03','2020-11-16','512-345-67-89','Sultanbeyli',5,1
	EXEC sp_Insert_Employee 'Yusuf','ÇINAR','E','1984-06-03','2021-12-18','534-567-89-01','Kartal',3,1
	EXEC sp_Insert_Employee 'Erdem','YENÝL','E','1971-02-04','2023-01-19','556-789-01-23','Pendik',8,1
	EXEC sp_Insert_Employee 'Ahmet','SAZLI','E','1975-05-03','2010-02-20','501-234-56-78','Pendik',7,1
	EXEC sp_Insert_Employee 'Murat','ÞEHZADE','E','1984-06-03','2011-03-23','530-123-45-67','Pendik',7,1
	EXEC sp_Insert_Employee 'Tülin','ÇAÐLA','K','1971-02-04','2012-04-22','531-357-90-99','Maltepe',7,1
	EXEC sp_Insert_Employee 'Eren','KORKMAZ','E','1975-05-03','2013-05-23','547-123-45-67','Sultanbeyli',7,1
	EXEC sp_Insert_Employee 'Naime','ÞENER','K','1984-06-03','2014-06-23','507-046-01-10','Kartal',6,1
	EXEC sp_Insert_Employee 'Gökhan','DEMÝR','E','1971-02-04','2015-07-24','532-547-11-10','Beykoz',6,1
	EXEC sp_Insert_Employee 'Harun','ATEÞ','E','1975-05-03','2016-08-23','502-257-79-02','Þiþli',6,1
	EXEC sp_Insert_Employee 'Veli','ACAR','E','1984-06-03','2017-09-23','537-740-18-05','Þile',9,1
	EXEC sp_Insert_Employee 'Tolga','IÞIK','E','1971-02-04','2018-10-24','539-847-11-10','Beykoz',9,1
	EXEC sp_Insert_Employee 'Burak','SADIK','E','1975-05-03','2019-11-24','533-118-05-07','Pendik',10,1
	EXEC sp_Insert_Employee 'Kamil','SONER','E','1984-06-03','2020-12-24','500-800-10-10','Pendik',10,1
	EXEC sp_Insert_Employee 'Abdullah','CANDAN','E','1971-02-04','2022-01-24','555-444-33-22','Arnavutköy',10,1
	EXEC sp_Insert_Employee 'Hacý','KORKUSUZ','E','1975-05-03','2023-02-24','531-125-34-67','Sarýyer',10,1
	EXEC sp_Insert_Employee 'Cihan','POLAT','E','1984-06-03','2023-05-22','537-851-25-79','Kartal',10,1
	
	SELECT * FROM PRODUCTS

	CREATE PROC sp_Insert_Product 
							@name nvarchar(50),
							@unit tinyint,
							@qtyUnit smallint, 
							@qtyStk smallint,
							@price money,
							@cost money,
							@catID tinyint,
							@suppID smallint
	AS
	BEGIN
		IF(NOT EXISTS(SELECT * FROM PRODUCTS WHERE ProductName=@name))
			INSERT INTO PRODUCTS 
				(ProductName,StockUnit,QuantityInUnit,QuantityInStock,UnitPrice,Cost,CategoryID,SupplierID)
			VALUES 
				(@name,@unit,@qtyUnit,@qtyStk,@price,@cost,@catID,@suppID)
		ELSE 
			PRINT @name+' isminde zaten bir ürün mevcut'
	END

	EXEC sp_Insert_Product 'Samsung Galaxy A32',1,1,150,5000,3500,1,4
	EXEC sp_Insert_Product 'ASUS Notebook',1,1,200,10000,8550,2,4
	EXEC sp_Insert_Product 'HP Notebook',1,1,250,15000,11000,2,4
	EXEC sp_Insert_Product 'Buzdolabý',1,1,200,1000,6750,6,8
	EXEC sp_Insert_Product 'Çamaþýr Makinesi',1,1,100,15000,12500,6,8
	EXEC sp_Insert_Product 'Monster Gaming Notebook',1,1,100,35000,28750,4,4
	EXEC sp_Insert_Product 'Samsung Tab S7',1,1,150,7550,5850,3,4
	EXEC sp_Insert_Product 'Ofis Masasý',1,1,200,6500,4850,5,10
	EXEC sp_Insert_Product 'Ofis Koltuk',1,1,300,4800,3450,5,10
	EXEC sp_Insert_Product 'Apple Ipad',1,1,350,8600,7850,3,4
	EXEC sp_Insert_Product 'Bulaþýk Makinesi',1,1,100,6500,5750,6,8
	EXEC sp_Insert_Product 'APPLE Iphone 14',1,1,500,54000,49000,1,4
	EXEC sp_Insert_Product 'Apple Macbook',1,1,500,45000,37500,2,4
	EXEC sp_Insert_Product 'Casper Notebook',1,1,125,22799,17599,2,4
	EXEC sp_Insert_Product 'A4 Fotokopi Kaðýt',2,500,50,22.5,12.75,2,4
	EXEC sp_Insert_Product 'Klavye',1,1,1000,259,99,5,10
	EXEC sp_Insert_Product 'Mouse',1,1,1000,159,99,5,10
	EXEC sp_Insert_Product 'Mousepad',1,1,1500,149,59,5,10
	EXEC sp_Insert_Product 'Hoparlör',1,1,1500,299,149,5,10
	EXEC sp_Insert_Product 'Mikrofon',1,1,1500,129,89,5,10

	CREATE PROC sp_Insert_Order @customer int, @employee int, @orderDate date, @reqDate date, 
						@status tinyint, @address nvarchar(100), @city smallint 
	AS 
	BEGIN 
		INSERT INTO ORDERS (CustomerID, EmployeeID, OrderDate, RequireDate, OrderStatus, Address, City)
		VALUES 
			(@customer,@employee,@orderDate,@reqDate,@status,@address,@city)
	END
 
	EXEC sp_Insert_Order 3,14,'2023-07-01','2023-07-02',5,'Beyoðlu',1
	EXEC sp_Insert_Order 7,15,'2023-07-02','2023-07-03',5,'Beykoz',1
	EXEC sp_Insert_Order 15,16,'2023-07-03','2023-07-04',5,'Altýndað',4
	EXEC sp_Insert_Order 55,17,'2023-07-04','2023-07-05',5,'Merkez',65
	EXEC sp_Insert_Order 62,15,'2023-07-05','2023-07-06',5,'Lalapaþa',12
	EXEC sp_Insert_Order 70,14,'2023-07-06','2023-07-07',5,'Merkez',19
	EXEC sp_Insert_Order 72,14,'2023-07-07','2023-07-08',5,'Maltepe',1
	EXEC sp_Insert_Order 73,14,'2023-07-08','2023-07-09',5,'Kadýköy',1
	EXEC sp_Insert_Order 76,17,'2023-07-09','2023-07-10',5,'Beþiktaþ',1
	EXEC sp_Insert_Order 3,17,'2023-07-10','2023-07-11',5,'Beyoðlu',1
	EXEC sp_Insert_Order 15,16,'2023-07-11','2023-07-12',5,'Altýndað',4
	EXEC sp_Insert_Order 7,17,'2023-07-12','2023-07-13',5,'Beykoz',1
	EXEC sp_Insert_Order 73,17,'2023-07-13','2023-07-14',5,'Kadýköy',1
	EXEC sp_Insert_Order 70,16,'2023-07-14','2023-07-15',5,'Merkez',19
	EXEC sp_Insert_Order 55,14,'2023-07-15','2023-07-16',5,'Merkez',65
	EXEC sp_Insert_Order 62,14,'2023-07-16','2023-07-17',5,'Lalapaþa',12
	EXEC sp_Insert_Order 3,14,'2023-07-17','2023-07-18',5,'Beyoðlu',1
	EXEC sp_Insert_Order 7,14,'2023-07-18','2023-07-19',5,'Beykoz',1
	EXEC sp_Insert_Order 76,15,'2023-07-19','2023-07-20',5,'Beþiktaþ',1
	EXEC sp_Insert_Order 84,16,'2023-07-20','2023-07-21',5,'Kartal',1
	EXEC sp_Insert_Order 94,16,'2023-07-21','2023-07-22',5,'Þile',1
	EXEC sp_Insert_Order 100,14,'2023-07-22','2023-07-23',5,'Beyoðlu',1
	EXEC sp_Insert_Order 78,17,'2023-07-23','2023-07-24',5,'Üsküdar',1
	EXEC sp_Insert_Order 28,15,'2023-07-24','2023-07-25',5,'Bozüyük',15
	EXEC sp_Insert_Order 29,15,'2023-07-25','2023-07-26',5,'Gerede',16
	EXEC sp_Insert_Order 19,14,'2023-07-26','2023-07-27',5,'Kaþ',5
	EXEC sp_Insert_Order 26,16,'2023-07-27','2023-07-28',5,'Ýncirliova',13
	EXEC sp_Insert_Order 5,16,'2023-07-28','2023-07-29',5,'Maltepe',1
	EXEC sp_Insert_Order 100,14,'2023-07-29','2023-07-30',5,'Beyoðlu',1
	EXEC sp_Insert_Order 28,16,'2023-07-30','2023-07-31',5,'Bozüyük',15
	EXEC sp_Insert_Order 76,16,'2023-07-31','2023-08-01',5,'Beþiktaþ',15

	EXEC sp_Insert_Order 76,15,'2023-08-01','2023-08-02',5,'Beþiktaþ',1
	EXEC sp_Insert_Order 19,16,'2023-08-01','2023-08-02',5,'Kaþ',5
	EXEC sp_Insert_Order 2,14,'2023-08-02','2023-08-03',5,'Ceyhan',3
	EXEC sp_Insert_Order 51,15,'2023-08-03','2023-08-04',5,'Merkez',57
	EXEC sp_Insert_Order 52,15,'2023-08-04','2023-08-05',2,'Merkez',58
	EXEC sp_Insert_Order 69,15,'2023-08-05','2023-08-06',1,'Segbroek',21
	EXEC sp_Insert_Order 7,16,'2023-08-06','2023-08-07',1,'Beykoz',1
	EXEC sp_Insert_Order 10,16,'2023-08-07','2023-08-08',1,'Çorlu',6
	EXEC sp_Insert_Order 17,15,'2023-08-08','2023-08-9',1,'Mamak',4
	EXEC sp_Insert_Order 22,15,'2023-08-9','2023-08-10',1,'Aksu',5
	EXEC sp_Insert_Order 26,15,'2023-08-10','2023-08-11',1,'Ýncirliova',13
	EXEC sp_Insert_Order 29,14,'2023-08-11','2023-08-12',1,'Gerede',16
	EXEC sp_Insert_Order 35,14,'2023-08-12','2023-08-13',1,'Le Marais',34
	EXEC sp_Insert_Order 36,14,'2023-08-13','2023-08-14',1,'Montmarte',34
	EXEC sp_Insert_Order 41,14,'2023-08-14','2023-08-15',1,'Merkez',47
	EXEC sp_Insert_Order 45,14,'2023-08-15','2023-08-16',1,'Merkez',55
	EXEC sp_Insert_Order 30,16,'2023-08-16','2023-08-17',1,'Gemlik',17
	EXEC sp_Insert_Order 32,16,'2023-08-17','2023-08-18',1,'Gemlik',17
	EXEC sp_Insert_Order 24,16,'2023-08-18','2023-08-19',1,'Çine',13
	EXEC sp_Insert_Order 1,15,'2023-08-19','2023-08-20',1,'Ceyhan',3
	EXEC sp_Insert_Order 5,15,'2023-08-20','2023-08-21',1,'Maltepe',1
	EXEC sp_Insert_Order 8,15,'2023-08-21','2023-08-22',1,'Hendek',7
	EXEC sp_Insert_Order 11,14,'2023-08-22','2023-08-23',2,'Gebze',8
	EXEC sp_Insert_Order 15,14,'2023-08-23','2023-08-24',2,'Altýndað',4
	EXEC sp_Insert_Order 18,16,'2023-08-24','2023-08-25',2,'Yenimahalle',4
	EXEC sp_Insert_Order 1,16,'2023-08-25','2023-08-26',5,'Ceyhan',3
	EXEC sp_Insert_Order 2,16,'2023-08-26','2023-08-27',5,'Ceyhan',3
	EXEC sp_Insert_Order 77,16,'2023-08-27','2023-08-28',5,'Beþiktaþ',1
	EXEC sp_Insert_Order 65,16,'2023-08-28','2023-08-29',5,'Merkez',12
	EXEC sp_Insert_Order 57,14,'2023-08-29','2023-08-30',5,'Sado',61
	EXEC sp_Insert_Order 65,14,'2023-08-30','2023-08-31',5,'Merkez',12
	EXEC sp_Insert_Order 95,15,'2023-08-31','2023-09-01',5,'Üsküdar',1

	EXEC sp_Insert_Order 22,16,'2023-09-01','2023-09-02',5,'Aksu',5
	EXEC sp_Insert_Order 40,16,'2023-09-02','2023-09-03',5,'Bozüyük',15
	EXEC sp_Insert_Order 48,15,'2023-09-03','2023-09-04',5,'Merkez',49
	EXEC sp_Insert_Order 51,15,'2023-09-04','2023-09-05',5,'Merkez',59
	EXEC sp_Insert_Order 54,15,'2023-09-05','2023-09-06',5,'Merkez',57
	EXEC sp_Insert_Order 58,15,'2023-09-06','2023-09-07',5,'Merkez',64
	EXEC sp_Insert_Order 4,15,'2023-09-07','2023-09-08',5,'Amadora',66
	EXEC sp_Insert_Order 6,14,'2023-09-08','2023-09-09',5,'Noord',19
	EXEC sp_Insert_Order 8,14,'2023-09-09','2023-09-10',5,'Kadýköy',1
	EXEC sp_Insert_Order 16,14,'2023-09-10','2023-09-11',5,'Hendek',7
	EXEC sp_Insert_Order 21,15,'2023-09-11','2023-09-12',5,'Merkez',19
	EXEC sp_Insert_Order 25,16,'2023-09-12','2023-09-13',5,'Akseki',5
	EXEC sp_Insert_Order 50,16,'2023-09-13','2023-09-14',4,'Didim',13
	EXEC sp_Insert_Order 67,16,'2023-09-14','2023-09-15',1,'Santa Maria',53
	EXEC sp_Insert_Order 70,15,'2023-09-15','2023-09-16',1,'Merkez',20
	EXEC sp_Insert_Order 72,15,'2023-09-16','2023-09-17',1,'Merkez',19
	EXEC sp_Insert_Order 74,14,'2023-09-17','2023-09-18',1,'Maltepe',1
	EXEC sp_Insert_Order 75,17,'2023-09-18','2023-09-19',1,'Ferizli',7
	EXEC sp_Insert_Order 77,17,'2023-09-19','2023-09-20',5,'Beþiktaþ',1
	EXEC sp_Insert_Order 78,17,'2023-09-20','2023-09-21',5,'Üsküdar',1
	EXEC sp_Insert_Order 80,14,'2023-09-21','2023-09-22',5,'Tuzla',1
	EXEC sp_Insert_Order 80,14,'2023-09-22','2023-09-23',5,'Tuzla',1
	EXEC sp_Insert_Order 84,14,'2023-09-23','2023-09-24',5,'Kartal',1
	EXEC sp_Insert_Order 87,16,'2023-09-24','2023-09-25',5,'Kartal',1
	EXEC sp_Insert_Order 89,17,'2023-09-25','2023-09-26',5,'Esenler',1
	EXEC sp_Insert_Order 91,16,'2023-09-26','2023-09-27',5,'Merkez',36
	EXEC sp_Insert_Order 90,16,'2023-09-27','2023-09-28',5,'Merkez',35
	EXEC sp_Insert_Order 79,15,'2023-09-28','2023-09-29',5,'Beykoz',1
	EXEC sp_Insert_Order 85,15,'2023-09-29','2023-09-30',5,'Kartal',1
	EXEC sp_Insert_Order 85,15,'2023-09-30','2023-10-01',5,'Kartal',1
	
	EXEC sp_Insert_Order 93,15,'2023-10-01','2023-09-02',5,'Þile',1
	EXEC sp_Insert_Order 94,15,'2023-10-02','2023-09-03',5,'Þile',1
	EXEC sp_Insert_Order 97,15,'2023-10-03','2023-09-04',5,'Pendik',1
	EXEC sp_Insert_Order 88,14,'2023-10-04','2023-10-05',5,'Sarýyer',1
	EXEC sp_Insert_Order 96,14,'2023-10-05','2023-10-06',5,'Esenler',1
	EXEC sp_Insert_Order 61,14,'2023-10-06','2023-10-07',5,'Merkez',63
	EXEC sp_Insert_Order 55,14,'2023-10-07','2023-10-08',5,'Merkez',65
	EXEC sp_Insert_Order 47,15,'2023-10-08','2023-10-09',5,'Merkez',57
	EXEC sp_Insert_Order 99,17,'2023-10-09','2023-10-10',1,'Kadýköy',1
	EXEC sp_Insert_Order 97,17,'2023-10-10','2023-10-11',1,'Pendik',1
	EXEC sp_Insert_Order 45,17,'2023-10-11','2023-10-12',2,'Merkez',55
	EXEC sp_Insert_Order 66,16,'2023-10-12','2023-10-13',2,'Merkez',20
	EXEC sp_Insert_Order 77,16,'2023-10-13','2023-10-14',1,'Beþiktaþ',1
	EXEC sp_Insert_Order 79,16,'2023-10-14','2023-10-15',1,'Beykoz',1
	EXEC sp_Insert_Order 81,14,'2023-10-15','2023-10-16',1,'Merkez',37
	EXEC sp_Insert_Order 83,14,'2023-10-16','2023-10-17',1,'Pendik',1
	EXEC sp_Insert_Order 87,15,'2023-10-17','2023-10-18',1,'Kartal',1
	EXEC sp_Insert_Order 56,15,'2023-10-18','2023-10-19',1,'Alfama',63
	EXEC sp_Insert_Order 70,15,'2023-10-19','2023-10-20',1,'Merkez',19
	EXEC sp_Insert_Order 48,15,'2023-10-20','2023-10-21',1,'Merkez',59
	EXEC sp_Insert_Order 11,14,'2023-10-21','2023-10-22',1,'Gebze',8
	EXEC sp_Insert_Order 12,17,'2023-10-22','2023-10-23',5,'Bornova',9
	EXEC sp_Insert_Order 15,16,'2023-10-23','2023-10-24',5,'Altýndað',4
	EXEC sp_Insert_Order 17,16,'2023-10-24','2023-10-25',5,'Mamak',4
	EXEC sp_Insert_Order 18,17,'2023-10-25','2023-10-26',5,'Yenimahalle',4
	EXEC sp_Insert_Order 19,17,'2023-10-26','2023-10-27',5,'Kaþ',5
	EXEC sp_Insert_Order 20,17,'2023-10-27','2023-10-28',5,'Karatay',2
	EXEC sp_Insert_Order 27,17,'2023-10-28','2023-10-29',5,'Ayvalýk',14
	EXEC sp_Insert_Order 36,17,'2023-10-29','2023-10-30',5,'Montmarte',34
	EXEC sp_Insert_Order 38,15,'2023-10-30','2023-10-31',5,'Ukkel',46
	EXEC sp_Insert_Order 40,14,'2023-10-31','2023-11-01',5,'Merkez',49
	EXEC sp_Insert_Order 41,14,'2023-11-01','2023-11-02',5,'Merkez',47
	EXEC sp_Insert_Order 44,17,'2023-11-02','2023-11-03',2,'Merkez',51

	SELECT * FROM ORDERS

	CREATE PROC sp_Insert_Order_Detail @orderID int, @productID smallint, @qty smallint
	AS 
	BEGIN
		INSERT INTO [ORDER DETAILS] (OrderID,ProductID,Quantity) VALUES (@orderID,@productID,@qty)
	END

	EXEC sp_Insert_Order_Detail 1,1,15
	EXEC sp_Insert_Order_Detail 1,10,5
	EXEC sp_Insert_Order_Detail 1,7,10
	EXEC sp_Insert_Order_Detail 2,8,10
	EXEC sp_Insert_Order_Detail 2,11,10
	EXEC sp_Insert_Order_Detail 3,3,5
	EXEC sp_Insert_Order_Detail 3,9,10
	EXEC sp_Insert_Order_Detail 3,15,5
	EXEC sp_Insert_Order_Detail 4,20,10
	EXEC sp_Insert_Order_Detail 4,12,20
	EXEC sp_Insert_Order_Detail 5,4,10
	EXEC sp_Insert_Order_Detail 5,6,15
	EXEC sp_Insert_Order_Detail 5,7,20
	EXEC sp_Insert_Order_Detail 5,5,10
	EXEC sp_Insert_Order_Detail 5,15,5
	EXEC sp_Insert_Order_Detail 6,17,5
	EXEC sp_Insert_Order_Detail 6,18,10
	EXEC sp_Insert_Order_Detail 6,19,5
	EXEC sp_Insert_Order_Detail 6,16,10
	EXEC sp_Insert_Order_Detail 7,8,20
	EXEC sp_Insert_Order_Detail 7,9,20
	EXEC sp_Insert_Order_Detail 8,1,10
	EXEC sp_Insert_Order_Detail 8,3,20
	EXEC sp_Insert_Order_Detail 8,6,30
	EXEC sp_Insert_Order_Detail 8,7,40
	EXEC sp_Insert_Order_Detail 9,2,50
	EXEC sp_Insert_Order_Detail 9,5,60
	EXEC sp_Insert_Order_Detail 9,7,70
	EXEC sp_Insert_Order_Detail 10,9,10
	EXEC sp_Insert_Order_Detail 10,8,20
	EXEC sp_Insert_Order_Detail 11,18,30
	EXEC sp_Insert_Order_Detail 12,5,40
	EXEC sp_Insert_Order_Detail 13,7,50
	EXEC sp_Insert_Order_Detail 14,8,60
	EXEC sp_Insert_Order_Detail 14,9,20
	EXEC sp_Insert_Order_Detail 15,3,30
	EXEC sp_Insert_Order_Detail 15,5,40
	EXEC sp_Insert_Order_Detail 16,5,20
	EXEC sp_Insert_Order_Detail 17,11,20
	EXEC sp_Insert_Order_Detail 17,13,20
	EXEC sp_Insert_Order_Detail 18,1,20
	EXEC sp_Insert_Order_Detail 18,2,20
	EXEC sp_Insert_Order_Detail 19,4,20
	EXEC sp_Insert_Order_Detail 20,5,20
	EXEC sp_Insert_Order_Detail 21,3,20
	EXEC sp_Insert_Order_Detail 22,7,20
	EXEC sp_Insert_Order_Detail 23,11,20
	EXEC sp_Insert_Order_Detail 24,15,20
	EXEC sp_Insert_Order_Detail 25,19,20
	EXEC sp_Insert_Order_Detail 26,1,20
	EXEC sp_Insert_Order_Detail 27,2,20
	EXEC sp_Insert_Order_Detail 28,5,20
	EXEC sp_Insert_Order_Detail 28,8,20
	EXEC sp_Insert_Order_Detail 29,9,20
	EXEC sp_Insert_Order_Detail 30,10,20
	EXEC sp_Insert_Order_Detail 30,11,15
	EXEC sp_Insert_Order_Detail 30,12,20
	EXEC sp_Insert_Order_Detail 30,13,25
	EXEC sp_Insert_Order_Detail 31,12,30
	EXEC sp_Insert_Order_Detail 31,15,35
	EXEC sp_Insert_Order_Detail 31,14,40
	EXEC sp_Insert_Order_Detail 32,14,45
	EXEC sp_Insert_Order_Detail 33,18,50
	EXEC sp_Insert_Order_Detail 34,17,55
	EXEC sp_Insert_Order_Detail 35,12,60
	EXEC sp_Insert_Order_Detail 36,9,65
	EXEC sp_Insert_Order_Detail 37,8,70
	EXEC sp_Insert_Order_Detail 38,7,75
	EXEC sp_Insert_Order_Detail 39,6,80
	EXEC sp_Insert_Order_Detail 40,11,85
	EXEC sp_Insert_Order_Detail 41,9,90
	EXEC sp_Insert_Order_Detail 41,16,95
	EXEC sp_Insert_Order_Detail 42,16,100
	EXEC sp_Insert_Order_Detail 42,14,105
	EXEC sp_Insert_Order_Detail 43,13,110
	EXEC sp_Insert_Order_Detail 44,12,115
	EXEC sp_Insert_Order_Detail 44,10,120
	EXEC sp_Insert_Order_Detail 44,3,10
	EXEC sp_Insert_Order_Detail 44,5,20
	EXEC sp_Insert_Order_Detail 45,5,30
	EXEC sp_Insert_Order_Detail 45,6,5
	EXEC sp_Insert_Order_Detail 46,7,10
	EXEC sp_Insert_Order_Detail 47,9,15
	EXEC sp_Insert_Order_Detail 48,9,20
	EXEC sp_Insert_Order_Detail 49,9,25
	EXEC sp_Insert_Order_Detail 50,5,30
	EXEC sp_Insert_Order_Detail 51,3,35
	EXEC sp_Insert_Order_Detail 51,11,40
	EXEC sp_Insert_Order_Detail 52,16,45
	EXEC sp_Insert_Order_Detail 52,17,50
	EXEC sp_Insert_Order_Detail 53,18,55
	EXEC sp_Insert_Order_Detail 53,20,60
	EXEC sp_Insert_Order_Detail 53,15,65
	EXEC sp_Insert_Order_Detail 54,3,70
	EXEC sp_Insert_Order_Detail 55,5,75
	EXEC sp_Insert_Order_Detail 56,7,80
	EXEC sp_Insert_Order_Detail 57,1,85
	EXEC sp_Insert_Order_Detail 58,3,90
	EXEC sp_Insert_Order_Detail 59,4,95
	EXEC sp_Insert_Order_Detail 60,6,100
	EXEC sp_Insert_Order_Detail 61,9,5
	EXEC sp_Insert_Order_Detail 62,7,5
	EXEC sp_Insert_Order_Detail 62,13,5
	EXEC sp_Insert_Order_Detail 63,11,5
	EXEC sp_Insert_Order_Detail 64,14,5
	EXEC sp_Insert_Order_Detail 65,9,5
	EXEC sp_Insert_Order_Detail 66,20,5
	EXEC sp_Insert_Order_Detail 67,16,5
	EXEC sp_Insert_Order_Detail 68,13,5
	EXEC sp_Insert_Order_Detail 69,14,5
	EXEC sp_Insert_Order_Detail 70,15,5
	EXEC sp_Insert_Order_Detail 71,17,5
	EXEC sp_Insert_Order_Detail 71,18,10
	EXEC sp_Insert_Order_Detail 72,19,10
	EXEC sp_Insert_Order_Detail 72,20,15
	EXEC sp_Insert_Order_Detail 73,18,15
	EXEC sp_Insert_Order_Detail 73,19,15
	EXEC sp_Insert_Order_Detail 74,8,20
	EXEC sp_Insert_Order_Detail 75,7,150
	EXEC sp_Insert_Order_Detail 75,5,15
	EXEC sp_Insert_Order_Detail 75,6,50
	EXEC sp_Insert_Order_Detail 75,11,25
	EXEC sp_Insert_Order_Detail 75,12,30
	EXEC sp_Insert_Order_Detail 75,15,45
	EXEC sp_Insert_Order_Detail 76,7,50
	EXEC sp_Insert_Order_Detail 76,6,100
	EXEC sp_Insert_Order_Detail 76,3,20
	EXEC sp_Insert_Order_Detail 77,4,50
	EXEC sp_Insert_Order_Detail 78,6,30
	EXEC sp_Insert_Order_Detail 79,1,50
	EXEC sp_Insert_Order_Detail 80,3,10
	EXEC sp_Insert_Order_Detail 80,4,20
	EXEC sp_Insert_Order_Detail 81,7,20
	EXEC sp_Insert_Order_Detail 82,17,30
	EXEC sp_Insert_Order_Detail 82,16,35
	EXEC sp_Insert_Order_Detail 83,14,40
	EXEC sp_Insert_Order_Detail 84,10,40
	EXEC sp_Insert_Order_Detail 85,9,10
	EXEC sp_Insert_Order_Detail 86,9,15
	EXEC sp_Insert_Order_Detail 87,8,20
	EXEC sp_Insert_Order_Detail 88,7,25
	EXEC sp_Insert_Order_Detail 89,7,30
	EXEC sp_Insert_Order_Detail 90,7,35
	EXEC sp_Insert_Order_Detail 90,6,60
	EXEC sp_Insert_Order_Detail 91,14,20
	EXEC sp_Insert_Order_Detail 91,16,20
	EXEC sp_Insert_Order_Detail 92,8,20
	EXEC sp_Insert_Order_Detail 93,1,20
	EXEC sp_Insert_Order_Detail 94,7,40
	EXEC sp_Insert_Order_Detail 95,3,10
	EXEC sp_Insert_Order_Detail 96,6,5
	EXEC sp_Insert_Order_Detail 97,5,15
	EXEC sp_Insert_Order_Detail 98,5,20
	EXEC sp_Insert_Order_Detail 99,5,20
	EXEC sp_Insert_Order_Detail 100,5,20
	EXEC sp_Insert_Order_Detail 101,10,10
	EXEC sp_Insert_Order_Detail 102,10,10
	EXEC sp_Insert_Order_Detail 103,10,10
	EXEC sp_Insert_Order_Detail 104,9,10
	EXEC sp_Insert_Order_Detail 105,8,10
	EXEC sp_Insert_Order_Detail 106,11,10
	EXEC sp_Insert_Order_Detail 107,13,15
	EXEC sp_Insert_Order_Detail 107,15,15
	EXEC sp_Insert_Order_Detail 108,1,20
	EXEC sp_Insert_Order_Detail 109,3,20
	EXEC sp_Insert_Order_Detail 110,5,15
	EXEC sp_Insert_Order_Detail 110,7,25
	EXEC sp_Insert_Order_Detail 110,10,35
	EXEC sp_Insert_Order_Detail 110,11,45
	EXEC sp_Insert_Order_Detail 111,7,55
	EXEC sp_Insert_Order_Detail 111,8,65
	EXEC sp_Insert_Order_Detail 111,9,75
	EXEC sp_Insert_Order_Detail 112,1,85
	EXEC sp_Insert_Order_Detail 113,3,95
	EXEC sp_Insert_Order_Detail 114,5,100
	EXEC sp_Insert_Order_Detail 115,7,20
	EXEC sp_Insert_Order_Detail 115,9,35
	EXEC sp_Insert_Order_Detail 115,11,20
	EXEC sp_Insert_Order_Detail 115,13,10
	EXEC sp_Insert_Order_Detail 115,15,20
	EXEC sp_Insert_Order_Detail 116,2,20
	EXEC sp_Insert_Order_Detail 116,3,20
	EXEC sp_Insert_Order_Detail 117,5,20
	EXEC sp_Insert_Order_Detail 118,5,30
	EXEC sp_Insert_Order_Detail 119,7,30
	EXEC sp_Insert_Order_Detail 119,6,30
	EXEC sp_Insert_Order_Detail 120,4,30
	EXEC sp_Insert_Order_Detail 121,6,30
	EXEC sp_Insert_Order_Detail 121,5,35
	EXEC sp_Insert_Order_Detail 122,1,40
	EXEC sp_Insert_Order_Detail 123,3,40
	EXEC sp_Insert_Order_Detail 123,7,40
	EXEC sp_Insert_Order_Detail 123,8,40
	EXEC sp_Insert_Order_Detail 123,9,40
	EXEC sp_Insert_Order_Detail 124,10,40
	EXEC sp_Insert_Order_Detail 124,11,40
	EXEC sp_Insert_Order_Detail 124,12,40
	EXEC sp_Insert_Order_Detail 125,6,40
	EXEC sp_Insert_Order_Detail 125,7,40
	EXEC sp_Insert_Order_Detail 125,8,40
	EXEC sp_Insert_Order_Detail 126,20,10
	EXEC sp_Insert_Order_Detail 126,18,5

	SELECT * FROM [ORDER DETAILS]




















