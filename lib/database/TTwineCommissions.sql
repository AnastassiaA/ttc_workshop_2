--
-- File generated with SQLiteStudio v3.2.1 on Wed Jul 14 02:35:26 2021
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: Crochet Hooks
CREATE TABLE "Crochet Hooks" ("Hook Size" REAL PRIMARY KEY NOT NULL, Image BLOB, "Material Type" VARCHAR, "Orders Used On" INTEGER REFERENCES Orders);

-- Table: Crochet Thread
CREATE TABLE "Crochet Thread" (Colour STRING);

-- Table: Expenses
CREATE TABLE Expenses (ExpenseID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ON CONFLICT ROLLBACK UNIQUE ON CONFLICT ROLLBACK, "Expense Name" STRING NOT NULL, Date DATE NOT NULL ON CONFLICT ROLLBACK, Type STRING, Amount STRING, Price REAL NOT NULL);
INSERT INTO Expenses (ExpenseID, "Expense Name", Date, Type, Amount, Price) VALUES (1, 'Black Yarn', '2021-11-27', 'Yarn', 2, 1386.0);
INSERT INTO Expenses (ExpenseID, "Expense Name", Date, Type, Amount, Price) VALUES (2, 'Press Studs', '2017-03-29', 'Accessories', 6, 175.0);
INSERT INTO Expenses (ExpenseID, "Expense Name", Date, Type, Amount, Price) VALUES (3, 'Silver Rings', '2018-04-06', 'Accessories', 2, 100.0);
INSERT INTO Expenses (ExpenseID, "Expense Name", Date, Type, Amount, Price) VALUES (4, 'Silver Buckle', '2018-04-19', 'Accessories', 1, 180.0);
INSERT INTO Expenses (ExpenseID, "Expense Name", Date, Type, Amount, Price) VALUES (5, 'Leather', '2018-05-11', 'Fabric', '? yards', 88.0);
INSERT INTO Expenses (ExpenseID, "Expense Name", Date, Type, Amount, Price) VALUES (6, 'Black Crochet Thread', '2019-05-11', 'Crochet Thread', 1, 401.87);

-- Table: Knitting Needles
CREATE TABLE "Knitting Needles" ("Needle Size" REAL PRIMARY KEY, "");

-- Table: Orders
CREATE TABLE Orders ("Order Number" INTEGER UNIQUE ON CONFLICT ROLLBACK NOT NULL ON CONFLICT ROLLBACK PRIMARY KEY ASC ON CONFLICT ROLLBACK AUTOINCREMENT, "Order Name" STRING NOT NULL, Image BLOB, Description TEXT, Status STRING, "Customer Contact" VARCHAR NOT NULL, "Crochet Hook" REAL REFERENCES "Crochet Hooks" ("Hook Size"), "Knitting Needle" REAL REFERENCES "Knitting Needles" ("Needle Size"), Yarn REFERENCES Yarn (Colour) UNIQUE, Expense STRING REFERENCES Expenses ("Expense Name"), "Expense Price" REAL NOT NULL REFERENCES Expenses (Price), "Start Date" DATETIME, "End Date" DATETIME);

-- Table: Product Catalogue
CREATE TABLE "Product Catalogue" (Image BLOB, ID INT (10) PRIMARY KEY, Name VARCHAR (40), "Craft Type" VARCHAR (10), Price REAL (8));

-- Table: Yarn
CREATE TABLE Yarn (Colour STRING PRIMARY KEY UNIQUE, Brand STRING, Weight REAL, "Unit Price" REAL, "Used in" STRING REFERENCES Orders ("Order Name"));

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
