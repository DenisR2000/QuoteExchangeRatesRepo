/*
USE MASTER 
GO
IF DB_ID('AzureRatesDb') IS NOT NULL
	DROP DATABASE AzureRatesDb
GO
CREATE DATABASE AzureRatesDb
GO
use AzureRatesDb

create table items
(
  item_id int primary key identity(1, 1),
  price int not null,
  currency varchar(50) not null
)

go 

insert into items(price, currency) 
values 
(100, 'USD'), 
(10, 'EUR'),
(20, 'USD'),
(40, 'USD'),
(20, 'EUR'),
(30, 'UAH'),
(400, 'USD'),
(50, 'EUR'),
(60, 'USD')

create table rates
(
  currency nvarchar(50) not null,
  date_ date, 
  rate float
)

insert into rates(currency, date_, rate)
values
('USD', '2015.01.10', 25.3),
('USD', '2015.01.11', 25.3),
('USD', '2015.01.12', 25.5),
('USD', '2015.01.13', 25.6),
('EUR', '2015.01.12', 29.4),
('EUR', '2015.01.11', 29.4),
('UAH', '2015.01.11', 1.0)

*/

USE AzureRatesDb

SELECT * FROM items

SELECT * FROM rates

SELECT item_id, (items.price * rates.rate) AS prise_UAH 
FROM items INNER JOIN rates ON items.currency = rates.currency
			INNER JOIN (SELECT currency, MAX(date_) AS MaxDate
						FROM rates
						GROUP BY currency)currencyes ON rates.date_ = currencyes.MaxDate
						AND rates.currency = currencyes.currency
