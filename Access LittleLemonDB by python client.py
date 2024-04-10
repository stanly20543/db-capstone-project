import mysql.connector as connector

# Connect to MySQL database
connection = connector.connect(user = "root", password = "851116", db = "LittleLemonDB")
show_tables = "SHOW tables"

cursor = connection.cursor()
cursor.execute(show_tables)

for i in cursor:
    print(i)

Orders = """
select * from customerdetails as c 
left join orders as o 
on c.CustomerID = o.CustomerID 
where o.TotalCost > 60
order by c.CustomerID"""

cursor.execute(Orders)

print(cursor.column_names)
for i in cursor:
    print(i)