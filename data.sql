create database QLQCF
GO

USE QLQCF
GO

CREATE TABLE TableFood(
	id int identity primary key,
	name nvarchar(100) not null default N'Chưa đặt tên',
	status nvarchar(100) not null default N'Trống'
)

CREATE TABLE Account(
	UserName nvarchar(100) primary key,
	DisplayName nvarchar(100) not null default N'Shinn',
	PassWord nvarchar(100) not null default 0,
	Type int not null default 0
)

create table FoodCategory(
	id int identity primary key,
	name nvarchar(100) not null default N'Chưa đặt tên'
)

create table Food(
	id int identity primary key,
	name nvarchar(100) not null ,
	idCategory int not null,
	price float not null default 0,
	foreign key(idCategory) references dbo.FoodCategory(id)
)

create table Bill(
	id int identity primary key,
	DateCheckIn Date not null default getdate(),
	DateCheckOut date,
	idTable int not null,
	status int not null default 0

	foreign key(idTable) references dbo.TableFood(id)
)

create table BillInfo(
	id int identity primary key,
	idBill int not null,
	idFood int not null,
	count int not null default 0

	foreign key(idBill) references dbo.Bill(id),
	foreign key(idFood) references dbo.Food(id)
)

insert into dbo.Account(
	UserName,
	DisplayName,
	PassWord,
	Type
)
values(	
	N'Shin',
	N'Shin',
	N'1234',
	1
),
(	
	N'staff',
	N'staff',
	N'1234',
	0
)
go
create proc USP_GetAccountByUserName
@userName nvarchar(100)
as
begin
	select * from dbo.Account where UserName = @userName
end

exec USP_GetAccountByUserName @userName = N'Shin'

go
create proc USP_Login
@userName nvarchar(100), @passWord nvarchar(100)
as
begin
	select * from Account where UserName = @userName and PassWord = @passWord
end


declare @i int = 0

while @i<=10

begin
	insert dbo.TableFood (name) values (N'Bàn ' + cast(@i as nvarchar(100)))
	set @i = @i +1
end

select * from dbo.TableFood

go
create proc USP_GetTableList
as select * from TableFood

update TableFood set status = N'Có người' where id = 9

select * from Bill

select * from BillInfo

select * from FoodCategory

select * from Food


select f.name,bi.count,f.price,f.price*bi.count as totalPrice from BillInfo as bi, Bill as b, Food as f where bi.idBill = b.id and bi.idFood = f.id and b.idTable = 2


INSERT INTO FoodCategory (name)
VALUES (N'Đồ uống'), (N'Đồ ăn'), (N'Kem')


-- Chèn các giá trị mẫu cho bảng Food
INSERT INTO Food (name, idCategory, price)
VALUES (N'Cà phê đen', 1, 25000),
       (N'Cà phê sữa', 1, 30000),
       (N'Coca-Cola', 1, 20000),
       (N'Bánh mì thịt', 2, 35000),
       (N'Bánh mỳ pate', 2, 30000),
       (N'Bánh mỳ chả lụa', 2, 30000),
       (N'Kem sữa dừa', 3, 40000),
       (N'Kem sữa chua', 3, 35000),
       (N'Kem tươi', 3, 30000),
       (N'Nước ép cam', 1, 25000),
       (N'Nước ép dưa hấu', 1, 30000),
       (N'Nước ép táo', 1, 28000);



INSERT INTO Bill (DateCheckIn,DateCheckOut, idTable, status)
VALUES 
    (GETDATE(), Null,2, 0),
    (GETDATE(),GETDATE(), 2, 1)

insert into BillInfo(idBill,idFood,count)
values(1,1,2),(1,3,4),(1,5,1),(2,6,2),(2,3,4),(2,5,4)

go
create proc USP_InsertBill
@idTable int
as
begin
	insert Bill (DateCheckIn,DateCheckOut, idTable, status,discount)
VALUES 
    (GETDATE(), Null,@idTable, 0,0)
end
select * from Bill

go
create proc USP_InsertBillInfo
@idBill int, @idFood int, @count int
as
begin
	declare @isExitsBillInfo int
	declare @foodCount int = 1

	select @isExitsBillInfo = id, @foodCount = count from BillInfo where idBill = @idBill and idFood = @idFood

	if (@isExitsBillInfo > 0)
	begin
		declare @newCount int = @foodCount + @count
		if (@newCount > 0)
			update BillInfo set count = @foodCount + @count where idFood = @idFood
		else 
			delete BillInfo where idBill = @idBill and idFood = @idFood
	end
	else
	begin
		insert into BillInfo(idBill,idFood,count)
		values(@idBill,@idFood,@count)
	end
end

go
create trigger UTG_UpdateBillInfo
on BillInfo for insert, update
as
begin
	declare @idBill int

	select @idBill = idBill from inserted

	declare @idTable int

	select @idTable = idTable from Bill where id = @idBill and status = 0

	update TableFood set status = N'Có người' where id = @idTable
end

go
create trigger UTG_UpdateBill
on Bill for update
as
begin
	declare @idBill int

	select @idBill = id from inserted

	declare @idTable int

	select @idTable = idTable from Bill where id = @idBill
	
	declare @count int = 0

	select @count = Count(*) from Bill where idTable = @idTable and status = 0

	if (@count = 0)
		update TableFood set status = N'Trống' where id = @idTable
end

delete BillInfo
delete Bill

alter table Bill add totalPrice float


go
create proc usp_GetListBillBydate
@checkIn date, @checkOut date
as
begin
	select t.name as [Tên bàn],b.totalPrice as [Tổng tiền], DateCheckIn as[Ngày vào], DateCheckOut as [Ngày ra], discount as [Giảm giá (%)]
	from Bill as b, TableFood as t
	where DateCheckIn >= @checkIn and DateCheckOut <= @checkOut and b.status = 1
	and t.id = b.idTable 
end

select * from Account where userName = 'Shin'



go
create trigger UTG_DeleteBillInfo 
on BillInfo for delete
as
begin
	declare @idBillInfo int
	declare @idBill int
	select @idBillInfo = id, @idBill = deleted.idBill from deleted

	declare @idTable int
	select @idTable = idTable from Bill where id = @idBill

	declare @count int = 0

	select @count = count(*) from BillInfo as bi, Bill as b where b.id = bi.idBill and b.id = @idBill and b.status = 0

	if (@count = 0)
		update TableFood set status = N'Trống' where id = @idTable
end
