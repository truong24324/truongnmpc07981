﻿-- Tạo cơ sở dữ liệu và sử dụng cơ sở dữ liệu
CREATE DATABASE SALES_MANAGEMENT;
GO 

USE SALES_MANAGEMENT;
GO

-- Tạo bảng USERS và thêm dữ liệu mẫu
CREATE TABLE USERS(
	ID_USER VARCHAR(20) PRIMARY KEY,
	FULLNAME NVARCHAR(100),
	PHONE VARCHAR(10),
	ADDRESS NVARCHAR(MAX),
	GENDER NVARCHAR(10),
	BRITHDAY DATE,
	EMAIL NVARCHAR(100),
	ROLE NVARCHAR(50),
	IMAGE NVARCHAR(MAX),
	PASSWORD NVARCHAR(MAX),
	CONFIRMATION_CODE INT
);
GO

SELECT * FROM USERS
SELECT * FROM PRODUCTS


INSERT INTO USERS (ID_USER, FULLNAME, PHONE, ADDRESS, GENDER, BRITHDAY, EMAIL, ROLE, IMAGE, PASSWORD) VALUES 
('U001', 'Nguyen Van A', '0912345678', '123 Nguyen Trai, Q.1, TP.HCM', 'Male', '1990-01-01', 'nguyenvana@example.com', 'Admin', 'image1.jpg', 'passwordHash1'),
('U002', 'Tran Thi B', '0987654321', '456 Le Loi, Q.3, TP.HCM', 'Female', '1992-02-02', 'tranthib@example.com', 'User', 'image2.jpg', 'passwordHash2'),
('U003', 'Le Van C', '0901234567', '789 Ly Tu Trong, Q.5, TP.HCM', 'Male', '1988-03-03', 'levanc@example.com', 'User', 'image3.jpg', 'passwordHash3'),
('U004', 'Pham Thi D', '0911223344', '321 Hai Ba Trung, Q.3, TP.HCM', 'Female', '1995-04-04', 'phamthid@example.com', 'User', 'image4.jpg', 'passwordHash4'),
('U005', 'Vo Van E', '0909988776', '654 Phan Dang Luu, Q. Phu Nhuan, TP.HCM', 'Male', '1993-05-05', 'vovane@example.com', 'Admin', 'image5.jpg', 'passwordHash5');
GO

-- Tạo bảng PRODUCTS và thêm dữ liệu mẫu
CREATE TABLE PRODUCTS(
	ID_PRO VARCHAR(20) PRIMARY KEY,
	ID_USER VARCHAR(20),	
	NAME_PRO NVARCHAR(255),
	CREATION_DATE DATE DEFAULT GETDATE(),
	PRICE MONEY CHECK (PRICE > 0),
	IMAGE VARCHAR(MAX),
	BARCODE BIGINT,
	CONSTRAINT FK_PRODUCTS_USERS FOREIGN KEY (ID_USER) REFERENCES USERS(ID_USER)
);
GO

INSERT INTO PRODUCTS (ID_PRO, ID_USER, NAME_PRO, PRICE, IMAGE, BARCODE) VALUES
('P001', 'U001', 'Product 1', 100000, 'product1.jpg', 1234567890123),
('P002', 'U002', 'Product 2', 200000, 'product2.jpg', 1234567890124),
('P003', 'U003', 'Product 3', 150000, 'product3.jpg', 1234567890125),
('P004', 'U004', 'Product 4', 250000, 'product4.jpg', 1234567890126),
('P005', 'U005', 'Product 5', 300000, 'product5.jpg', 1234567890127);
GO

-- Tạo bảng ORDERS và thêm dữ liệu mẫu
CREATE TABLE ORDERS(
	ID_ORDER VARCHAR(20) PRIMARY KEY,
	ID_USER VARCHAR(20),
	ORDER_DATE DATE DEFAULT GETDATE(),
	TOTAL_PRICE MONEY,
	STATUS NVARCHAR(50),
	SHIPPING_ADDRESS NVARCHAR(MAX),
	PAYMENT_METHOD NVARCHAR(50),
	CONSTRAINT FK_ORDERS_USERS FOREIGN KEY (ID_USER) REFERENCES USERS(ID_USER)
);
GO

INSERT INTO ORDERS (ID_ORDER, ID_USER, TOTAL_PRICE, STATUS, SHIPPING_ADDRESS, PAYMENT_METHOD) VALUES
('O001', 'U001', 500000, 'Pending', '123 Nguyen Trai, Q.1, TP.HCM', 'Credit Card'),
('O002', 'U002', 200000, 'Shipped', '456 Le Loi, Q.3, TP.HCM', 'PayPal'),
('O003', 'U003', 350000, 'Delivered', '789 Ly Tu Trong, Q.5, TP.HCM', 'Cash on Delivery'),
('O004', 'U004', 400000, 'Cancelled', '321 Hai Ba Trung, Q.3, TP.HCM', 'Credit Card'),
('O005', 'U005', 250000, 'Pending', '654 Phan Dang Luu, Q. Phu Nhuan, TP.HCM', 'Credit Card');
GO

-- Tạo bảng ORDER_DETAILS và thêm dữ liệu mẫu
CREATE TABLE ORDER_DETAILS(
	ID_ORDER_DETAIL VARCHAR(20) PRIMARY KEY,
	ID_ORDER VARCHAR(20),
	ID_PRO VARCHAR(20),
	QUANTITY INT CHECK (QUANTITY > 0),
	PRICE MONEY CHECK (PRICE > 0),
	CONSTRAINT FK_ORDER_DETAILS_ORDERS FOREIGN KEY (ID_ORDER) REFERENCES ORDERS(ID_ORDER),
	CONSTRAINT FK_ORDER_DETAILS_PRODUCTS FOREIGN KEY (ID_PRO) REFERENCES PRODUCTS(ID_PRO)
);
GO

INSERT INTO ORDER_DETAILS (ID_ORDER_DETAIL, ID_ORDER, ID_PRO, QUANTITY, PRICE) VALUES
('OD001', 'O001', 'P001', 2, 200000),
('OD002', 'O001', 'P002', 1, 200000),
('OD003', 'O002', 'P003', 2, 300000),
('OD004', 'O003', 'P004', 1, 250000),
('OD005', 'O003', 'P005', 1, 300000);
GO

-- Tạo bảng PAYMENTS và thêm dữ liệu mẫu
CREATE TABLE PAYMENTS(
	ID_PAYMENT VARCHAR(20) PRIMARY KEY,
	ID_ORDER VARCHAR(20),
	PAYMENT_DATE DATE DEFAULT GETDATE(),
	AMOUNT MONEY CHECK (AMOUNT > 0),
	PAYMENT_METHOD NVARCHAR(50),
	STATUS NVARCHAR(50),
	CONSTRAINT FK_PAYMENTS_ORDERS FOREIGN KEY (ID_ORDER) REFERENCES ORDERS(ID_ORDER)
);
GO

INSERT INTO PAYMENTS (ID_PAYMENT, ID_ORDER, AMOUNT, PAYMENT_METHOD, STATUS) VALUES
('PAY001', 'O001', 500000, 'Credit Card', 'Completed'),
('PAY002', 'O002', 200000, 'PayPal', 'Completed'),
('PAY003', 'O003', 350000, 'Cash on Delivery', 'Pending'),
('PAY004', 'O004', 400000, 'Credit Card', 'Cancelled'),
('PAY005', 'O005', 250000, 'Credit Card', 'Pending');
GO
