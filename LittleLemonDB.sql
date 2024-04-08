-- Creating the virtual table --
-- Task 1 -- 
create view OrdersView as select OrderID, Quantity, TotalCost from orders where quantity > 2;
select * from OrdersView;

-- Task 2 --
Drop view CustomersOrders;
create view CustomersOrders as 
select c.CustomerID as CustomerID, c.Names as Names,
    o.OrderID as OrderID, o.TotalCost as TotalCost,
    m.MenuID as MenuID, m.Courses as Courses 
    from customerdetails as c 
    join orders as o on c.CustomerID = o.CustomerID
    join menu as m on o.OrderID = m.OrderID
    where TotalCost > 150 order by TotalCost;
select * from CustomersOrders;

-- Task 3 --
select * from orders;
select * from menu;
select menu.* from menu left join orders on menu.OrderID = orders.OrderID 
where orders.orderID = any (select OrderID from orders where quantity > 2);

-- Creating procedure --
-- Task 1 --
create procedure GetMaxQuantity()
select max(quantity) from orders;
call GetMaxQuantity;

-- Task 2 --
prepare  GetOrderDetail from
'select OrderID, Quantity, TotalCost from orders where OrderID = ?';
set @id = 1;
execute GetOrderDetail using @id;

-- Task 3 --
delimiter //

Create procedure CancelOrder(in orderid int)
begin
   delete from Orders where OrderID = orderid;
   select concat("Order ", orderid, " is cancelled") as COnfirmation ;
end //
delimiter ;

-- Creating SQL queries to check bookings
-- Task 2
delimiter //

Create procedure CheckBooking(in booking_date date, in table_number int)
begin
	DECLARE bookedTable INT;
    
    SELECT COUNT(*) INTO bookedTable
    FROM littlelemondb.bookings
    WHERE Date = booking_date AND TableNumber = table_number;
    
    IF bookedTable > 0 THEN
        SELECT CONCAT('Table ', table_number, ' is already booked') AS `Booking status`;
    ELSE
        SELECT CONCAT('Table ', table_number, ' is not booked') AS `Booking status`;
    END IF;
end //   
 
delimiter ;

Call CheckBooking("2022-11-12", 3)

-- Task 3

delimiter //

create procedure AddValidBooking(in booking_date date, in table_number int)
begin 
    Declare excitingbooking int;
    
    select count(*) into excitingbooking
    from littlelemondb.bookings
    where Date = booking_date AND TableNumber = table_number;
    
    start transaction;
    
    IF excitingbooking > 0 then
        rollback;
        select concat('Table ', table_number, ' is already booked - booking cancelled') as Booking_status;
	else 
        insert into `LittleLemonDB`.`Bookings` (`Date`, `TableNumber`, CustomerID) 
        VALUES (booking_date, table_number, 0);
        
        commit;
	end if;
end //

delimiter ;

Call AddValidBooking('2024-10-11', 2);

-- Create SQL queries to add and update bookings
-- Task 1
delimiter //

create procedure AddBooking(in customer_ID int, in booking_date date, in table_number int)
begin 
    Declare excitingbooking int;
    
    select count(*) into excitingbooking
    from littlelemondb.bookings
    where Date = booking_date AND TableNumber = table_number;
    
    start transaction;
    
    IF excitingbooking > 0 then
        rollback;
        select concat('Table ', table_number, ' is already booked - booking cancelled') as Booking_status;
	else 
        insert into `LittleLemonDB`.`Bookings` (`Date`, `TableNumber`, CustomerID) 
        VALUES (booking_date, table_number, customer_ID);
        
        commit;
        select 'New Booking is added' as Confirmation;
	end if;
end //

delimiter ;

Call AddBooking(11, '2024-11-16', 3);

-- Task 2
delimiter //

create procedure UpdateBooking(in booking_ID int, in booking_date date)
begin
    update bookings
	set Date = booking_date
    where BookingID = booking_ID;
    select concat("booking ", booking_ID, " updated") as Confirmation ;
end //

delimiter ;

call UpdateBooking(16, '2023-11-16');
select * from bookings;

-- Task 3
delimiter //

create procedure CancelBooking(in booking_ID int)
begin
    delete from bookings where BookingID = booking_ID;
    select concat('Booking ', booking_ID, ' cancelled') as Confirmation;
end //

delimiter ;

Call CancelBooking(16);
