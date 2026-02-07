CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Role NVARCHAR(20), -- Admin / Vendor / Client
    FullName NVARCHAR(100),
    Email NVARCHAR(100),
    Mobile NVARCHAR(15),
    PasswordHash NVARCHAR(255),
    IsApproved BIT DEFAULT 1,   -- Vendor = 0 until admin approves
    IsBlocked BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE()
);


select * from Products

ALTER TABLE Users
ADD 
    EmailOTP NVARCHAR(6),
    OTPExpiry DATETIME,
	EmailVerified BIT DEFAULT 0;
    IsSetupComplete BIT DEFAULT 0;
	ResendCount INT DEFAULT 0,
    LastOTPTime DATETIME;
	LoginAttempts INT DEFAULT 0,
    LockUntil DATETIME;

	ALTER TABLE Users
ADD 
    ApprovalStatus NVARCHAR(20) DEFAULT 'Pending', -- Pending / Approved / Rejected
    AdminRemark NVARCHAR(255);



SELECT ProductID, ImagePath FROM ProductImages


	ALTER TABLE Users
drop
    OTP ,
    IsVerified



	CREATE TABLE VendorApprovalHistory (
    HistoryID INT IDENTITY PRIMARY KEY,
    VendorID INT,
    Action NVARCHAR(20), -- Approved / Rejected / Blocked / Unblocked
    Remark NVARCHAR(255),
    ActionDate DATETIME DEFAULT GETDATE()
);



	select * from Users


INSERT INTO Users
(Role, FullName, Email, Mobile, PasswordHash, IsApproved, IsBlocked)
VALUES
('Admin','System Admin','admin@test.com','9999999999','123456',1,0);



CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100),
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE()
);



ALTER TABLE Categories
ADD ImagePath NVARCHAR(255) NULL;


ALTER TABLE Products
ADD IsDeal BIT DEFAULT 0;

select * from Products
select * from ProductImages

delete from ProductImages where ProductID= 2;


CREATE TABLE SubCategories (
    SubCategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryID INT,
    VendorID INT, -- Users.UserID
    SubCategoryName NVARCHAR(100),
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    VendorID INT, -- Users.UserID
    CategoryID INT,
    SubCategoryID INT,
    ProductName NVARCHAR(150),
    Description NVARCHAR(MAX),
    Price DECIMAL(10,2),
    Stock INT,
    IsBlocked BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE ProductImages (
    ImageID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT,
    ImagePath NVARCHAR(255)
);

select * from ProductImages
select * from VendorDetails

DELETE FROM Users WHERE UserID=3;

CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    ClientID INT, -- Users.UserID
    VendorID INT, -- Users.UserID
    TotalAmount DECIMAL(10,2),
    OrderStatus NVARCHAR(50),
    PaymentMode NVARCHAR(10) DEFAULT 'COD',
    OrderDate DATETIME DEFAULT GETDATE()
);

ALTER TABLE Orders
ADD UserID INT NOT NULL;


CREATE TABLE OrderAddress
(
    AddressID INT IDENTITY PRIMARY KEY,
    OrderID INT,
    Address NVARCHAR(300),
    City NVARCHAR(100),
    State NVARCHAR(100),
    Pincode NVARCHAR(10)
);



CREATE TABLE OrderItems (
    OrderItemID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);


CREATE TABLE VendorDetails (
    VendorID INT PRIMARY KEY, -- Users.UserID
    ShopName NVARCHAR(150),
    GSTNumber NVARCHAR(50),
    Address NVARCHAR(255),
    DocumentPath NVARCHAR(255),
    LogoPath NVARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE()
);


CREATE TABLE Wishlist (
    WishlistID INT IDENTITY PRIMARY KEY,
    UserID INT,
    ProductID INT,
    CreatedAt DATETIME DEFAULT GETDATE()
);


select * from Users

