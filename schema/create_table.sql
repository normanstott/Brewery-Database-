Create Procedure CreateTables
As
Begin

    Create Table Beer (
        BeerId Int Identity(1,1) Primary Key,
        Name Nvarchar(100) Not Null,
        Style Nvarchar(50) Not Null,
        Abv Decimal(4,2) Not Null,
        Ibu Int Null
    );

    Create Table Batches (
        BatchId Int Identity(1,1) Primary Key,
        BeerId Int Not Null,
        BrewDate Date Not Null,
        BatchSize Int Not Null,
        Constraint Fk_Batches_Beer Foreign Key (BeerId)
            References Beer(BeerId)
    );

    Create Table Customers (
        CustomerId Int Identity(1,1) Primary Key,
        Name Nvarchar(100) Not Null,
        CustomerType Nvarchar(50) Not Null,
        Phone Nvarchar(20) Null,
        Email Nvarchar(100) Null,
        BillingAddress Nvarchar(200) Null
    );

    Create Table Orders (
        OrderId Int Identity(1,1) Primary Key,
        CustomerId Int Not Null,
        OrderDate Date Not Null,
        OrderStatus Nvarchar(50) Not Null,
        Constraint Fk_Orders_Customers Foreign Key (CustomerId)
            References Customers(CustomerId)
    );

    Create Table Invoices (
        InvoiceId Int Identity(1,1) Primary Key,
        OrderId Int Not Null,
        InvoiceDate Date Not Null,
        PaymentStatus Nvarchar(50) Not Null,
        PaymentMethod Nvarchar
);

    Create Table Cases (
        CaseId Int Identity(1,1) Primary Key,
        BatchId Int Not Null,
        OrderId Int Not Null,
        CaseSize Int Not Null,
        CasePrice Decimal(10,2) Not Null,
        Constraint Fk_Cases_Batches Foreign Key (BatchId)
            References Batches(BatchId),
        Constraint Fk_Cases_Orders Foreign Key (OrderId)
            References Orders(OrderId)
    );

    Create Table Employees (
        EmployeeId Int Identity(1,1) Primary Key,
        Name Nvarchar(100) Not Null,
        Role Nvarchar(50) Not Null,
        Salary Decimal(10,2) Not Null,
        HireDate Date Not Null
    );

    Create Table Equipment (
        EquipmentId Int Identity(1,1) Primary Key,
        Name Nvarchar(100) Not Null,
        Type Nvarchar(50) Not Null,
        MaintenanceDate Date Null,
        Status Nvarchar(50) Not Null
    );

    Create Table Suppliers (
        SupplierId Int Identity(1,1) Primary Key,
        Name Nvarchar(100) Not Null,
        Phone Nvarchar(20) Null,
        Email Nvarchar(100) Null,
        Address Nvarchar(200) Null
    );

    Create Table Ingredients (
        IngredientId Int Identity(1,1) Primary Key,
        SupplierId Int Not Null,
        Name Nvarchar(100) Not Null,
        IngredientType Nvarchar(50) Not Null,
        Constraint Fk_Ingredients_Suppliers Foreign Key (SupplierId)
            References Suppliers(SupplierId)
    );

    Create Table EmployeeBatch (
        EmployeeId Int Not Null,
        BatchId Int Not Null,
        Primary Key (EmployeeId, BatchId),
        Constraint Fk_EmployeeBatch_Employees Foreign Key (EmployeeId)
            References Employees(EmployeeId),
        Constraint Fk_EmployeeBatch_Batches Foreign Key (BatchId)
            References Batches(BatchId)
    );

    Create Table EquipmentBatch (
        EquipmentId Int Not Null,
        BatchId Int Not Null,
        Primary Key (EquipmentId, BatchId),
        Constraint Fk_EquipmentBatch_Equipment Foreign Key (EquipmentId)
            References Equipment(EquipmentId),
        Constraint Fk_EquipmentBatch_Batches Foreign Key (BatchId)
            References Batches(BatchId)
    );

    Create Table IngredientBatch (
        IngredientId Int Not Null,
        BatchId Int Not Null,
        QuantityUsed Decimal(10,2) Not Null,
        Primary Key (IngredientId, BatchId),
        Constraint Fk_IngredientBatch_Ingredients Foreign Key (IngredientId)
            References Ingredients(IngredientId),
        Constraint Fk_IngredientBatch_Batches Foreign Key (BatchId)
            References Batches(BatchId)
    );

End;
Go

execute CreateTables
go 

Create Procedure InsertBeer
    @Name Nvarchar(100),
    @Style Nvarchar(50),
    @Abv Decimal(4,2),
    @Ibu Int
As
Begin
    Insert Into Beer (Name, Style, Abv, Ibu)
    Values (@Name, @Style, @Abv, @Ibu);
End;
Go

Exec InsertBeer 'Pale Ale', 'Ale', 5.2, 40;
Exec InsertBeer 'Stout', 'Dark', 6.5, 55;
Exec InsertBeer 'Lager', 'Light', 4.8, 18;
Exec InsertBeer 'IPA', 'Hoppy', 7.1, 70;
Exec InsertBeer 'Pilsner', 'Crisp', 5.0, 25;
Go

Create Procedure InsertBatches
    @BeerId Int,
    @BrewDate Date,
    @BatchSize Int
As
Begin
    Insert Into Batches (BeerId, BrewDate, BatchSize)
    Values (@BeerId, @BrewDate, @BatchSize);
End;
Go

Exec InsertBatches 1, '2026-01-10', 500;
Exec InsertBatches 2, '2026-01-12', 450;
Exec InsertBatches 3, '2026-01-15', 600;
Exec InsertBatches 4, '2026-01-18', 550;
Exec InsertBatches 5, '2026-01-20', 700;
Go

Create Procedure InsertCustomers
    @Name Nvarchar(100),
    @CustomerType Nvarchar(50),
    @Phone Nvarchar(20),
    @Email Nvarchar(100),
    @BillingAddress Nvarchar(200)
As
Begin
    Insert Into Customers (Name, CustomerType, Phone, Email, BillingAddress)
    Values (@Name, @CustomerType, @Phone, @Email, @BillingAddress);
End;
Go

Exec InsertCustomers 'Landon Coy', 'Retail', '555-1111', 'landonc@gmail.com', '123 Main St';
Exec InsertCustomers 'Brew House', 'Wholesale', '555-2222', 'sales@brewhouse.com', '45 Market Ave';
Exec InsertCustomers 'Tap Tavern', 'Retail', '555-3333', 'brewery@taptavern.com', '89 River Rd';
Exec InsertCustomers 'Craft Corner', 'Wholesale', '555-4444', 'orders@craftcorner.com', '77 Oak St';
Exec InsertCustomers 'Ale Depot', 'Retail', '555-5555', 'contact@aledepot.com', '12 Brewery Ln';
Go

Create Procedure InsertOrders
    @CustomerId Int,
    @OrderDate Date,
    @OrderStatus Nvarchar(50)
As
Begin
    Insert Into Orders (CustomerId, OrderDate, OrderStatus)
    Values (@CustomerId, @OrderDate, @OrderStatus);
End;
Go

Exec InsertOrders 1, '2026-02-01', 'Pending';
Exec InsertOrders 2, '2026-02-03', 'Shipped';
Exec InsertOrders 3, '2026-02-05', 'Delivered';
Exec InsertOrders 4, '2026-02-07', 'Pending';
Exec InsertOrders 5, '2026-02-09', 'Shipped';
Go

Create Procedure InsertInvoices
    @OrderId Int,
    @InvoiceDate Date,
    @PaymentStatus Nvarchar(50),
    @PaymentMethod Nvarchar(50)
As
Begin
    Insert Into Invoices (OrderId, InvoiceDate, PaymentStatus, PaymentMethod)
    Values (@OrderId, @InvoiceDate, @PaymentStatus, @PaymentMethod);
End;
Go

Exec InsertInvoices 1, '2026-02-02', 'Unpaid', 'Card';
Exec InsertInvoices 2, '2026-02-04', 'Paid', 'Cash';
Exec InsertInvoices 3, '2026-02-06', 'Paid', 'Card';
Exec InsertInvoices 4, '2026-02-08', 'Unpaid', 'Check';
Exec InsertInvoices 5, '2026-02-10', 'Paid', 'Card';
Go

Create Procedure InsertCases
    @BatchId Int,
    @OrderId Int,
    @CaseSize Int,
    @CasePrice Decimal(10,2)
As
Begin
    Insert Into Cases (BatchId, OrderId, CaseSize, CasePrice)
    Values (@BatchId, @OrderId, @CaseSize, @CasePrice);
End;
Go

Exec InsertCases 1, 1, 24, 45.99;
Exec InsertCases 2, 2, 24, 49.99;
Exec InsertCases 3, 3, 12, 29.99;
Exec InsertCases 4, 4, 24, 54.99;
Exec InsertCases 5, 5, 24, 47.99;
Go

Create Procedure InsertEmployees
    @Name Nvarchar(100),
    @Role Nvarchar(50),
    @Salary Decimal(10,2),
    @HireDate Date
As
Begin
    Insert Into Employees (Name, Role, Salary, HireDate)
    Values (@Name, @Role, @Salary, @HireDate);
End;
Go
Exec InsertEmployees 'Reif Stanfield', 'Brewer', 52000, '2022-01-10';
Exec InsertEmployees 'Tyler Nyguyen', 'Technician', 48000, '2021-11-05';
Exec InsertEmployees 'Wyatt Simms', 'Manager', 65000, '2020-03-15';
Exec InsertEmployees 'Colby Lopper', 'Packaging', 42000, '2023-02-01';
Exec InsertEmployees 'Stewart Hartel', 'Quality Control', 55000, '2021-07-20';
Go

Create Procedure InsertEquipment
    @Name Nvarchar(100),
    @Type Nvarchar(50),
    @MaintenanceDate Date,
    @Status Nvarchar(50)
As
Begin
    Insert Into Equipment (Name, Type, MaintenanceDate, Status)
    Values (@Name, @Type, @MaintenanceDate, @Status);
End;
Go

Exec InsertEquipment 'Mash Tun', 'Brewing', '2024-01-01', 'Operational';
Exec InsertEquipment 'Fermenter A', 'Fermentation', '2024-01-15', 'Operational';
Exec InsertEquipment 'Fermenter B', 'Fermentation', '2023-12-20', 'Needs Service';
Exec InsertEquipment 'Bottling Line', 'Packaging', '2024-02-01', 'Operational';
Exec InsertEquipment 'Keg Washer', 'Cleaning', '2024-01-10', 'Operational';
Go

Create Procedure InsertSuppliers
    @Name Nvarchar(100),
    @Phone Nvarchar(20),
    @Email Nvarchar(100),
    @Address Nvarchar(200)
As
Begin
    Insert Into Suppliers (Name, Phone, Email, Address)
    Values (@Name, @Phone, @Email, @Address);
End;
Go

Exec InsertSuppliers 'HopCo', '555-1111', 'sales@hopco.com', '12 Hop Lane';
Exec InsertSuppliers 'Malt Masters', '555-2222', 'info@maltmasters.com', '88 Barley Rd';
Exec InsertSuppliers 'YeastWorks', '555-3333', 'support@yeastworks.com', '45 Culture St';
Exec InsertSuppliers 'BottlePro', '555-4444', 'orders@bottlepro.com', '77 Glass Ave';
Exec InsertSuppliers 'GrainHub', '555-5555', 'contact@grainhub.com', '101 Wheat Blvd';
Go

Create Procedure InsertIngredients
    @SupplierId Int,
    @Name Nvarchar(100),
    @IngredientType Nvarchar(50)
As
Begin
    Insert Into Ingredients (SupplierId, Name, IngredientType)
    Values (@SupplierId, @Name, @IngredientType);
End;
Go

Exec InsertIngredients 1, 'Cascade Hops', 'Hops';
Exec InsertIngredients 2, 'Pale Malt', 'Grain';
Exec InsertIngredients 3, 'Ale Yeast', 'Yeast';
Exec InsertIngredients 4, 'Brown Bottles', 'Packaging';
Exec InsertIngredients 5, 'Crystal Malt', 'Grain';
Go

Create Procedure InsertEmployeeBatch
    @EmployeeId Int,
    @BatchId Int
As
Begin
    Insert Into EmployeeBatch (EmployeeId, BatchId)
    Values (@EmployeeId, @BatchId);
End;
Go

Exec InsertEmployeeBatch 1, 1;
Exec InsertEmployeeBatch 2, 1;
Exec InsertEmployeeBatch 3, 2;
Exec InsertEmployeeBatch 4, 3;
Exec InsertEmployeeBatch 5, 4;
Go

Create Procedure InsertEquipmentBatch
    @EquipmentId Int,
    @BatchId Int
As
Begin
    Insert Into EquipmentBatch (EquipmentId, BatchId)
    Values (@EquipmentId, @BatchId);
End;
Go

Exec InsertEquipmentBatch 1, 1;
Exec InsertEquipmentBatch 2, 1;
Exec InsertEquipmentBatch 3, 2;
Exec InsertEquipmentBatch 4, 3;
Exec InsertEquipmentBatch 5, 4;
Go

Create Procedure InsertIngredientBatch
    @IngredientId Int,
    @BatchId Int,
    @QuantityUsed Decimal(10,2)
As
Begin
    Insert Into IngredientBatch (IngredientId, BatchId, QuantityUsed)
    Values (@IngredientId, @BatchId, @QuantityUsed);
End;
Go

Exec InsertIngredientBatch 1, 1, 12.5;
Exec InsertIngredientBatch 2, 1, 50.0;
Exec InsertIngredientBatch 3, 2, 1.2;
Exec InsertIngredientBatch 4, 3, 24.0;
Exec InsertIngredientBatch 5, 4, 40.0;
Go

Create Procedure DropTables
As
Begin

    Drop Table IngredientBatch;
    Drop Table EquipmentBatch;
    Drop Table EmployeeBatch;
    Drop Table Cases;
    Drop Table Batches;
    Drop Table Beer;
    Drop Table Ingredients;
    Drop Table Suppliers;
    Drop Table Equipment;
    Drop Table Employees;
    Drop Table Invoices;
    Drop Table Orders;
    Drop Table Customers;

End;
Go

Exec DropTables;
Go

Drop Procedure CreateTables;
Drop Procedure DropTables;
Drop Procedure InsertBeer;
Drop Procedure InsertBatches;
Drop Procedure InsertCustomers;
Drop Procedure InsertOrders;
Drop Procedure InsertInvoices;
Drop Procedure InsertCases;
Drop Procedure InsertEmployees;
Drop Procedure InsertEquipment;
Drop Procedure InsertSuppliers;
Drop Procedure InsertIngredients;
Drop Procedure InsertEmployeeBatch;
Drop Procedure InsertEquipmentBatch;
Drop Procedure InsertIngredientBatch;
Go
