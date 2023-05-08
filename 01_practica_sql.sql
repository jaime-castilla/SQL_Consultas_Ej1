-- Sentencia Select 
--Obtener todos los registros y todos los campos de la tabla de productos
select * from public.products
--Obtenerr una consulta con Productid, productname, supplierid, categoryId, UnistsinStock, UnitPrice.
select products.product_id, products.product_name, products.supplier_id, products.category_id, products.units_in_stock, products.unit_price from public.products
--Crear una consulta para obtener el IdOrden, IdCustomer, Fecha de la orden de la tabla de ordenes.
select orders.order_id, orders.customer_id, orders.order_date from public.orders
--Crear una consulta para obtener el OrderId, EmployeeId, Fecha de la orden.
select orders.order_id, orders.employee_id, orders.order_date from public.orders

--Columnas calculadas 

--Obtener una consulta con Productid, productname y valor del inventario, valor inventrio (UnitsinStock * UnitPrice)
select products.product_id, products.product_name, (units_in_stock * unit_price)as valor_inventario from public.products
--Cuanto vale el punto de reorden 
select (reorder_level * unit_price)as punto_reorden from public.products
--Mostrar una consulta con Productid, productname y precio, el nombre del producto debe estar en mayuscula 
select products.product_id, upper(products.product_name), products.unit_price from public.products
--Mostrar una consulta con Productid, productname y precio, el nombre del producto debe contener unicamente 10 caracteres */
select products.product_id, substring(products.product_name, 1, 10), products.unit_price from public.products
--Obtenre una consulta que muestre la longitud del nombre del producto
select length(products.product_name) from public.products
--Obtener una consulta de la tabla de productos que muestre el nombre en minúscula
select lower(products.product_name) from public.products
--Mostrar una consulta con Productid, productname y precio, el nombre del producto debe contener unicamente 10 caracteres y se deben mostrar en mayúscula */
select product_id, upper(substring(products.product_name, 1, 10)), unit_price from public.products

--Filtros

--Obtener de la tabla de Customers las columnas CustomerId, CompanyName, Pais Obtener los clientes cuyo pais sea Spain
select customer_id, company_name, country from public.customers where country='Spain'
--Obtener de la tabla de Customers las columnas CustomerId, CompanyName, Pais, Obtener los clientes cuyo pais comience con la letra U
select customer_id, company_name, country from public.customers where country like 'U%%'
--Obtener de la tabla de Customers las columnas CustomerId, CompanyName, Pais, Obtener los clientes cuyo pais comience con la letra U,S,A
select customer_id, company_name, country from public.customers where country like 'U%%' or country like 'S%%' or country like 'A%%'
--Obtener de la tabla de Productos las columnas productid, ProductName, UnitPrice cuyos precios esten entre 50 y 150
select product_id, product_name, unit_price from public.products where unit_price between 50 and 150
--Obtener de la tabla de Productos las columnas productid, ProductName, UnitPrice, UnitsInStock cuyas existencias esten entre 50 y 100
select product_id, product_name, unit_price, units_in_stock from public.products where units_in_stock between 50 and 100
--Obtener las columnas OrderId, CustomerId, employeeid de la tabla de ordenes cuyos empleados sean 1, 4, 9
select order_id, customer_id, employee_id from public.orders where employee_id in (1, 4, 9) 

--ORDENAR EL RESULTADO DE LA QUERY POR ALGUNA COLUMNA 

--Obtener la información de la tabla de Products, Ordenarlos por Nombre del Producto de forma ascendente
select * from public.products order by product_name asc
--Obtener la información de la tabla de Products, Ordenarlos por Categoria de forma ascendente y por precio unitario de forma descendente
select * from public.products order by category_id asc , unit_price desc
--Obtener la información de la tabla de Clientes, Customerid, CompanyName, city, country ordenar por pais, ciudad de forma ascendente
select customer_id, company_name, city, country from public.customers order by country asc, city asc
--Obtener los productos productid, productname, categoryid, supplierid ordenar por categoryid y supplier únicamente mostrar aquellos cuyo precio esté entre 25 y 200
select product_id, product_name, category_id, supplier_id from public.products where supplier_id between 25 and 200 order by category_id asc, supplier_id asc 


--Funciones agregación

--Cuantos productos hay en la tabla de productos
select count(*) from public.products
--De la tabla de productos Sumar las cantidades en existencia 
select sum(units_in_stock) from public.products
--Promedio de los precios de la tabla de productos
select avg(unit_price) from public.products

--Ordenar

--Obtener los datos de productos ordenados descendentemente por precio unitario de la categoría 1
select * from public.products where category_id = 1 order by unit_price desc
--Obtener los datos de los clientes(Customers) ordenados descendentemente por nombre(CompanyName) que se encuentren en la ciudad(city) de barcelona, Lisboa
select * from public.customers where city in ('Barcelona', 'Lisboa') order by company_name desc
--Obtener los datos de las ordenes, ordenados descendentemente por la fecha de la orden cuyo cliente(CustomerId) sea ALFKI
select * from public.orders where customer_id = 'ALFKI' order by order_date desc
--Obtener los datos del detalle de ordenes, ordenados ascendentemente por precio cuyo producto sea 1, 5 o 20
select * from public.order_details where product_id in (1, 5, 20) order by unit_price desc
--Obtener los datos de las ordenes ordenados ascendentemente por la fecha de la orden cuyo empleado sea 2 o 4
select * from public.orders where employee_id in (2, 4) order by order_date asc
--Obtener los productos cuyo precio están entre 30 y 60 ordenado por nombre
select * from public.products where unit_price between 30 and 60 order by product_name

--funciones de agrupacion

--OBTENER EL MAXIMO, MINIMO Y PROMEDIO DE PRECIO UNITARIO DE LA TABLA DE PRODUCTOS UTILIZANDO ALIAS
select max(unit_price)as maximo, min(unit_price)as minimo, avg(unit_price)as promedio from public.products

--Agrupacion

--Numero de productos por categoria
select category_id, count(product_id) from public.products group by category_id
--Obtener el precio promedio por proveedor de la tabla de productos
select supplier_id, avg(unit_price) from public.products group by supplier_id
--Obtener la suma de inventario (UnitsInStock) por SupplierID De la tabla de productos (Products)
select supplier_id, sum(units_in_stock) from public.products group by supplier_id
--Contar las ordenes por cliente de la tabla de orders
select customer_id, count(order_id) from public.orders group by customer_id
--Contar las ordenes por empleado de la tabla de ordenes unicamente del empleado 1,3,5,6
select employee_id, count(order_id) from public.orders where employee_id in (1, 3, 5, 6) group by employee_id
--Obtener la suma del envío (freight) por cliente
select customer_id, sum(freight) from public.orders group by customer_id
--De la tabla de ordenes únicamente de los registros cuya ShipCity sea Madrid, Sevilla, Barcelona, Lisboa, LondonOrdenado por el campo de suma del envío
--Obtener el precio promedio de los productos por categoria sin contar con los productos descontinuados (Discontinued)
select category_id, avg(unit_price) from public.products where discontinued = null group by category_id
--Obtener la cantidad de productos por categoria,  aquellos cuyo precio se encuentre entre 10 y 60 que tengan más de 12 productos
select category_id count(product_id) from public.products where unit_price between 10 and 60 
group by category_id
having count(product_id) > 12
--OBTENER LA SUMA DE LAS UNIDADES EN EXISTENCIA (UnitsInStock) POR CATEGORIA, Y TOMANDO EN CUENTA UNICAMENTE LOS PRODUCTOS CUYO PROVEEDOR (SupplierID) SEA IGUAL A 17, 19, 16.
select category_id, sum(units_in_stock) from public.products
--cuya categoria tenga menos de 100 unidades ordenado por unidades



