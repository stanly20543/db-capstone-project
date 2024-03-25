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


