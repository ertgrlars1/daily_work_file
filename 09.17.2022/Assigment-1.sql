CREATE DATABASE Manufacturer

USE Manufacturer

CREATE TABLE [Product] (
[prod_id] [int] PRIMARY KEY,
[prod_name] [varchar](50),
[quantity] [int]
);

CREATE TABLE [Supplier] (
[supp_id] [int] PRIMARY KEY,
[supp_name] [varchar](50),
[supp_location] [varchar](50),
[supp_country] [varchar](50),
[is_active] [bit]
)

CREATE TABLE [Component] (
[comp_id] [int] PRIMARY KEY,
[comp_name] [varchar](50),
[description] [varchar](50),
[quantity_comp] [int]
)

CREATE TABLE [Prod_Comp] (
[prod_id] [int] ,
[comp_id] [int] ,
[quantity_comp] [int] ,
FOREIGN KEY (prod_id) REFERENCES Product (prod_id),
FOREIGN KEY (comp_id) REFERENCES Component (comp_id),
PRIMARY KEY ([prod_id],[comp_id])
)

CREATE TABLE [Comp_Supp] (
[supp_id] [int] ,
[comp_id] [int] ,
[order_date] [date] ,
[quantity] [int],
FOREIGN KEY (supp_id) REFERENCES Supplier (supp_id),
FOREIGN KEY (comp_id) REFERENCES Component (comp_id),
PRIMARY KEY ([supp_id],[comp_id])
)