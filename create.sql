-- Nigel Isaiah Paliath
-- Product, PO_Line Items, IS_Line Items, Product_Has_Handling_Requirements, Handling_Requirements
-- Chew Jun Yang
-- Warehouse personnel, Employee, Driver, Vehicle, Employee_has_Certification, CERTIFICATIONS

-- Charles Lee Jun Ngai
-- Delivery Route, Stop, Customer, Customer Order,
-- WAREHOUSE_PICKUP_STOP
-- Murugavel Girija
-- Warehouse, Storage Zone, Storage location, Inventory, WAREHOUSE_HAS_TEMPERATURE_CONTROL_CAPABILITIES

-- Lim Wei Jie Nigel
-- Client, Supply, Countries, Client-Warehouse Storage Contract, TEMPERATURE_CONTROL_CAPABILITIES

-- Lim Kim Leng Jeanie
-- Purchase order, Supplier, Inbound Shipments, CLIENT_CONSOLIDATES_PURCHASE_ORDER

-- Chia Jia Yuun
-- CO_Line Items, Outbound Shipments, Inventory Movement, CLIENT_OPERATES_IN_COUNTRY

-- Foreign_Key_Table(attr)
-- Primary_Key_Table(attr)
-- Value1
-- Value2
-- PRODUCT(ClientID)
-- CLIENT(ClientID)
-- C1001 - C1010
-- DELIVERY_ROUTE(EmployeeID)
-- EMPLOYEE(EmployeeID)
-- DELIVERY_ROUTE(VehicleID)
-- VEHICLE(VehicleID)
-- WAREHOUSE_PICKUP_STOP(WarehouseCode)
-- WAREHOUSE(WarehouseCode)
-- PO_LINE_ITEMS(PONumber)
-- PURCHASE_ORDER(PONumber)
-- PO101- PO110
-- IS_LINE_ITEMS(ShipmentID)
-- INBOUND_SHIPMENTS(InboundShipmentID)
-- IS101- IS110
-- CO_LINE_ITEMS
-- CO_LINE_ITEMS(Outbound_Shipment_ID)
-- OS104 - OS110
-- CO_LINE_ITEMS(Item_ID)
-- I900-I915
-- PURCHASE_ORDER(WarehouseCode)
-- WAREHOUSE(WarehouseCode)
-- SUPPLIERS (PONumber)
-- PURCHASE_ORDER(PONumber)
-- PO101- PO110
-- SUPPLIERS (CountryName)
-- COUNTRIES(Name)
-- INBOUND_SHIPMENTS(PONumber)
-- PURCHASE_ORDER(PONumber)
-- PO101- PO110
-- INBOUND_SHIPMENTS(SupplierID)
-- SUPPLIERS(SupplierID)
-- S001 - S004
-- INBOUND_SHIPMENTS(OriginLocation)
-- COUNTRIES(Name)
-- INBOUND_SHIPMENTS(WarehouseCode)
-- WAREHOUSE(WarehouseCode)
-- R1_OUTBOUND_SHIPMENTS(Shipment_ID)
-- Shipment_ID
-- OS104 - OS110
-- R1_OUTBOUND_SHIPMENTS(Route_ID)
-- ROU1 - ROU10
-- R2_OUTBOUND_SHIPMENTS

-- R2_INBOUND_SHIPMENTS(PONumber)
-- PURCHASE_ORDER(PONumber)
-- PO101- PO110
-- CLIENT_CONSOLIDATES_PURCHASE_ORDER(ClientID)
-- CLIENT(ClientID)
-- CLIENT_CONSOLIDATES_PURCHASE_ORDER(PONumber)
-- PURCHASE_ORDER(PONumber)
-- PO101- PO110

-- Implementation of database schema
-- Main Entities
-- COUNTRIES
-- CLIENT
-- PRODUCT
-- PRODUCT_HAS_HANDLING_REQUIREMENTS
-- HANDLING_REQUIREMENTS
-- CUSTOMER
-- CERTIFICATIONS
-- Employee & Transport
-- EMPLOYEE
-- EMPLOYEE_HAS_CERTIFICATIONS
-- DRIVER
-- VEHICLE
-- WAREHOUSE_PERSONNEL
-- Warehouse & Storage
-- WAREHOUSE
-- WAREHOUSE_HAS_TEMPERATURE_CONTROL_CAPABILITIES
-- TEMPERATURE_CONTROL_CAPABILITIES
-- STORAGE_ZONE
-- STORAGE_LOCATION
-- INVENTORY
-- INVENTORY_MOVEMENT

-- Supplier & Shipments
-- SUPPLIERS
-- PURCHASE_ORDER
-- PO_LINE_ITEMS
-- INBOUND_SHIPMENTS
-- IS_LINE_ITEMS

-- Customer Fulfillment
-- CUSTOMER_ORDER
-- DELIVERY_ROUTE
-- STOP
-- WAREHOUSE_PICKUP_CUSTOMER_ORDER
-- OUTBOUND_SHIPMENTS
-- CO_LINE_ITEMS

-- Supporting Relationships
-- CLIENT_CONSOLIDATES_PURCHASE_ORDER
-- CLIENT_OPERATES_IN_COUNTRY
-- SUPPLY
-- CLIENT_WAREHOUSE_STORAGE_CONTRACT
-- SUPPLIERS_GENERATES_PURCHASE_ORDERS

-- CERTIFICATIONS

CREATE TABLE CERTIFICATIONS (
    CertificateID VARCHAR(10) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    CONSTRAINT PK_CERTIFICATIONS PRIMARY KEY (CertificateID)
);

INSERT INTO CERTIFICATIONS (CertificateID, Name) VALUES
('CERT001', 'Forklift Operator'),
('CERT002', 'Hazmat Handling'),
('CERT003', 'CDL Class A'),
('CERT004', 'CDL Class B'),
('CERT005', 'Warehouse Safety'),
('CERT006', 'Cold Chain Handling');

SELECT * FROM CERTIFICATIONS;



EMPLOYEE

-- INVENTORY_MOVEMENT

CREATE TABLE INVENTORY_MOVEMENT (
    MovementId VARCHAR(10) NOT NULL,
    Productid VARCHAR(10) NOT NULL,
    Clientid VARCHAR(10) NOT NULL,
    LocationCode VARCHAR(50) NOT NULL,
    Zone_ID INT NOT NULL,
    WarehouseCode VARCHAR(50) NOT NULL,
    Quantity INT NOT NULL,
    Timestamp DATETIME NOT NULL,
    Movement_Type VARCHAR(50) NOT NULL,
    Reason VARCHAR(255),

    CONSTRAINT PK_InventoryMovement PRIMARY KEY (MovementId, Productid, Clientid, LocationCode, Zone_ID, WarehouseCode)
);

INSERT INTO INVENTORY_MOVEMENT
(MovementId, ProductId, Clientid, LocationCode, Zone_ID, WarehouseCode, Quantity, Timestamp, Movement_Type, Reason)
VALUES
('M001', 'P101', 'C001', 'LOC-A', 1, 'WH1', 50, '2026-04-01 08:00:00', 'IN', 'Restock'),
('M001', 'P102', 'C002', 'LOC-B', 2, 'WH1', 20, '2026-04-01 09:00:00', 'OUT', 'Customer Order'),
('M001', 'P101', 'C001', 'LOC-A', 2, 'WH1', 10, '2026-04-01 10:00:00', 'OUT', 'Damaged Goods'),
('M002', 'P103', 'C003', 'LOC-C', 3, 'WH2', 70, '2026-04-01 11:00:00', 'IN', 'Supplier Delivery'),
('M002', 'P104', 'C001', 'LOC-D', 1, 'WH2', 15, '2026-04-01 12:00:00', 'OUT', 'Customer Order'),
('M002', 'P105', 'C002', 'LOC-E', 1, 'WH3', 100, '2026-04-01 13:00:00', 'IN', 'Bulk Restock'),
('M003', 'P101', 'C001', 'LOC-A', 1, 'WH1', 5, '2026-04-01 14:00:00', 'OUT', 'Sample Use'),
('M003', 'P102', 'C002', 'LOC-B', 2, 'WH1', 30, '2026-04-01 15:00:00', 'IN', 'Return'),
('M003', 'P103', 'C003', 'LOC-C', 3, 'WH2', 25, '2026-04-01 16:00:00', 'OUT', 'Transfer'),
('M003', 'P104', 'C001', 'LOC-D', 2, 'WH2', 40, '2026-04-01 17:00:00', 'IN', 'Adjustment'),
('M004', 'P105', 'C002', 'LOC-E', 1, 'WH3', 60, '2026-04-02 08:30:00', 'OUT', 'Customer Order'),
('M004', 'P106', 'C001', 'LOC-F', 2, 'WH3', 80, '2026-04-02 09:00:00', 'IN', 'Supplier Delivery'),
('M004', 'P107', 'C002', 'LOC-G', 1, 'WH4', 25, '2026-04-02 09:30:00', 'IN', 'Restock'),
('M005', 'P101', 'C001', 'LOC-A', 1, 'WH1', 10, '2026-04-02 10:00:00', 'OUT', 'Damaged Goods'),
('M005', 'P108', 'C003', 'LOC-H', 2, 'WH4', 50, '2026-04-02 10:15:00', 'IN', 'Return'),
('M005', 'P101', 'C001', 'LOC-I', 3, 'WH5', 15, '2026-04-02 10:45:00', 'OUT', 'Sample Use'),
('M006', 'P102', 'C002', 'LOC-B', 2, 'WH1', 40, '2026-04-02 11:00:00', 'IN', 'Adjustment'),
('M006', 'P103', 'C003', 'LOC-C', 3, 'WH2', 20, '2026-04-02 11:15:00', 'OUT', 'Transfer'),
('M006', 'P108', 'C003', 'LOC-J', 1, 'WH5', 35, '2026-04-02 11:45:00', 'IN', 'Bulk Restock'),
('M007', 'P101', 'C001', 'LOC-A', 2, 'WH1', 30, '2026-04-02 12:00:00', 'IN', 'Restock'),
('M007', 'P104', 'C001', 'LOC-D', 1, 'WH2', 20, '2026-04-02 12:30:00', 'OUT', 'Customer Order'),
('M007', 'P105', 'C002', 'LOC-E', 1, 'WH3', 50, '2026-04-02 12:45:00', 'IN', 'Return'),
('M008', 'P106', 'C001', 'LOC-F', 2, 'WH3', 25, '2026-04-02 13:00:00', 'OUT', 'Damaged Goods'),
('M008', 'P107', 'C002', 'LOC-G', 1, 'WH4', 15, '2026-04-02 13:30:00', 'IN', 'Restock'),
('M008', 'P108', 'C003', 'LOC-H', 2, 'WH4', 35, '2026-04-02 13:45:00', 'OUT', 'Customer Order'),
('M009', 'P101', 'C001', 'LOC-I', 3, 'WH5', 40, '2026-04-02 14:00:00', 'IN', 'Return'),
('M009', 'P108', 'C003', 'LOC-J', 1, 'WH5', 30, '2026-04-02 14:15:00', 'OUT', 'Sample Use'),
('M009', 'P101', 'C001', 'LOC-A', 1, 'WH1', 20, '2026-04-02 14:30:00', 'IN', 'Adjustment'),
('M010', 'P102', 'C002', 'LOC-B', 2, 'WH1', 25, '2026-04-02 15:00:00', 'OUT', 'Customer Order'),
('M010', 'P103', 'C003', 'LOC-C', 3, 'WH2', 30, '2026-04-02 15:15:00', 'IN', 'Restock');

-- US MOVEMENTS
-- ('M201', 'P101', 'C001', 'LOC-LA-01', 1, 'WH6', 80, '2026-03-24 09:00:00', 'IN', 'PO Receipt'),
-- ('M201', 'P103', 'C001', 'LOC-LA-02', 2, 'WH6', 10, '2026-03-24 09:30:00', 'IN', 'PO Receipt'),
-- ('M201', 'P106', 'C001', 'LOC-LA-01', 1, 'WH6', 2, '2026-03-24 10:00:00', 'IN', 'PO Receipt'),
-- ('M201', 'P102', 'C001', 'LOC-LA-01', 1, 'WH6', 5, '2026-03-24 10:30:00', 'IN', 'PO Receipt'),
-- ('M202', 'P102', 'C002', 'LOC-LA-03', 1, 'WH7', 400, '2026-03-26 08:00:00', 'IN', 'PO Receipt'),
-- ('M202', 'P107', 'C002', 'LOC-LA-03', 1, 'WH7', 1000, '2026-03-26 08:45:00', 'IN', 'PO Receipt'),
-- ('M202', 'P105', 'C002', 'LOC-LA-04', 2, 'WH7', 133, '2026-03-26 09:15:00', 'IN', 'PO Receipt'),
-- ('M202', 'P108', 'C002', 'LOC-LA-03', 1, 'WH7', 10, '2026-03-26 09:45:00', 'IN', 'PO Receipt'),
-- ('M203', 'P101', 'C001', 'LOC-LA-05', 1, 'WH8', 30, '2026-03-29 11:00:00', 'IN', 'PO Receipt'),
-- ('M203', 'P108', 'C003', 'LOC-LA-05', 1, 'WH8', 3000, '2026-03-29 11:30:00', 'IN', 'PO Receipt'),
-- ('M301', 'P101', 'C001', 'LOC-LA-01', 1, 'WH6', 10, '2026-04-05 14:00:00', 'OUT', 'Customer Order'),
-- ('M301', 'P106', 'C001', 'LOC-LA-01', 1, 'WH6', 2, '2026-04-05 14:15:00', 'OUT', 'Customer Order'),
-- ('M302', 'P103', 'C001', 'LOC-LA-02', 2, 'WH6', 5, '2026-04-05 15:30:00', 'OUT', 'Customer Order'),
-- ('M303', 'P108', 'C003', 'LOC-LA-05', 1, 'WH8', 500, '2026-03-28 10:00:00', 'OUT', 'Customer Order');

SELECT * FROM INVENTORY_MOVEMENT;


CLIENT_OPERATES_IN_COUNTRY

CREATE TABLE CLIENT_OPERATES_IN_COUNTRY (
    ClientID VARCHAR(10) NOT NULL,
    CountryName VARCHAR(100) NOT NULL,
    CONSTRAINT PK_ClientCountry PRIMARY KEY (ClientID, CountryName)
);

INSERT INTO CLIENT_OPERATES_IN_COUNTRY (ClientID, CountryName) VALUES
('C001', 'Singapore'),
('C002', 'Singapore'),
('C003', 'Singapore'),
('C001', 'USA'),
('C002', 'USA'),
('C003', 'USA'),
('C001', Thailand),
('C002', Thailand),
('C003', Thailand);

SELECT * FROM CLIENT_OPERATES_IN_COUNTRY;


CLIENT

CREATE TABLE CLIENT (
    ClientID VARCHAR(10) NOT NULL,
    CompanyName VARCHAR(100) NOT NULL,
    StartDate DATE NOT NULL,
    ServiceTier VARCHAR(20) NOT NULL,
    ContactPerson VARCHAR(100) NOT NULL,

    CONSTRAINT PK_CLIENT PRIMARY KEY (ClientID)
);

INSERT INTO CLIENT VALUES
('C001', 'TechCorp', '2022-01-10', 'Gold', 'Alice Tan'),
('C002', 'LogiWare', '2023-03-15', 'Silver', 'Bob Lim'),
('C003', 'SupplyChainX', '2021-07-01', 'Platinum', 'Charlie Ng');

SELECT * FROM CLIENT;


SUPPLY

CREATE TABLE COUNTRIES (
    Name VARCHAR(50) NOT NULL,

    CONSTRAINT PK_COUNTRIES PRIMARY KEY (Name)
);

INSERT INTO COUNTRIES VALUES
('Singapore'),
('Malaysia'),
('Indonesia'),
('Thailand'),
('USA');

SELECT * FROM COUNTRIES;




CLIENT_WAREHOUSE_STORAGE_CONTRACT

CREATE TABLE CUSTOMER(
CustomerID VARCHAR(10) NOT NULL PRIMARY KEY,
CustomerName VARCHAR(300) NOT NULL);

INSERT INTO CUSTOMER VALUES
-- SINGAPOREAN CUSTOMERS
('C1', 'John Smith'),
('C2', 'Alice Brown'),
('C3', 'The Corner Cafe'),
('C4', 'Bob Johnson'),
('C5', 'Main St Pharmacy'),
('C6', 'Charlie Davis'),
('C7', 'Quick Stop Groceries'),
('C8', 'Diana Prince'),
('C9', 'City Library'),
('C10', 'Edward Norton'),
('C11', 'Fiona Gallagher'),
('C12', 'George Miller'),
('C13', 'Hannah Abbott'),
('C14', 'Local Hardware'),
('C15', 'Ian Wright'),
('C16', 'Jenny Slate'),
('C17', 'Kevin Hart'),
('C18', 'Laura Palmer'),
('C19', 'Metro Cleaners'),
('C20', 'Noah Centineo');

-- LA CUSTOMERS
-- ('C21', 'Michael Ross'),            -- Individual (Santa Monica)
-- ('C22', 'Starlight Studios'),             -- Corporate (Burbank/Universal)
-- ('C23', 'Pacific Tech Solutions'),        -- Office (Silicon Beach)
-- ('C24', 'Sarah Connor'),            -- Individual (Pasadena)
-- ('C25', 'Golden Coast Hotels'),           -- Hospitality (Long Beach)
-- ('C26', 'Angeles Medical Group'),         -- Healthcare (DTLA)
-- ('C27', 'Harvey Specter'),          -- Individual (West Hollywood)
-- ('C28', 'Sunset Boulevard Boutique'),     -- Retail (Beverly Hills)
-- ('C29', 'Oceanic Logistics Corp'),        -- Industrial (Port of LA)
-- ('C30', 'Griffith Observatory Cafe');     -- Tourism/F&B (Griffith Park)

SELECT * FROM CUSTOMER;


CUSTOMER_ORDER

CREATE TABLE ORDER_STATUS_CODE (
    StatusID INT NOT NULL PRIMARY KEY,
    StatusName VARCHAR(20) NOT NULL
);

INSERT INTO ORDER_STATUS_CODE VALUES
(0, 'Unfulfilled'),
(1, 'Delivering'),
(2, 'Completed');

CREATE TABLE PO_STATUS (
    StatusName VARCHAR(50) NOT NULL PRIMARY KEY
);

INSERT INTO PO_STATUS VALUES
('Draft'),
('Submitted'),
('Confirmed'),
('Partially Received'),
('Fully Received'),
('Cancelled');

CREATE TABLE SHIPMENT_STATUS (
    StatusName VARCHAR(50) NOT NULL PRIMARY KEY
);

INSERT INTO SHIPMENT_STATUS VALUES
('In Transit'),
('Arrived'),
('Receiving In Progress'),
('Completed');

-- STOP

CREATE TABLE R1_STOP(
StopID VARCHAR(10) NOT NULL PRIMARY KEY,
Stop_Address VARCHAR(300) UNIQUE NOT NULL
);

INSERT INTO R1_STOP (StopID, Stop_Address) VALUES
-- Warehouses
('S1', '10 Tuas Ave 1'),
('S2', '25 Jurong Port Rd'),
('S3', '5 Mandai Link'),
('S4', '88 Jalan Ahmad Ibrahim'),
('S5', '3 Changi South St 2'),
-- Customers
('S6', '10 Tampines Central 1'),
('S7', '25 Bishan Street 22'),
('S8', '45 Jurong West Way'),
('S9', '789 Orchard Road'),
('S10', '12 Upper Bukit Timah Rd'),
('S11', '555 Serangoon Garden Way'),
('S12', '22 Marine Parade Central'),
('S13', '34 High Street #01-01'),
('S14', '500 Victoria Street'),
('S15', '123 Keppel Bay View'),
('S16', '67 Punggol Waterway'),
('S17', '9 Floral Mile'),
('S18', '303 Sin Ming Drive'),
('S19', '44 Esplanade Drive'),
('S20', '7 Scotts Road'),
('S21', '15 Eunos Technolink'),
('S22', '100 Sentosa Gateway'),
('S23', 'Tuas South Ave 2 - Dock 4'),
('S24', 'Seletar Terrace'),
('S25', 'Mapletree Business City Bldg 2'),
-- WAREHOUSES IN AMERICA
('S26', '2301 E 27th St'),
('S27', '1111 W Artesia Blvd'),
('S28', '2001 N Main St'),
('S29', '2401 E Pacific Coast Hwy'),
('S30', '1500 Maritime St'),
-- STOPS  IN AMERICA
('S31', '700 Exposition Park Dr'),
 ('S32', '100 Universal City Plaza'),
('S33', '1313 Disneyland Dr'),
('S34', '300 World Way'),
('S35', '189 The Grove Dr'),
('S36', '8800 Sunset Blvd'),
('S37', '200 Santa Monica Pier');

-- DELIVERY ROUTE

CREATE TABLE ROUTE_STATUS_CODES (
    StatusID INT PRIMARY KEY,
    StatusName VARCHAR(20) NOT NULL
);

INSERT INTO ROUTE_STATUS_CODES VALUES
(1, 'Pending'),
(2, 'En Route'),
(3, 'Completed'),
(4, 'Delayed');

-- -US ROUTES
-- ('R201', 'V006', 'E014', 5, 3, '2026-04-05', 60.5),
-- ('R202', 'V007', 'E015', 2, 3, '2026-03-28', 15.2),
-- ('R203', 'V006', 'E014', 4, 2, '2026-04-06', 42.0),
-- ('R204', 'V007', 'E015', 3, 1, '2026-04-08', 25.0);

CREATE TABLE TEMPERATURE_CONTROL_CAPABILITIES (
    Type VARCHAR(50) NOT NULL,
    CONSTRAINT PK_TEMP_CAP PRIMARY KEY (Type)
);

INSERT INTO TEMPERATURE_CONTROL_CAPABILITIES (Type) VALUES
('Ambient'), ('Refrigerated') , ('Frozen');

CREATE TABLE WAREHOUSE (
    WarehouseCode VARCHAR(10) NOT NULL,
    Address      VARCHAR(200)  NOT NULL,
    City          VARCHAR(100)  NOT NULL,
    Size          DECIMAL(10,2) NOT NULL,
    SecurityLevel VARCHAR(20)   NOT NULL
        CHECK (SecurityLevel IN ('Low','Medium','High')),
    CountryName   VARCHAR(100)  NOT NULL,
    CONSTRAINT PK_WAREHOUSE PRIMARY KEY (WarehouseCode)
);

INSERT INTO WAREHOUSE
    (WarehouseCode, Address, City, Size, SecurityLevel, CountryName)
VALUES
('WH1','10 Tuas Ave 1',         'Singapore',15000.00,'High',  'Singapore'),
('WH2','25 Jurong Port Rd',     'Singapore',22000.00,'High',  'Singapore'),
('WH3','5 Mandai Link',         'Singapore', 8000.00,'Medium','Singapore'),
('WH4','88 Jalan Ahmad Ibrahim','Singapore',12000.00,'Medium','Singapore'),
('WH5','3 Changi South St 2',   'Singapore',18000.00,'High',  'Singapore');

-- US Line items
-- ('IS201', 1, 'P101', 80),
-- ('IS201', 2, 'P103', 10),
-- ('IS201', 3, 'P106', 2),
-- ('IS201', 4, 'P102', 5),
-- ('IS202', 1, 'P102', 400),
-- ('IS202', 2, 'P107', 1000),
-- ('IS202', 3, 'P105', 133),
-- ('IS202', 4, 'P108', 10);

CREATE TABLE HANDLING_REQUIREMENTS (
    [Type] VARCHAR(50) NOT NULL,

    CONSTRAINT PK_HANDLING_REQUIREMENTS
        PRIMARY KEY ([Type])
);

INSERT INTO HANDLING_REQUIREMENTS ([Type])
VALUES
('Fragile'),
('Refrigerated'),
('Ambient'),
('Dry Stack'),
('Hazardous'),
('Frozen'),
('General'),





queries in Appendix B
queries
name
For each warehouse, find its' top three clients (those who brought in the most amount of business in dollar terms to the warehouse).
Nigel Isaiah Paliath
Which are the locations where shipments depart from that have experienced the most delays (actual arrival date is more than 6 months after expected arrival date)?
Chew Jun Yang
Do warehouses located in Singapore have more businesses (in dollar terms) than warehouses in Los Angeles, USA?
Charles Lee Jun Ngai
What is the average length of time (in terms of months) it takes for products ordered until the products are delivered to warehouses?
Murugavel Girija
What are the top three months in a year for the last two years that have the most purchase orders created in the system?



Lim Wei Jie Nigel
Which suppliers only supply products to warehouses in Singapore?


Lim Kim Leng Jeanie
 Which suppliers do not supply any product to warehouses in Thailand but have supplied all the products in warehouses in Singapore?


Chia Jia Yuun


Appendix C: Individual Contribution form
Appendix D: Use of GenAI Tool(s) in Lab Work

CREATE TABLE SUPPLY (
    ClientID VARCHAR(10) NOT NULL,
    SupplierID VARCHAR(10) NOT NULL,
    ProductID VARCHAR(10) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE,
    LeadTime INT NOT NULL,
    PaymentTerms VARCHAR(50) NOT NULL,

    CONSTRAINT PK_SUPPLY PRIMARY KEY (ClientID, SupplierID, ProductID),

    CONSTRAINT FK_SUPPLY_CLIENT FOREIGN KEY (ClientID)
        REFERENCES CLIENT(ClientID)
);

INSERT INTO SUPPLY (ClientID, SupplierID, ProductID, StartDate, EndDate, LeadTime, PaymentTerms)
VALUES
('C001', 'S001', 'P101', '2023-01-01', NULL, 5, 'Net 30'),
('C001', 'S002', 'P103', '2023-02-01', NULL, 7, 'Net 45'),
('C001', 'S004', 'P104', '2023-01-15', NULL, 10, 'Net 30'),
('C002', 'S001', 'P102', '2023-03-10', NULL, 3, 'Net 30'),
('C002', 'S001', 'P105', '2023-03-10', NULL, 5, 'Net 30'),
('C003', 'S002', 'P103', '2023-05-01', NULL, 7, 'Net 45'),
('C003', 'S004', 'P104', '2022-06-01', NULL, 10, 'Advance'),
('C001', 'S001', 'P106', '2026-03-01', NULL, 12, 'Net 60'),
('C002', 'S002', 'P107', '2026-03-10', NULL, 14, 'Net 30'),
('C003', 'S004', 'P108', '2026-03-15', NULL, 20, 'COD');

SELECT * FROM SUPPLY;




COUNTRIES

-- US INVENTORY
-- ('P101', 'C001', 'LOC-LA-01', 1, 'WH6', 50, 150, 20, 170),
-- ('P103', 'C001', 'LOC-LA-02', 2, 'WH6', 10, 45, 5, 50),
-- ('P106', 'C001', 'LOC-LA-01', 1, 'WH6', 20, 80, 10, 90),
-- ('P102', 'C002', 'LOC-LA-03', 1, 'WH7', 100, 250, 50, 300),
-- ('P107', 'C002', 'LOC-LA-03', 1, 'WH7', 50, 120, 30, 150),
-- ('P105', 'C002', 'LOC-LA-04', 2, 'WH7', 15, 60, 5, 65),
-- ('P101', 'C001', 'LOC-LA-05', 1, 'WH8', 30, 90, 10, 100),
-- ('P108', 'C003', 'LOC-LA-05', 1, 'WH8', 500, 2000, 0, 2000),
-- ('P104', 'C003', 'LOC-LB-01', 1, 'WH9', 300, 800, 200, 1000),
-- ('P102', 'C002', 'LOC-LB-01', 1, 'WH9', 100, 400, 100, 500),
-- ('P108', 'C003', 'LOC-LA-06', 1, 'WH10', 100, 500, 50, 550),
-- ('P107', 'C002', 'LOC-LA-06', 1, 'WH10', 20, 100, 10, 110);

CREATE TABLE PRODUCT (
    ProductID    VARCHAR(10)   NOT NULL,
    ProductName  VARCHAR(255)  NOT NULL,
    Brand        VARCHAR(100)  NOT NULL,
    Category     VARCHAR(100)  NOT NULL,
    [Length]     DECIMAL(10,2) NOT NULL,
    Width        DECIMAL(10,2) NOT NULL,
    Height       DECIMAL(10,2) NOT NULL,
    [Weight]     DECIMAL(10,2) NOT NULL,
    RetailPrice  DECIMAL(10,2) NOT NULL,
    UnitCost     DECIMAL(10,2) NOT NULL,
    ClientID     VARCHAR(10)   NOT NULL,

    CONSTRAINT PK_PRODUCT
        PRIMARY KEY (ProductID),
    CONSTRAINT FK_PRODUCT_CLIENT
        FOREIGN KEY (ClientID)
        REFERENCES CLIENT(ClientID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO PRODUCT
    (ProductID, ProductName, Brand, Category, [Length], Width, Height, [Weight], RetailPrice, UnitCost, ClientID)
VALUES
('P101', 'Galaxy S24', 'Samsung', 'Electronics', 14.7, 7.0, 0.7, 0.16, 799.99, 450.00, 'C001'),
('P102', 'Air Max', 'Nike', 'Apparel', 30.0, 12.0, 10.0, 0.8, 120.00, 45.00, 'C002'),
('P103', 'Bravia TV', 'Sony', 'Electronics', 120.0, 70.0, 5.0, 15.0, 1200.00, 700.00, 'C001'),
('P104', 'Yogurt 4-Pack', 'DairyCo', 'Food', 10.0, 10.0, 8.0, 0.5, 5.50, 2.10, 'C003'),
('P105', 'Glass Vase', 'DecorHome', 'Household', 15.0, 15.0, 40.0, 2.0, 45.00, 15.00, 'C002'),
('P106','ThinkPad T14', 'Lenovo', 'Electronics', 33.00, 22.00, 1.80, 1.50, 1500.00,  900.00, 'C001'),
('P107',  'Running Shorts', 'Nike', 'Apparel', 20.00, 15.00, 2.00, 0.20, 45.00, 12.00, 'C002'),
('P108', 'Canned Beans', 'FoodCo', 'Food', 8.00, 8.00, 11.00, 0.40, 1.50, 0.50, 'C003');

CREATE TABLE SUPPLIERS (
    SupplierID VARCHAR(10) NOT NULL,
    PaymentTerms VARCHAR(50) NOT NULL,
    CompanyName VARCHAR(100) NOT NULL,
    LeadTime INT NOT NULL,
    CountryName VARCHAR(50) NOT NULL,

    CONSTRAINT PK_SUPPLIER PRIMARY KEY (SupplierID),

    CONSTRAINT FK_SUPPLIER_COUNTRY FOREIGN KEY (CountryName)
        REFERENCES COUNTRIES(Name)
);

INSERT INTO SUPPLIERS VALUES
('S001', 'Net 30', 'Alpha Supply Co', 5, 'Singapore'),
('S002', 'Net 45', 'Beta Logistics', 7, 'Thailand'),
('S003', 'Net 30', 'Gamma Industries', 3, 'Malaysia'),
('S004', 'Advance', 'Delta Corp', 10, 'Indonesia');

SELECT * FROM SUPPLIERS;


INBOUND_SHIPMENTS

-- updated relationship from lab 3, so that many suppliers can generate many purchase orders

CREATE TABLE CUSTOMER_ORDER(
    CustomerOrderID VARCHAR(10) NOT NULL PRIMARY KEY,
    OrderStatusCode INT NOT NULL DEFAULT 0,
    OrderDate DATE,
    CustomerID VARCHAR(10) NOT NULL,
    DestinationAddress VARCHAR(300) NOT NULL,
    RequiredDateOfArrival DATE NOT NULL,
    FOREIGN KEY(CustomerID) REFERENCES CUSTOMER(CustomerID),
    FOREIGN KEY(OrderStatusCode) REFERENCES ORDER_STATUS_CODE(StatusID)
);

INSERT INTO CUSTOMER_ORDER VALUES
-- GROUP 1: 5 ORDERS DELIVERED IN MARCH (Status 2)
('CO1', 2, '2026-03-01', 'C1', '10 Tampines Central 1', '2026-03-03'),
('CO2', 2, '2026-03-02', 'C2', '25 Bishan Street 22', '2026-03-04'),
('CO4', 2, '2026-03-05', 'C4', '789 Orchard Road', '2026-03-07'),
('CO7', 2, '2026-03-10', 'C7', '22 Marine Parade Central', '2026-03-12'),
('CO10', 2, '2026-03-15', 'C10', '123 Keppel Bay View', '2026-03-17'),

-- GROUP 2: 5 ORDERS DELIVERED ON R101 (Completed April 5th - Status 2)
-- Delivered April 5. Required date was April 5 (On Time).
('CO12', 2, '2026-03-12', 'C13', '9 Floral Mile', '2026-04-05'),
('CO15', 2, '2026-03-18', 'C17', '7 Scotts Road', '2026-04-05'),
('CO17', 2, '2026-03-20', 'C20', '100 Sentosa Gateway', '2026-04-05'),
-- CO21 & CO23 were March-scheduled but fulfilled late on April 5 (Delayed)
('CO21', 2, '2026-03-25', 'C1', 'Seletar Terrace', '2026-03-27'),
('CO23', 2, '2026-03-22', 'C7', '22 Marine Parade Central', '2026-03-24'),

-- These are due today (April 6) or were due yesterday but are still en route (Delayed)
('CO3', 2, '2026-03-28', 'C3', '45 Jurong West Way', '2026-04-01'), -- Delayed (Required Apr 1)
('CO6', 2, '2026-03-30', 'C6', '555 Serangoon Garden Way', '2026-04-02'), -- Delayed (Required Apr 2)
('CO9', 2, '2026-03-31', 'C9', '500 Victoria Street', '2026-04-06'), -- Due Today
('CO11', 2, '2026-03-29', 'C12', '67 Punggol Waterway', '2026-04-06'), -- Due Today
('CO14', 1, '2026-03-31', 'C16', '44 Esplanade Drive', '2026-04-06'), -- Due Today
('CO16', 2, '2026-03-30', 'C19', '15 Eunos Technolink', '2026-04-07'), -- Due Tomorrow
('CO19', 1, '2026-04-03', 'C2', 'Tuas South Ave 2 - Dock 4', '2026-04-06'), -- Due Today
('CO22', 1, '2026-04-02', 'C5', 'Mapletree Business City Bldg 2', '2026-04-06'), -- Due Today
('CO25', 1, '2026-04-01', 'C12', '67 Punggol Waterway', '2026-04-07'), -- Due Tomorrow

-- GROUP 4: TO BE DELIVERED / UNFULFILLED (Status 0)
('CO5', 0, '2026-04-01', 'C5', '12 Upper Bukit Timah Rd', '2026-04-07'),
('CO8', 0, '2026-04-02', 'C8', '34 High Street #01-01', '2026-04-08'),
('CO13', 0, '2026-04-01', 'C15', '303 Sin Ming Drive', '2026-04-08'),
('CO18', 0, '2026-04-03', 'C1', '10 Tampines Central 1', '2026-04-09'),
('CO20', 0, '2026-04-03', 'C3', '45 Jurong West Way', '2026-04-09'),
('CO24', 0, '2026-04-03', 'C9', '500 Victoria Street', '2026-04-10');

-- ORDERS IN LA
-- ('CO26', 2, '2026-04-01', 'C21', '700 Exposition Park Dr', '2026-04-05'),
-- ('CO27', 2, '2026-04-02', 'C22', '100 Universal City Plaza', '2026-04-05'),
-- ('CO28', 1, '2026-04-02', 'C23', '1313 Disneyland Dr', '2026-04-06'),
-- ('CO29', 1, '2026-04-03', 'C25', '300 World Way', '2026-04-06'),
-- ('CO30', 1, '2026-04-04', 'C26', '189 The Grove Dr', '2026-04-07'),
-- ('CO31', 0, '2026-04-05', 'C28', '8800 Sunset Blvd', '2026-04-08'),
-- ('CO32', 0, '2026-04-05', 'C30', '200 Santa Monica Pier', '2026-04-09'),
-- ('CO33', 2, '2026-03-25', 'C29', '2301 E 27th St', '2026-03-28'),
-- ('CO34', 1, '2026-04-05', 'C27', '8800 Sunset Blvd', '2026-04-07'),
-- ('CO35', 0, '2026-04-06', 'C24', '100 Universal City Plaza', '2026-04-10');

SELECT * FROM CUSTOMER_ORDER;




PURCHASE_ORDER

CREATE TABLE EMPLOYEE (
    EmployeeID VARCHAR(10) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    EmploymentType VARCHAR(20) NOT NULL,
    HireDate DATE NOT NULL,
    AssignedFacility VARCHAR(10),

    CONSTRAINT PK_EMPLOYEE PRIMARY KEY (EmployeeID),

    CONSTRAINT CK_EMPLOYEE_EmploymentType
        CHECK (EmploymentType IN ('full-time', 'part-time', 'contract')),

    CONSTRAINT FK_EMPLOYEE_WAREHOUSE FOREIGN KEY (AssignedFacility)
        REFERENCES WAREHOUSE(WarehouseCode)
);

INSERT INTO EMPLOYEE (EmployeeID, Name, EmploymentType, HireDate, AssignedFacility) VALUES
('E001', 'John Tan', 'full-time', '2022-01-15', 'WH1'),
('E002', 'Sarah Lim', 'part-time', '2023-03-20', 'WH2'),
('E003', 'David Ong', 'contract', '2023-06-01', 'WH3'),
('E004', 'Emily Lee', 'full-time', '2021-11-10', 'WH1'),
('E005', 'Michael Goh', 'full-time', '2020-09-05', 'WH1'),
('E006', 'Rachel Ng', 'part-time', '2024-01-12', 'WH2'),
('E007', 'Daniel Koh', 'contract', '2023-08-18', 'WH2'),
('E008', 'Sophia Chua', 'full-time', '2022-05-25', 'WH3'),

-- US Staff
('E009', 'James Miller', 'full-time', '2026-01-10', 'WH6'),
('E010', 'Linda Ross', 'full-time', '2026-01-15', 'WH7'),
('E011', 'Robert Chen', 'contract', '2026-02-01', 'WH8'),
('E012', 'Maria Garcia', 'full-time', '2026-02-10', 'WH9'),
('E013', 'Steven White', 'part-time', '2026-03-01', 'WH10'),
('E014', 'Brian Oconner', 'full-time', '2026-03-05', 'WH6'),
('E015', 'Dominic Toretto', 'full-time', '2026-03-05', 'WH9');

SELECT * FROM EMPLOYEE;



EMPLOYEE_HAS_CERTIFICATIONS

CREATE TABLE CLIENT_WAREHOUSE_STORAGE_CONTRACT (
ContractID VARCHAR(10) NOT NULL,
ClientID VARCHAR(10) NOT NULL,
WarehouseCode VARCHAR(10) NOT NULL,
StartDate DATE NOT NULL,
EndDate DATE,

CONSTRAINT PK_CONTRACT PRIMARY KEY (ContractID),

CONSTRAINT FK_CONTRACT_CLIENT FOREIGN KEY (ClientID)
REFERENCES CLIENT(ClientID),

CONSTRAINT FK_CONTRACT_WAREHOUSE FOREIGN KEY (WarehouseCode)
REFERENCES WAREHOUSE(WarehouseCode)
);

INSERT INTO CLIENT_WAREHOUSE_STORAGE_CONTRACT VALUES
('CT001', 'C001', 'WH1', '2023-01-01', '2023-12-31'),
('CT002', 'C001', 'WH2', '2023-02-01', NULL),
('CT003', 'C002', 'WH3', '2023-03-01', NULL),
('CT004', 'C003', 'WH4', '2022-06-01', '2024-06-01'),
-- US WAREHOUSES
('CT201', 'C001', 'WH6', '2026-03-01', NULL),
('CT202', 'C002', 'WH7', '2026-03-10', NULL),
('CT203', 'C002', 'WH9', '2026-03-15', NULL),
('CT204', 'C003', 'WH8', '2026-03-15', '2027-03-15'),
('CT205', 'C003', 'WH10', '2026-04-01', NULL);

SELECT * FROM CLIENT_WAREHOUSE_STORAGE_CONTRACT;




CUSTOMER

CREATE TABLE PURCHASE_ORDER(
    PONumber VARCHAR(10) NOT NULL,
    OrderStatus VARCHAR(50) NOT NULL,
    TotalOrderValue DECIMAL(10,2) NOT NULL, -- check if POtotalordervalue against PO line items
    OrderDate DATE NOT NULL,
    WarehouseCode VARCHAR(10) NOT NULL,

    CONSTRAINT PK_PONUMBER PRIMARY KEY (PONumber),

    FOREIGN KEY(OrderStatus) REFERENCES PO_STATUS (StatusName),
    CONSTRAINT FK_PO_WAREHOUSE FOREIGN KEY (WarehouseCode)
        REFERENCES WAREHOUSE(WarehouseCode)
);

INSERT INTO PURCHASE_ORDER VALUES
('PO101', 'Submitted', 36500.00, '2026-04-01', 'WH1'),
('PO102', 'Confirmed', 7692.00, '2026-04-01', 'WH1'),
('PO103', 'Fully Received', 1500.00, '2026-03-28', 'WH2'),
('PO104', 'Partially Received', 6000.00, '2026-03-29', 'WH2'),
('PO105', 'Fully Received', 2700.00, '2026-03-28', 'WH1'),
('PO106', 'Confirmed', 4500.00, '2026-04-05', 'WH3'),
('PO107', 'Fully Received', 670.00, '2026-04-04', 'WH1'),
('PO108', 'Fully Received', 2100.00, '2026-04-04', 'WH2'),
('PO109', 'Submitted', 500.00, '2026-04-02', 'WH3'),
('PO110', 'Draft', 890.00, '2026-04-02', 'WH1'),
-- PURCHASE ORDERS FOR US
('PO201', 'Fully Received', 45000.00, '2026-03-15', 'WH6'),
('PO202', 'Fully Received', 32000.00, '2026-03-18', 'WH7'),
('PO203', 'Fully Received', 15000.00, '2026-03-20', 'WH8'),
('PO204', 'Partially Received', 28000.00, '2026-03-25', 'WH9'),
('PO205', 'Submitted', 12500.00, '2026-04-01', 'WH10'),
-- PURCHASE ORDERS FOR Thailand
('PO301', 'Fully Received', 5000.00, '2025-05-01', 'WH1'),
('PO302', 'Fully Received', 3000.00, '2025-05-15', 'WH2'),
('PO303', 'Fully Received', 4500.00, '2025-06-01', 'WH3'),
-- PURCHASE ORDERS FOR Indonesia
('PO304', 'Fully Received', 2000.00, '2025-07-01', 'WH2'),
('PO305', 'Fully Received', 6000.00, '2025-06-15', 'WH1'),
-- PURCHASE ORDERS FOR Malaysia
('PO306', 'Fully Received', 1500.00, '2025-08-01', 'WH1'),
-- PURCHASE ORDERS FOR Singapore
('PO307', 'Fully Received', 2500.00, '2025-06-10', 'WH2');

SELECT * FROM PURCHASE_ORDER;


SUPPLIERS

-- updated relationship from lab 3, so that many suppliers can generate many purchase orders

CREATE TABLE WAREHOUSE_PICKUP_STOP(
StopID VARCHAR(10) NOT NULL,
WarehouseCode VARCHAR(10) NOT NULL,
FOREIGN KEY(StopID) REFERENCES R1_STOP(StopID),
FOREIGN KEY(WarehouseCode) REFERENCES WAREHOUSE(WarehouseCode),
);

INSERT INTO WAREHOUSE_PICKUP_STOP (StopID, WarehouseCode) VALUES
('S1', 'WH1'),
('S2', 'WH2'),
('S3', 'WH3'),
('S4', 'WH4'),
('S5', 'WH5'),
('S26', 'WH6'),
('S27', 'WH7'),
('S28', 'WH8'),
('S29', 'WH9'),
('S30', 'WH10');

-- ('WH6', '2301 E 27th St', 'Los Angeles', 25000.00, 'High', 'USA'),
-- ('WH7', '1111 W Artesia Blvd', 'Los Angeles', 30000.00, 'High', 'USA'),
-- ('WH8', '2001 N Main St', 'Los Angeles', 12000.00, 'Medium', 'USA'),
-- ('WH9', '2401 E Pacific Coast Hwy', 'Long Beach', 18000.00, 'High', 'USA'),
-- ('WH10', '1500 Maritime St', 'Los Angeles', 9000.00, 'Medium', 'USA');

CREATE TABLE WAREHOUSE_HAS_TEMPERATURE_CONTROL_CAPABILITIES (
    WarehouseCode                       VARCHAR(10) NOT NULL,
    TemperatureControlCapabilityType    VARCHAR(50) NOT NULL,
    CONSTRAINT PK_WH_TEMP
        PRIMARY KEY (WarehouseCode, TemperatureControlCapabilityType),
    CONSTRAINT FK_WH_TEMP_WAREHOUSE
        FOREIGN KEY (WarehouseCode)
        REFERENCES WAREHOUSE(WarehouseCode)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_WH_TEMP_TYPE
        FOREIGN KEY (TemperatureControlCapabilityType)
        REFERENCES TEMPERATURE_CONTROL_CAPABILITIES(Type)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO WAREHOUSE_HAS_TEMPERATURE_CONTROL_CAPABILITIES
    (WarehouseCode, TemperatureControlCapabilityType) VALUES
('WH1', 'Ambient'),
('WH1', 'Refrigerated'),
('WH2', 'Ambient'),
('WH2', 'Frozen'),
('WH2', 'Refrigerated'),
('WH3', 'Ambient'),
('WH4', 'Ambient'),
('WH4', 'Refrigerated'),
('WH5', 'Frozen'),
('WH5', 'Refrigerated'),
-- US Warehouses
('WH6', 'Ambient'),
('WH6', 'Refrigerated'),
('WH7', 'Ambient'),
('WH7', 'Frozen'),
('WH8', 'Ambient'),
('WH9', 'Refrigerated'),
('WH10', 'Ambient');

CREATE TABLE STORAGE_ZONE (
    ZoneID          INT         NOT NULL,
    WarehouseCode   VARCHAR(10) NOT NULL,
    ZoneType        VARCHAR(50) NOT NULL,
    CONSTRAINT PK_STORAGE_ZONE
        PRIMARY KEY (ZoneID, WarehouseCode),
    CONSTRAINT FK_ZONE_WAREHOUSE
        FOREIGN KEY (WarehouseCode)
        REFERENCES WAREHOUSE (WarehouseCode)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO STORAGE_ZONE (ZoneID, WarehouseCode, ZoneType) VALUES
(1, 'WH1', 'General'),
(2, 'WH1', 'Refrigerated'),
(3, 'WH1', 'Hazardous'),
(1, 'WH2', 'General'),
(2, 'WH2', 'Frozen'),
(3, 'WH2', 'Refrigerated'),
(1, 'WH3', 'General'),
(2, 'WH3', 'Bulk'),
(3, 'WH3', 'Fragile'),
(1, 'WH4', 'General'),
(2, 'WH4', 'Ambient'),
(1, 'WH5', 'Frozen'),
(2, 'WH5', 'Refrigerated'),
(3, 'WH5', 'General');

CREATE TABLE CO_LINE_ITEMS (
    Outbound_Shipment_ID VARCHAR(10) NOT NULL,
    Item_ID VARCHAR(10) NOT NULL,
    Quantity INT NOT NULL,
    Product_ID VARCHAR(10) NOT NULL,
    FOREIGN KEY(Product_ID) REFERENCES PRODUCT(ProductID)
    CONSTRAINT PK_CO_LINE_ITEMS PRIMARY KEY (Outbound_Shipment_ID, Item_ID)
);

INSERT INTO CO_LINE_ITEMS (Outbound_Shipment_ID, Item_ID, Quantity, Product_ID) VALUES
('OS101', 'I898', 5, 'P101'),
('OS103', 'I899', 1, 'P103'),
('OS104', 'I900', 4, 'P101'),
('OS104', 'I901', 8, 'P102'),
('OS104', 'I902', 3, 'P106'),
('OS105', 'I903', 5, 'P103'),
('OS105', 'I904', 9, 'P104'),
('OS105', 'I905', 2, 'P107'),
('OS106', 'I906', 6, 'P105'),
('OS106', 'I907', 1, 'P108'),
('OS107', 'I908', 7, 'P101'),
('OS107', 'I909', 4, 'P106'),
('OS108', 'I910', 3, 'P102'),
('OS108', 'I911', 5, 'P108'),
('OS109', 'I912', 2, 'P106'),
('OS109', 'I913', 8, 'P103'),
('OS110', 'I914', 6, 'P107'),
('OS110', 'I915', 1, 'P104'),
-- SHIPMENTS FOR US
('OS201', 'I3001', 10, 'P101'), -- CO26 (WH6)
('OS201', 'I3002', 2, 'P106'),  -- CO26 (WH6)
('OS202', 'I3003', 5, 'P103'),  -- CO27 (WH6)
('OS203', 'I3004', 500, 'P108'), -- CO33 (WH8)
('OS204', 'I3005', 20, 'P102'),  -- CO28 (WH7)
('OS205', 'I3006', 15, 'P107'); -- CO30 (WH10)

SELECT * FROM CO_LINE_ITEMS;




R1_OUTBOUND_SHIPMENTS

CREATE TABLE PRODUCT_HAS_HANDLING_REQUIREMENTS (
    ProductID           VARCHAR(10) NOT NULL,
    SpecialHandlingType VARCHAR(50) NOT NULL,

    CONSTRAINT PK_PROD_HANDLING
        PRIMARY KEY (ProductID, SpecialHandlingType),
    CONSTRAINT FK_PRODHANDLING_PRODUCT
        FOREIGN KEY (ProductID)
        REFERENCES PRODUCT(ProductID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_PRODHANDLING_TYPE
        FOREIGN KEY (SpecialHandlingType)
        REFERENCES HANDLING_REQUIREMENTS([Type])
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO PRODUCT_HAS_HANDLING_REQUIREMENTS
    (ProductID, SpecialHandlingType)
VALUES
('P101', 'Fragile'),
('P103', 'Fragile'),
('P104', 'Refrigerated'),
('P105', 'Fragile'),
('P106', 'Refrigerated'),
('P107', 'Ambient'),
('P108', 'Ambient');

CREATE TABLE EMPLOYEE_HAS_CERTIFICATIONS (
    EmployeeID VARCHAR(10) NOT NULL,
    CertificateID VARCHAR(10) NOT NULL,
    ExpireDate DATE,

    CONSTRAINT PK_EMPLOYEE_HAS_CERTIFICATIONS PRIMARY KEY (EmployeeID, CertificateID),

    CONSTRAINT FK_EHC_EMPLOYEE FOREIGN KEY (EmployeeID)
        REFERENCES EMPLOYEE(EmployeeID),

    CONSTRAINT FK_EHC_CERTIFICATION FOREIGN KEY (CertificateID)
        REFERENCES CERTIFICATIONS(CertificateID)

);

INSERT INTO EMPLOYEE_HAS_CERTIFICATIONS (EmployeeID, CertificateID, ExpireDate) VALUES
('E001', 'CERT001', '2027-01-01'),
('E001', 'CERT005', '2027-01-01'),
('E002', 'CERT005', '2026-12-31'),
('E003', 'CERT002', '2026-08-15'),
('E004', 'CERT001', '2027-03-20'),
('E004', 'CERT006', '2027-03-20'),
('E005', 'CERT003', '2028-05-10'),
('E006', 'CERT005', '2026-11-30'),
('E007', 'CERT004', '2027-07-01'),
('E008', 'CERT001', '2027-09-15');

SELECT * FROM EMPLOYEE_HAS_CERTIFICATIONS;



DRIVER

CREATE TABLE DRIVER (
    EmployeeID VARCHAR(10) NOT NULL,
    LicenseNo VARCHAR(30) NOT NULL,
    LicenseExp DATE NOT NULL,
    IsAvailable BIT NOT NULL,

    CONSTRAINT PK_DRIVER PRIMARY KEY (EmployeeID),
    CONSTRAINT UQ_DRIVER_LicenseNo UNIQUE (LicenseNo),

    CONSTRAINT FK_DRIVER_EMPLOYEE FOREIGN KEY (EmployeeID)
        REFERENCES EMPLOYEE(EmployeeID)
);

INSERT INTO DRIVER (EmployeeID, LicenseNo, LicenseExp, IsAvailable) VALUES
('E005', 'LIC10001', '2028-05-10', 1),
('E007', 'LIC10002', '2027-07-01', 1),
-- US DRIVERS
('E014', 'LIC-US-9001', '2030-01-01', 1),
('E015', 'LIC-US-9002', '2030-01-01', 1);

SELECT * FROM DRIVER;


VEHICLE

CREATE TABLE WAREHOUSE_PERSONNEL (
    EmployeeID VARCHAR(10) NOT NULL,
    CONSTRAINT PK_WAREHOUSE_PERSONNEL PRIMARY KEY (EmployeeID),

    CONSTRAINT FK_WP_EMPLOYEE FOREIGN KEY (EmployeeID)
        REFERENCES EMPLOYEE(EmployeeID)
);

INSERT INTO WAREHOUSE_PERSONNEL (EmployeeID) VALUES
('E001'),
('E002'),
('E003'),
('E004'),
('E006'),
('E008'),
-- US Personnel
('E009'),
('E010'),
('E011'),
('E012'),
('E013');

SELECT * FROM WAREHOUSE_PERSONNEL;






CO_LINE_ITEMS

CREATE TABLE INBOUND_SHIPMENTS(
    Shipment_ID VARCHAR(10) NOT NULL,
    Status VARCHAR(50) NOT NULL,
    Shipped_Date DATE,
    Actual_arrival_date DATE,
    Expected_arrival_date DATE NOT NULL,
    Tracking_number VARCHAR(100) NOT NULL,
    OriginLocation VARCHAR(50) NOT NULL, -- Refers to origin location of shipment, not necessarily supplier's home country
    WarehouseCode VARCHAR(10) NOT NULL,
    SupplierID VARCHAR(10) NOT NULL,
    PONumber VARCHAR(10) NOT NULL,

    CONSTRAINT PK_INB_SHIPMENT PRIMARY KEY (Shipment_ID),

    CONSTRAINT UQ_INB_Tracking UNIQUE (Tracking_number),

    CONSTRAINT FK_SHIPMENT_STATUS FOREIGN KEY (Status)
        REFERENCES SHIPMENT_STATUS(StatusName),
   CONSTRAINT FK_IS_ORI_LOC FOREIGN KEY (OriginLocation)
        REFERENCES COUNTRIES(Name),
    CONSTRAINT FK_IS_WAREHOUSE FOREIGN KEY (WarehouseCode)
        REFERENCES WAREHOUSE(WarehouseCode),
    CONSTRAINT FK_IS_SUPPLIER FOREIGN KEY (SupplierID)
        REFERENCES SUPPLIERS(SupplierID),
    CONSTRAINT FK_IS_PO FOREIGN KEY (PONumber)
        REFERENCES PURCHASE_ORDER(PONumber)
);

INSERT INTO INBOUND_SHIPMENTS VALUES
('IS101', 'Completed', '2026-04-01', '2026-04-05', '2026-04-05', 'TRK1001', 'Singapore', 'WH1', 'S001', 'PO101'),
('IS102', 'In Transit', '2026-04-01', NULL, '2026-04-08', 'TRK1002', 'Thailand', 'WH1', 'S002', 'PO102'),
('IS103', 'Completed', '2026-03-28', '2026-04-07', '2026-04-06', 'TRK1003', 'Malaysia', 'WH2', 'S003', 'PO103'),
('IS104', 'In Transit', '2026-03-29', NULL, '2026-04-09', 'TRK1004', 'Indonesia', 'WH2', 'S004', 'PO104'),
('IS105', 'Completed', '2026-03-28', '2026-04-10', '2026-04-09', 'TRK1005', 'Singapore', 'WH1', 'S001', 'PO105'),
('IS106', 'Receiving In Progress','2026-04-05', '2026-04-09', '2026-04-08', 'TRK1006', 'Thailand',  'WH3', 'S002', 'PO106'),
('IS107', 'Completed', '2026-04-04', '2026-04-11', '2026-04-10', 'TRK1007', 'Malaysia',  'WH1', 'S003', 'PO107'),
('IS108', 'Completed', '2026-04-04', '2026-04-13', '2026-04-11', 'TRK1008', 'Indonesia', 'WH2', 'S004', 'PO108'),
('IS109', 'In Transit', '2026-04-02', NULL, '2026-04-10', 'TRK1009', 'Singapore', 'WH3', 'S001', 'PO109'),
('IS110', 'Arrived', '2026-04-02', '2026-04-06', '2026-04-07', 'TRK1010', 'Thailand', 'WH1', 'S002', 'PO110'),
-- US INBOUND SHIPMENTS
('IS201', 'Completed', '2026-03-15', '2026-03-24', '2026-03-25', 'TRK-US-2001', 'USA', 'WH6', 'S001', 'PO201'),
('IS202', 'Completed', '2026-03-18', '2026-03-26', '2026-03-27', 'TRK-US-2002', 'USA', 'WH7', 'S002', 'PO202'),
('IS203', 'Completed', '2026-03-20', '2026-03-29', '2026-03-30', 'TRK-US-2003', 'USA', 'WH8', 'S003', 'PO203'),
('IS204', 'In Transit', '2026-03-28', NULL, '2026-04-05', 'TRK-US-2004', 'USA', 'WH9', 'S004', 'PO204');

-- 3 delayed shipments from THAILAND
-- ('IS301', 'Completed', '2025-05-10', '2026-01-15', '2025-06-10', 'TRK-DLY-001', 'Thailand', 'WH1', 'S002', 'PO301'),
-- ('IS302', 'Completed', '2025-05-20', '2026-02-20', '2025-06-20', 'TRK-DLY-002', 'Thailand', 'WH2', 'S002', 'PO302'),
-- ('IS303', 'Completed', '2025-06-10', '2026-03-01', '2025-07-10', 'TRK-DLY-003', 'Thailand', 'WH3', 'S002', 'PO303'),

-- 2 delayed shipments from INDONESIA
-- ('IS304', 'Completed', '2025-07-10', '2026-03-10', '2025-08-10', 'TRK-DLY-004', 'Indonesia', 'WH2', 'S004', 'PO304'),
-- ('IS305', 'Completed', '2025-06-20', '2026-02-01', '2025-07-20', 'TRK-DLY-005', 'Indonesia', 'WH1', 'S004', 'PO305'),

-- 1 delayed shipment from MALAYSIA
-- ('IS306', 'Completed', '2025-08-10', '2026-04-05', '2025-09-10', 'TRK-DLY-006', 'Malaysia',  'WH1', 'S003', 'PO306'),

-- 1 delayed shipment from SINGAPORE
-- ('IS307', 'Completed', '2025-06-15', '2026-03-20', '2025-07-15', 'TRK-DLY-007', 'Singapore', 'WH2', 'S001', 'PO307');

SELECT * FROM INBOUND_SHIPMENTS;


CLIENT_CONSOLIDATES_PURCHASE_ORDER

CREATE TABLE CLIENT_CONSOLIDATES_PURCHASE_ORDER(
    PONumber VARCHAR(10) NOT NULL,
    ClientID VARCHAR(10) NOT NULL,

    CONSTRAINT PK_CONSOLIDATION_KEY PRIMARY KEY (ClientID, PONumber),

    CONSTRAINT FK_CONSOLIDATION_CLIENT FOREIGN KEY (ClientID)
        REFERENCES CLIENT(ClientID),
    CONSTRAINT FK_CONSOLIDATION_PO FOREIGN KEY (PONumber)
        REFERENCES PURCHASE_ORDER(PONumber)
);

INSERT INTO CLIENT_CONSOLIDATES_PURCHASE_ORDER (PONumber, ClientID) VALUES
('PO101', 'C001'),
('PO102', 'C002'),
('PO103', 'C003'),
('PO104', 'C001'),
('PO105', 'C001'),
-- US STUFF
('PO201', 'C001'),
('PO202', 'C002'),
('PO203', 'C003'),
('PO204', 'C003'),
('PO205', 'C001'),
-- Thai
('PO301', 'C001'),
('PO302', 'C002'),
('PO303', 'C003'),
-- Indonesia
('PO304', 'C001'),
('PO305', 'C001'),
-- Malaysia
('PO306', 'C002'),
-- Singapore
('PO307', 'C003');

SELECT * FROM CLIENT_CONSOLIDATES_PURCHASE_ORDER;


SUPPLIERS_GENERATES_PURCHASE_ORDERS

-- updated relationship from lab 3, so that many suppliers can generate many purchase orders

CREATE TABLE SUPPLIERS_GENERATES_PURCHASE_ORDERS(
    PONumber VARCHAR(10) NOT NULL,
    SupplierID VARCHAR(10) NOT NULL,

    CONSTRAINT PK_SUPPLIER_PO_KEY PRIMARY KEY (PONumber, SupplierID),

    CONSTRAINT FK_PO_BY_SUPPLIER FOREIGN KEY (PONumber)
        REFERENCES PURCHASE_ORDER(PONumber),
    CONSTRAINT FK_IS_SUPPLIER_PO FOREIGN KEY (SupplierID)
        REFERENCES SUPPLIERS(SupplierID)
);

INSERT INTO SUPPLIERS_GENERATES_PURCHASE_ORDERS (PONumber, SupplierID) VALUES
('PO101', 'S001'),
('PO101', 'S002'),
('PO102', 'S001'),
('PO102', 'S002'),
('PO103', 'S004'),
('PO104', 'S001'),
('PO104', 'S004'),
('PO105', 'S001'),
-- US STUFF
('PO201', 'S001'),
('PO201', 'S002'),
('PO202', 'S001'),
('PO202', 'S002'),
('PO203', 'S001'),
('PO203', 'S004'),
('PO204', 'S001'),
('PO204', 'S004'),
('PO205', 'S001'),
-- Thai
('PO301', 'S002'),
('PO302', 'S002'),
('PO303', 'S002'),
-- Indonesia
('PO304', 'S004'),
('PO305', 'S004'),
-- Malaysia
('PO306', 'S003'),
-- Singapore
('PO307', 'S001');

SELECT * FROM SUPPLIERS_GENERATES_PURCHASE_ORDERS;



WAREHOUSE_PICKUP_STOP

CREATE TABLE PO_LINE_ITEMS (
    PONumber             VARCHAR(10)   NOT NULL,
    ItemID               INT           NOT NULL,
    ProductID            VARCHAR(10)   NOT NULL,
    UnitPrice            DECIMAL(10,2) NOT NULL,
    OrderedQuantity      INT           NOT NULL CHECK (OrderedQuantity > 0),
    ExpectedDeliveryDate DATE          NOT NULL,

    CONSTRAINT PK_PO_LINE_ITEMS
        PRIMARY KEY (PONumber, ItemID),
    CONSTRAINT FK_POLINE_PO
        FOREIGN KEY (PONumber)
        REFERENCES PURCHASE_ORDER(PONumber)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_POLINE_PRODUCT
        FOREIGN KEY (ProductID)
        REFERENCES PRODUCT(ProductID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO PO_LINE_ITEMS (PONumber, ItemID, ProductID, UnitPrice, OrderedQuantity, ExpectedDeliveryDate) VALUES
('PO101', 1, 'P101', 450.00, 50, '2026-04-15'),
('PO101', 2, 'P103', 700.00, 20, '2026-04-15'),
 ('PO102', 1, 'P102', 45.00, 100, '2026-04-20'),
('PO102', 2, 'P107', 12.00, 266, '2026-04-20'),
('PO103', 1, 'P104', 2.10, 500, '2026-04-10'),
('PO103', 2, 'P105', 15.00, 30, '2026-04-10'),
('PO104', 1, 'P101', 450.00, 10, '2026-04-12'),
 ('PO104', 2, 'P108', 0.50, 3000, '2026-04-12'),
('PO105', 1, 'P101', 450.00, 6, '2026-04-25'),
('PO106', 1, 'P106', 900.00, 5, '2026-04-28'),
-- US Purchase Orders
('PO201', 1, 'P101', 450.00, 80, '2026-03-25'),
('PO201', 2, 'P103', 700.00, 10, '2026-03-25'),
('PO201', 3, 'P106', 900.00, 2, '2026-03-25'),
('PO201', 4, 'P102', 40.00, 5, '2026-03-25'),
('PO202', 1, 'P102', 45.00, 400, '2026-03-27'),
('PO202', 2, 'P107', 12.00, 1000, '2026-03-27'),
('PO202', 3, 'P105', 15.00, 133, '2026-03-27'),
('PO202', 4, 'P108', 0.50, 10, '2026-03-27'),
('PO204', 1, 'P104', 2.10, 2000, '2026-04-05'),
('PO204', 2, 'P102', 45.00, 528, '2026-04-05'),
('PO204', 3, 'P101', 40.00, 1, '2026-04-05');

-- US WAREHOUSES
-- (1, 'WH6', 'General'),
-- (2, 'WH6', 'Refrigerated'),
-- (1, 'WH7', 'General'),
-- (2, 'WH7', 'Frozen'),
-- (1, 'WH8', 'General'),
-- (1, 'WH9', 'General'),
-- (1, 'WH10', 'General');

CREATE TABLE STORAGE_LOCATION (
    LocationCode  VARCHAR(50) NOT NULL,
    ZoneID        INT         NOT NULL,
    WarehouseCode VARCHAR(10) NOT NULL,
    CONSTRAINT PK_STORAGE_LOCATION
        PRIMARY KEY (LocationCode, ZoneID, WarehouseCode),
    CONSTRAINT FK_LOC_ZONE
        FOREIGN KEY (ZoneID, WarehouseCode)
        REFERENCES STORAGE_ZONE(ZoneID, WarehouseCode)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO STORAGE_LOCATION (LocationCode, ZoneID, WarehouseCode) VALUES
('LOC-A', 1, 'WH1'),
('LOC-B', 2, 'WH1'),
('LOC-C', 3, 'WH1'),
('LOC-D', 1, 'WH2'),
('LOC-E', 2, 'WH2'),
('LOC-F', 3, 'WH2'),
('LOC-G', 1, 'WH3'),
('LOC-H', 2, 'WH3'),
('LOC-I', 3, 'WH3'),
('LOC-J', 1, 'WH4'),
('LOC-K', 2, 'WH4'),
('LOC-L', 1, 'WH5'),
('LOC-M', 2, 'WH5'),
('LOC-N', 3, 'WH5');

CREATE TABLE VEHICLE (
    VehicleID VARCHAR(10) NOT NULL,
    Type VARCHAR(30) NOT NULL,
    LicensePlate VARCHAR(20) NOT NULL,
    VolumeCap DECIMAL(10,2) NOT NULL,
    WeightCap DECIMAL(10,2) NOT NULL,
    IsAvailable BIT NOT NULL,
    DriverID VARCHAR(10),

    CONSTRAINT PK_VEHICLE PRIMARY KEY (VehicleID),
    CONSTRAINT UQ_VEHICLE_LicensePlate UNIQUE (LicensePlate),

    CONSTRAINT CK_VEHICLE_Type
        CHECK (Type IN ('van', 'truck', 'refrigerated truck')),

    CONSTRAINT FK_VEHICLE_DRIVER FOREIGN KEY (DriverID)
        REFERENCES DRIVER(EmployeeID)
);

INSERT INTO VEHICLE (VehicleID, Type, LicensePlate, VolumeCap, WeightCap, IsAvailable, DriverID) VALUES
('V001', 'van', 'SGX1234A', 12.50, 1500.00, 1, 'E005'),
('V002', 'truck', 'SGX5678B', 30.00, 5000.00, 1, 'E007'),
('V003', 'refrigerated truck', 'SGX9012C', 28.00, 4500.00, 0, NULL),
('V004', 'van', 'MYA3456D', 10.00, 1200.00, 1, NULL),
('V005', 'truck', 'THB7890E', 35.00, 5500.00, 1, NULL),
('V006', 'van', 'LA-VAN-2026', 10.00, 1200.00, 1, 'E014'),
('V007', 'truck', 'LA-TRK-2026', 35.00, 5500.00, 1, 'E015');

SELECT * FROM VEHICLE;


WAREHOUSE_PERSONNEL

-- hi sorry i think need to create again this is_line_items table bc R2_INBOUND_SHIPMENTS → INBOUND_SHIPMENTS
-- Cuz now its many suppliers to many purchase orders, i think my old fd in lab 3 whr i use to decompose inbound shipments is now invalid since PONumber don't determine supplierID cause 1 PO can have multiple suppliers and 1 supplier can have multiple POs,
-- then the tables for suppliers and r1/r2 inbound shipments need to change and hv a new SUPPLIERS_GENERATES_PURCHASE_ORDERS table for this many-to-many r/s instead

CREATE TABLE IS_LINE_ITEMS (
    Shipment_ID  VARCHAR(10) NOT NULL,
    ItemID          INT         NOT NULL,
    ProductID       VARCHAR(10) NOT NULL,
    ShippedQuantity INT         NOT NULL CHECK (ShippedQuantity >= 0),

    CONSTRAINT PK_IS_LINE_ITEMS
        PRIMARY KEY (Shipment_ID, ItemID),
    CONSTRAINT FK_ISLINE_SHIPMENT
        FOREIGN KEY (Shipment_ID)
        REFERENCES INBOUND_SHIPMENTS(Shipment_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_ISLINE_PRODUCT
        FOREIGN KEY (ProductID)
        REFERENCES PRODUCT(ProductID)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO IS_LINE_ITEMS (Shipment_ID, ItemID, ProductID, ShippedQuantity) VALUES ('IS101', 1, 'P101', 50),
('IS101', 2, 'P103', 20),
('IS102', 1, 'P102', 100),
 ('IS102', 2, 'P107', 266),
('IS103', 1, 'P104', 480),
('IS103', 2, 'P105', 30),
('IS104', 1, 'P101', 10),
('IS105', 1, 'P101', 6);

-- US WAREHOUSES
-- ('LOC-LA-01', 1, 'WH6'),
-- ('LOC-LA-02', 2, 'WH6'),
-- ('LOC-LA-03', 1, 'WH7'),
-- ('LOC-LA-04', 2, 'WH7'),
-- ('LOC-LA-05', 1, 'WH8'),
-- ('LOC-LB-01', 1, 'WH9'),
-- ('LOC-LA-06', 1, 'WH10');

CREATE TABLE INVENTORY (
    ProductID         VARCHAR(10) NOT NULL,
    ClientID          VARCHAR(10) NOT NULL,
    LocationCode      VARCHAR(50) NOT NULL,
    ZoneID            INT         NOT NULL,
    WarehouseCode     VARCHAR(10) NOT NULL,
    ReorderQty        INT         NOT NULL CHECK (ReorderQty >= 0),
    QuantityAvailable INT         NOT NULL CHECK (QuantityAvailable >= 0),
    QuantityReserved  INT         NOT NULL CHECK (QuantityReserved >= 0),
    QuantityOnHand    INT         NOT NULL CHECK (QuantityOnHand >= 0),
    CONSTRAINT PK_INVENTORY
        PRIMARY KEY (ProductID, ClientID, LocationCode,
                     ZoneID, WarehouseCode),
    CONSTRAINT FK_INV_PRODUCT
        FOREIGN KEY (ProductID)
        REFERENCES PRODUCT(ProductID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_INV_CLIENT
        FOREIGN KEY (ClientID)
        REFERENCES CLIENT(ClientID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_INV_LOCATION
        FOREIGN KEY (LocationCode, ZoneID, WarehouseCode)
        REFERENCES STORAGE_LOCATION(LocationCode, ZoneID, WarehouseCode)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT CHK_INV_QTY
        CHECK (QuantityOnHand = QuantityAvailable + QuantityReserved)
);

INSERT INTO INVENTORY
    (ProductID, ClientID, LocationCode, ZoneID, WarehouseCode,
     ReorderQty, QuantityAvailable, QuantityReserved, QuantityOnHand)
VALUES
('P101', 'C001', 'LOC-A', 1, 'WH1', 50,  120, 30,  150),
('P102', 'C002', 'LOC-B', 2, 'WH1', 100, 200, 50,  250),
('P103', 'C003', 'LOC-F', 3, 'WH2', 20,  80,  20,  100),
('P104', 'C001', 'LOC-E', 2, 'WH2', 30,  60,  15,  75),
('P105', 'C002', 'LOC-G', 1, 'WH3', 75,  300, 100, 400);

Create table DELIVERY_ROUTE(
RouteID VARCHAR(10) NOT NULL PRIMARY KEY,
VehicleID VARCHAR(10),
DriverID VARCHAR(10),
TotalStops INT,
RouteStatus INT,
RouteDate DATE,
TotalDistance FLOAT,
FOREIGN KEY(VehicleID) REFERENCES VEHICLE(VehicleID),
FOREIGN KEY(DriverID) REFERENCES DRIVER(EmployeeID),
FOREIGN KEY(RouteStatus) REFERENCES ROUTE_STATUS_CODES(StatusID)
);

INSERT INTO DELIVERY_ROUTE (RouteID, VehicleID, DriverID, TotalStops, RouteStatus, RouteDate, TotalDistance) VALUES
-- Completed
('R101', 'V001', 'E005', 4, 3, '2026-04-05', 45.2),
-- En Route (Currently active)
('R102', 'V002', 'E007', 3, 2, '2026-04-06', 18.5),
-- Delayed
('R103', 'V001', 'E005', 3, 4, '2026-04-06', 22.0),
-- Planned for tomorrow
('R104', 'V001', 'E007', 4, 1, '2026-04-07', 35.8);

CREATE TABLE R1_OUTBOUND_SHIPMENTS (
    Route_ID VARCHAR(10) NOT NULL,
    Expected_arrival_date DATE NOT NULL,
    FOREIGN KEY (Route_ID) REFERENCES DELIVERY_ROUTE(RouteID)
    CONSTRAINT PK_ROUTE PRIMARY KEY (Route_ID)
);

INSERT INTO R1_OUTBOUND_SHIPMENTS (Route_ID, Expected_arrival_date) VALUES
('R101', '2026-04-05'),
('R102', '2026-04-06'),
('R103', '2026-04-07'),
 ('R104', '2026-04-08'),
('R105', '2026-04-09'),
-- USA STUFF
('R201', '2026-04-10'),
('R202', '2026-04-11'),
('R203', '2026-04-12'),
('R204', '2026-04-13'),
('R205', '2026-04-14');

SELECT * FROM R1_OUTBOUND_SHIPMENTS;


R2_OUTBOUND_SHIPMENTS

CREATE TABLE R2_STOP(
StopID VARCHAR(10) NOT NULL,
RouteID VARCHAR(10) NOT NULL,
Planned_Sequence INT NOT NULL,
CustomerOrderID VARCHAR(10),
PRIMARY KEY (RouteID, Planned_Sequence),
FOREIGN KEY(StopID) REFERENCES R1_STOP(StopID),
FOREIGN KEY(RouteID) REFERENCES DELIVERY_ROUTE(RouteID),
FOREIGN KEY(CustomerOrderID) REFERENCES CUSTOMER_ORDER(CustomerOrderID));

-- Delivered on Apr 5 through Route R101

INSERT INTO R2_STOP (RouteID, Planned_Sequence, StopID, CustomerOrderID) VALUES
('R101', 1, 'S1', NULL),   -- Start: WH1 (No OrderID for warehouse start)
('R101', 2, 'S17', 'CO12'), -- 9 Floral Mile
('R101', 3, 'S20', 'CO15'), -- 7 Scotts Road
('R101', 4, 'S22', 'CO17'), -- 100 Sentosa Gateway
('R101', 5, 'S24', 'CO21'), -- Seletar Terrace (Delayed from March)
('R101', 6, 'S12', 'CO23'), -- 22 Marine Parade Central (Delayed from March)
('R101', 7, 'S1', NULL); -- End: Return to WH1

INSERT INTO R2_STOP (RouteID, Planned_Sequence, StopID, CustomerOrderID) VALUES
('R102', 1, 'S2', NULL),   -- Start: Jurong Port Rd Warehouse
('R102', 2, 'S8', 'CO3'),  -- 45 Jurong West Way (Jurong)
('R102', 3, 'S11', 'CO6'),  -- 555 Serangoon Garden Way (Serangoon)
('R102', 4, 'S14', 'CO9'),  -- 500 Victoria Street (Bugis/Library)
('R102', 5, 'S21', 'CO16'), -- 15 Eunos Technolink (Eunos)
('R102', 6, 'S23', 'CO19'), -- Tuas South Ave 2 - Dock 4 (Tuas)
('R102', 7, 'S25', 'CO22'), -- Mapletree Business City (Pasir Panjang)
('R102', 8, 'S2', NULL);  -- End: Jurong Port Rd Warehouse

INSERT INTO R2_STOP (RouteID, Planned_Sequence, StopID, CustomerOrderID) VALUES
('R103', 1, 'S3', NULL),   -- Start: Mandai Link Warehouse
('R103', 2, 'S16', 'CO11'), -- 67 Punggol Waterway
('R103', 3, 'S19', 'CO14'), -- 44 Esplanade Drive
('R103', 4, 'S2', NULL);   -- End: WH2

INSERT INTO R2_STOP (RouteID, Planned_Sequence, StopID, CustomerOrderID) VALUES
('R104', 1, 'S4', NULL),   -- Start: Jalan Ahmad Ibrahim Warehouse
('R104', 2, 'S18', 'CO13'), -- 303 Sin Ming Drive (Status 0)
('R104', 3, 'S22', 'CO20'), -- 45 Jurong West Way (Status 0) - Note: Corrected StopID to match CO20 address
('R104', 4, 'S6', 'CO18'), -- 10 Tampines Central 1 (Status 0)
('R104', 5, 'S1', NULL);   -- End: WH1

-- US ROUTES

INSERT INTO R2_STOP (RouteID, Planned_Sequence, StopID, CustomerOrderID) VALUES
-- === Route R201 (WH6 - Los Angeles) ===
('R201', 1, 'S26', NULL),   -- Start: WH6 (2301 E 27th St)
('R201', 2, 'S31', 'CO26'), -- 700 Exposition Park Dr
('R201', 3, 'S32', 'CO27'), -- 100 Universal City Plaza
('R201', 4, 'S26', NULL),   -- End: WH6

-- === Route R202 (WH8 - Los Angeles) ===
('R202', 1, 'S28', NULL),   -- Start: WH8 (2001 N Main St)
('R202', 2, 'S26', 'CO33'), -- Delivery to WH6 Address
('R202', 3, 'S28', NULL),   -- End: WH8

-- === Route R203 (WH7 - Los Angeles / Santa Monica) ===
('R203', 1, 'S27', NULL),   -- Start: WH7 (1111 W Artesia Blvd)
('R203', 2, 'S33', 'CO28'), -- 1313 Disneyland Dr
('R203', 3, 'S34', 'CO29'), -- 300 World Way
('R203', 4, 'S35', 'CO30'), -- 189 The Grove Dr
('R203', 5, 'S27', NULL);   -- End: WH7

CREATE TABLE R2_OUTBOUND_SHIPMENTS (
    Shipment_ID VARCHAR(10) NOT NULL,
    Status VARCHAR(50) NOT NULL,
    Shipped_Date DATE,
    Tracking_number VARCHAR(100) NOT NULL,
    Actual_arrival_date DATE,
    Customer_Order_ID VARCHAR(10) NOT NULL,
    Route_ID VARCHAR(10) NOT NULL,
    CONSTRAINT PK_SHIPMENT PRIMARY KEY (Shipment_ID),
    FOREIGN KEY (Customer_Order_ID) REFERENCES CUSTOMER_ORDER(CustomerOrderID),
    FOREIGN KEY (Route_ID) REFERENCES R1_OUTBOUND_SHIPMENTS(Route_ID),
    CONSTRAINT UQ_Tracking UNIQUE (Tracking_number)
);

INSERT INTO R2_OUTBOUND_SHIPMENTS
(Shipment_ID, Status, Shipped_Date, Tracking_number, Actual_arrival_date, Customer_Order_ID, Route_ID)
VALUES
('OS101', 'Delivered', '2026-03-25', 'TRK-SG-1001', '2026-03-28', 'CO1', 'R101'),
('OS102', 'In Transit', '2026-04-03', 'TRK-SG-1002', NULL, 'CO2', 'R102'),
('OS103', 'Delivered', '2026-03-28', 'TRK-SG-1003', '2026-04-01', 'CO3', 'R103'),
 ('OS104', 'In Transit', '2026-04-04', 'TRK-SG-1004', NULL, 'CO4', 'R104'),
('OS105', 'Delivered', '2026-03-28', 'TRK-SG-1005', '2026-04-02', 'CO5', 'R101'),
('OS106', 'In Transit', '2026-04-05', 'TRK-SG-1006', NULL, 'CO6', 'R102'),
('OS107', 'Delivered', '2026-04-01', 'TRK-SG-1007', '2026-04-04', 'CO7', 'R103'),
('OS108', 'Delivered', '2026-04-02', 'TRK-SG-1008', '2026-04-05', 'CO8', 'R104'),
('OS109', 'In Transit', '2026-04-05', 'TRK-SG-1009', NULL, 'CO9', 'R101'),
('OS110', 'In Transit', '2026-04-06', 'TRK-SG-1010', NULL, 'CO10', 'R102'),
-- US SHIPMENTS
('OS201', 'Delivered', '2026-04-01', 'TRK-LA-2001', '2026-04-05', 'CO26', 'R201'),
('OS202', 'Delivered', '2026-04-02', 'TRK-LA-2002', '2026-04-05', 'CO27', 'R201'),
('OS203', 'Delivered', '2026-03-25', 'TRK-LA-2003', '2026-03-28', 'CO33', 'R202'),
('OS204', 'In Transit', '2026-04-03', 'TRK-LA-2004', NULL, 'CO28', 'R203'),
('OS205', 'In Transit', '2026-04-04', 'TRK-LA-2005', NULL, 'CO30', 'R203');

CREATE TABLE R3_STOP(
Estimated_Arrival_Time TIME,
Actual_Arrival_Time TIME,
Planned_Sequence INT NOT NULL,
RouteID VARCHAR(10) NOT NULL,
PRIMARY KEY(RouteID, Planned_Sequence),
FOREIGN KEY(RouteID, Planned_Sequence) REFERENCES R2_STOP(RouteID, Planned_Sequence));

INSERT INTO R3_STOP (RouteID, Planned_Sequence, Estimated_Arrival_Time, Actual_Arrival_Time) VALUES
('R101', 1, '08:00:00', '08:00:00'),
('R101', 2, '09:30:00', '09:45:00'),
('R101', 3, '11:00:00', '11:15:00'),
('R101', 4, '12:30:00', '12:20:00'),
('R101', 5, '14:30:00', '14:50:00'),
('R101', 6, '16:00:00', '16:15:00'),
('R101', 7, '17:30:00', '17:45:00'),
('R102', 1, '08:00:00', '08:00:00'),
('R102', 2, '09:15:00', '09:30:00'),
('R102', 3, '11:00:00', '11:20:00'),
('R102', 4, '13:00:00', '13:05:00'),
('R102', 5, '15:30:00', '15:55:00'),
('R102', 6, '17:00:00', NULL),
('R102', 7, '18:15:00', NULL),
('R103', 1, '09:00:00', '12:30:00'),
('R103', 2, '10:30:00', '14:45:00'),
('R103', 3, '12:00:00', NULL),
('R103', 4, '13:30:00', NULL),
('R102', 8, '19:30:00', NULL),
('R104', 1, '08:30:00', NULL),
('R104', 2, '10:00:00', NULL),
('R104', 3, '11:30:00', NULL),
('R104', 4, '13:00:00', NULL),
('R104', 5, '14:30:00', NULL),
('R201', 1, '08:00:00', '08:00:00'),
('R201', 2, '10:30:00', '10:45:00'),
('R201', 3, '13:00:00', '13:15:00'),
('R201', 4, '15:30:00', '15:45:00'),
('R202', 1, '09:00:00', '09:00:00'),
('R202', 2, '11:30:00', '11:45:00'),
('R202', 3, '13:00:00', '13:10:00'),
('R203', 1, '08:00:00', '08:00:00'),
('R203', 2, '10:00:00', NULL),
('R203', 3, '12:30:00', NULL),
('R203', 4, '15:00:00', NULL),
('R203', 5, '17:00:00', NULL);
