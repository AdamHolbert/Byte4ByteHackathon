use Hackathon
go

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='OrderItems') 
begin
drop table dbo.OrderItems
END
go

IF (EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='PantryCoordinator') )
begin
drop table dbo.PantryCoordinator
END
go

IF (EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='FoodPantryStock') )
begin
drop table dbo.FoodPantryStock
END
go

IF (EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='FoodKit') )
begin
drop table dbo.FoodKit
END
go

IF (EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='RequestedItems') )
begin
drop table dbo.RequestedItems
END
go

IF (EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='items'))
begin
drop table dbo.items
END
go

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='foodpantry') 
begin
drop table dbo.foodpantry
END
go

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Orders') 
begin
drop table dbo.Orders
END
go

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='family') 
begin
drop table dbo.family
END
Go

IF (EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='itemtypes') )
begin
drop table dbo.itemtypes
END
go


CREATE TABLE dbo.ItemTypes(
                ID INT primary key  IDENTITY(1,1) NOT NULL,
                Type VARCHAR(15) NOT NULL,
                Description VARCHAR(500) NOT NULL
);
GO
CREATE TABLE dbo.Items(
                ID INT primary key  IDENTITY(1,1) NOT NULL,
                Price DECIMAL(15,2) NULL,
                Name VARCHAR(500) NOT NULL,
                TypeID INT NULL CONSTRAINT [FK_itemstypeid] FOREIGN KEY REFERENCES dbo.ItemTypes(ID),
				pointValue INT not null
);
go	
CREATE TABLE dbo.FoodPantry(
                ID INT primary key  IDENTITY(1,1) NOT NULL,
                Location VARCHAR(50) NOT NULL,
				Name varchar(50) not null	,
				URL varchar(250) null
                --OpenHour TIME NOT NULL,
                --CloseHour TIME NOT NULL,
                --OpenMonday BIT NOT NULL,
                --OpenTuesday BIT NOT NULL,
                --OpenWednesday BIT NOT NULL,
                --OpenThursday BIT NOT NULL,
                --OpenFriday BIT NOT NULL,
                --OpenSaturday BIT NOT NULL,
                --OpenSunday BIT NOT null
)       ;      
go	
CREATE TABLE dbo.Family(
                ID INT primary key IDENTITY(1,1) NOT NULL,
                FamilySize INT NOT NULL,
                ChildrenHaveCheckoutConsent BIT NOT NULL default 0,--this is probably per child
                FamilyID VARCHAR(50) NOT NULL UNIQUE,
				MaxPointTotal int not null
);
go	 
CREATE TABLE dbo.Orders(
                ID INT primary key  IDENTITY(1,1) NOT NULL,
                FamilyID INT NOT NULL CONSTRAINT FK_ordersfamilyid FOREIGN KEY REFERENCES dbo.Family(ID),
                OrderDate DATETIME NOT NULL,
				--TotalItems int not null,
				PointTotal int not null
);
go
CREATE TABLE dbo.OrderItems(
                ID INT primary key  IDENTITY(1,1) NOT NULL,
                OrderID INT CONSTRAINT FK_OrderItemsOrderID FOREIGN KEY REFERENCES dbo.Orders(ID),
                ItemID INT CONSTRAINT FK_OrderItemsItemID FOREIGN KEY REFERENCES dbo.Items(ID),
                Quantity INT NOT NULL
);
go
CREATE TABLE dbo.PantryCoordinator(
                ID INT primary key  IDENTITY(1,1) NOT NULL,
                UserName VARCHAR(50) NOT NULL,
                Password varchar(50) NOT NULL, -- this would need to be secure.
                FoodPantryID int NOT NULL CONSTRAINT FK_PantryCoordinatorFoodPantryID FOREIGN KEY REFERENCES dbo.FoodPantry(ID),
				IsAdministrator bit not null default 0
);
go
create table dbo.FoodPantryStock(
	ID int primary key  identity(1,1) not null,
	FoodPantryID int not null CONSTRAINT FK_FoodPantryStockFoodPantryID FOREIGN KEY REFERENCES dbo.FoodPantry(ID), --FK
	ItemID int not null CONSTRAINT FK_FoodPantryStockItemID FOREIGN KEY REFERENCES dbo.Items(ID), --FK
	Quantity int not null,
);
go
create table dbo.FoodKit(
	ID int primary key  identity(1,1) not null,
	Amount int not null,
	Discription varchar(255) not null,
	ImageURL varchar(50) null
);
go
create table dbo.RequestedItems(
	ID int primary key  identity(1,1) not null,
	FoodPantryID int not null CONSTRAINT FK_RequestItemsFoodPantryID FOREIGN KEY REFERENCES dbo.FoodPantry(ID),
	ItemID int not null CONSTRAINT FK_RequestItemsItemID FOREIGN KEY REFERENCES dbo.Items(ID),
	Quantity int not null,
	FulfillByDate Datetime null
);
GO

--do these tables need to be stored for any purpose? the bank account holder will be able to login to see this elsewhere
--track donations by user/company to allow for friendly competition as well as tracking for numerous purposes
--CREATE TABLE ADAMDUMMYSTUFF.Donations(
--             ID INT IDENTITY(1,1) NOT NULL,
--             Amount DECIMAL(30,2) NOT NULL,
--             --Note VARCHAR(MAX) NULL, for future automated emaul or thank you of some type
--)
--CREATE TABLE ADAMDUMMYSTUFF.Balance(
--             ID INT IDENTITY(1,1) NOT NULL,
--             Total DECIMAL(30,2) NOT NULL
--)

INSERT INTO Items(Name, Price, pointValue)
Values ('Big Mac', 3.99, Floor(Rand()*(9)) + 1),
('Big Mac – Meal', 5.99, Floor(Rand()*(9)) + 1),
('2 Cheeseburgers', 2.00, Floor(Rand()*(9)) + 1),
('2 Cheeseburgers – Meal', 4.89, Floor(Rand()*(9)) + 1),
('Quarter Pounder with Cheese', 3.79, Floor(Rand()*(9)) + 1),
('Quarter Pounder with Cheese – Meal', 5.79, Floor(Rand()*(9)) + 1),
('Double Quarter Pounder with Cheese', 4.79, Floor(Rand()*(9)) + 1),
('Double Quarter Pounder with Cheese – Meal', 6.69, Floor(Rand()*(9)) + 1),
('Bacon Clubhouse Burger', 4.49, Floor(Rand()*(9)) + 1),
('Bacon Clubhouse Burger – Meal', 6.49, Floor(Rand()*(9)) + 1),
('Buttermilk Crispy Chicken', 4.39, Floor(Rand()*(9)) + 1),
('Buttermilk Crispy Chicken – Meal', 6.39, Floor(Rand()*(9)) + 1),
('Artisan Grilled Chicken', 4.39, Floor(Rand()*(9)) + 1),
('Artisan Grilled Chicken – Meal', 6.39, Floor(Rand()*(9)) + 1),
('Premium McWrap Chicken & Bacon (Grilled or Crispy)', 4.39, Floor(Rand()*(9)) + 1),
('Premium McWrap Chicken & Bacon (Grilled or Crispy) – Meal', 6.39, Floor(Rand()*(9)) + 1),
('Premium McWrap Chicken & Ranch (Grilled or Crispy)', 4.39, Floor(Rand()*(9)) + 1),
('Premium McWrap Chicken & Ranch (Grilled or Crispy) – Meal', 6.39, Floor(Rand()*(9)) + 1),
('Premium McWrap Sweet Chili Chicken (Grilled or Crispy)', 4.39, Floor(Rand()*(9)) + 1),
('Premium McWrap Sweet Chili Chicken (Grilled or Crispy) – Meal', 6.39, Floor(Rand()*(9)) + 1),
('Filet-O-Fish', 3.79, Floor(Rand()*(9)) + 1),
('Filet-O-Fish – Meal', 5.79, Floor(Rand()*(9)) + 1),
('Double Filet-O-Fish', 4.79, Floor(Rand()*(9)) + 1),
('Double Filet-O-Fish – Meal', 6.79, Floor(Rand()*(9)) + 1),
('Premium Chicken Bacon Clubhouse (Grilled or Crispy)', 4.49, Floor(Rand()*(9)) + 1)

--item types

--food pantry
INSERT INTO FoodPantry (Location, Name)
Values ('FerdinandLynelle', 'Ferdinand'),
('TimothySandra', 'Timothy'),
('NoelAntonia', 'Noel'),
('NatachaAnna', 'Natacha'),
('PhilKevin', 'Phil'),
('JerrodBetty', 'Jerrod'),
('AbeYolonda', 'Abe'),
('ReynaMyong', 'Reyna'),
('TraceySamual', 'Tracey'),
('ManualSiobhan', 'Manual'),
('JuanJenifer', 'Juan'),
('AnnamariaLucy', 'Annamaria'),
('OssieJordan', 'Ossie'),
('ThersaTerra', 'Thersa'),
('MayraLudie', 'Mayra'),
('ElnaShenna', 'Elna'),
('CharlineDelia', 'Charline'),
('HortensiaAshleigh', 'Hortensia'),
('TeishaLoyce', 'Teisha'),
('MarikoArnette', 'Mariko'),
('EmelineDalila', 'Emeline'),
('WayneBryant', 'Wayne'),
('CoreyZola', 'Corey'),
('TerrellSaran', 'Terrell'),
('PilarBrad', 'Pilar')

--family
INSERT INTO Family(FamilyID, FamilySize, MaxPointTotal)
Values (FLOOR(RAND()*65025), FLOOR(RAND()*(8)+1), FLOOR(RAND()*(50)+50)),
(FLOOR(RAND()*65025), FLOOR(RAND()*(8)+1), FLOOR(RAND()*(50)+50)),
(FLOOR(RAND()*65025), FLOOR(RAND()*(8)+1), FLOOR(RAND()*(50)+50)),
(FLOOR(RAND()*65025), FLOOR(RAND()*(8)+1), FLOOR(RAND()*(50)+50)),
(FLOOR(RAND()*65025), FLOOR(RAND()*(8)+1), FLOOR(RAND()*(50)+50)),
(FLOOR(RAND()*65025), FLOOR(RAND()*(8)+1), FLOOR(RAND()*(50)+50)),
(FLOOR(RAND()*65025), FLOOR(RAND()*(8)+1), FLOOR(RAND()*(50)+50)),
(FLOOR(RAND()*65025), FLOOR(RAND()*(8)+1), FLOOR(RAND()*(50)+50)),
(FLOOR(RAND()*65025), FLOOR(RAND()*(8)+1), FLOOR(RAND()*(50)+50)),
(FLOOR(RAND()*65025), FLOOR(RAND()*(8)+1), FLOOR(RAND()*(50)+50)),
(FLOOR(RAND()*65025), FLOOR(RAND()*(8)+1), FLOOR(RAND()*(50)+50)),
(FLOOR(RAND()*65025), FLOOR(RAND()*(8)+1), FLOOR(RAND()*(50)+50)),
(FLOOR(RAND()*65025), FLOOR(RAND()*(8)+1), FLOOR(RAND()*(50)+50)),
(FLOOR(RAND()*65025), FLOOR(RAND()*(8)+1), FLOOR(RAND()*(50)+50))
--orders

INSERT INTO Orders(FamilyID, OrderDate, PointTotal)
(SELECT ID, DATEADD(day, (ABS(CHECKSUM(NEWID())) % 65530), 0), Floor(RAND() * 50) + 50
FROM dbo.Family)

--order items
INSERT INTO OrderItems(ItemID, OrderID, Quantity)
SELECT (ABS(CHECKSUM(NEWID())%25)+1), ID, ABS((CHECKSUM(NEWID())%20)) + 1
FROM dbo.Orders

--pantry coordinator
--xfood pantry stock
INSERT INTO FoodPantryStock(FoodPantryID, ItemID, Quantity)
SELECT 1, (ABS(CHECKSUM(NEWID())%25)+1), ABS((CHECKSUM(NEWID())%20)) + 1

--food kit
--requesteditems

update FoodPantryStock
set ItemID = 5
where ID = 9
