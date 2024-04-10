
/* 1. AVG */
select 
	c.category_name as Categoría,
	p.product_name as Producto,
	p.unit_price as Precio,
	avg(p.unit_price) over (partition by p.category_id) as Precio_Promedio_Categoría
from products as p 
left join categories as c on c.category_id = p.category_id 
;

/* 2. AVG */
select 
	o.customer_id as ID_Cliente,
	o.order_id as ID_Orden,
	o.employee_id as ID_Empleado,
	od.unit_price as Precio,
	od.quantity as CantidadVentas, 
	avg(od.unit_price) over (partition by o.customer_id) as Precio_Ventas_Promedio_Cliente,
	avg(od.quantity) over (partition by o.customer_id) as Cantidad_Ventas_Promedio_Cliente,
	avg(od.quantity * od.unit_price) over (partition by o.customer_id) as Total_Ventas_Promedio_Cliente
from orders as o
inner join order_details as od on od.order_id  = o.order_id 
;

/* 3. AVG */
select 
	p.product_name as Producto,
	c.category_name as Categoría,
	p.unit_price as Precio,
	p.quantity_per_unit as Cantidad_Unidad,
	od.quantity as Cantidad,
	avg(od.quantity) over (partition by p.category_id) as Cantidad_Promedio_Categoría
from products as p 
left join categories as c on c.category_id = p.category_id 
left join order_details as od on od.product_id  = p.product_id 
order by 
	c.category_name, 
	p.product_name
	asc
;

/* 4. MIN */
select 
	o.customer_id as Cliente,
	o.order_date  as Fecha_Orden,
	min(o.order_date) over (partition by o.customer_id) as Fecha_Orden_Mínima
from orders as o
left join order_details as od on od.order_id  = o.order_id 
;

/* 5. MAX */
select 
	p.product_id  as ID_Producto,
	p.product_name as Producto,
	c.category_id as ID_Categoría,
	c.category_name as Categoría,
	p.unit_price as Precio,
	max(p.unit_price) over (partition by p.category_id) as Precio_Máximo_Categoría
from products as p 
inner join categories as c on c.category_id = p.category_id 
;

/* 6. ROW_NUMBER */
select 
	row_number() over (order by sum(od.quantity) desc) as Ránking,
	p.product_name as Producto,
	sum(od.quantity) as Total_Cantidad
from products as p 
left join categories as c on c.category_id = p.category_id 
left join order_details as od on od.product_id  = p.product_id 
group by p.product_name
order by sum(od.quantity) desc
;

/* 7. ROW_NUMBER */
select distinct
	row_number() over (order by c.customer_id) as Ránking,
	c.customer_id as ID_Cliente,
	c.company_name as Compañía
from customers as c
order by row_number() over (order by c.customer_id) asc
;

/* 8. ROW_NUMBER */
select 
	row_number () over (order by e.birth_date desc) as Ránking,
	concat(e.first_name,' ',e.last_name) as Nombre_Completo_Empleado,
	e.birth_date as Fecha_Nacimiento
from employees as e 
;

/* 9. SUM */
select 
	o.customer_id as ID_Cliente,
	o.employee_id  as ID_Empleado,
	o.order_id  as ID_Orden,
	od.unit_price as Precio,
	od.quantity  as Cantidad,
	od.unit_price * od.quantity as Venta_Final,
	sum(od.unit_price * od.quantity) over (partition by o.customer_id order by o.customer_id) as Suma_Total_Ventas_Clientes
from orders as o
inner join order_details as od on od.order_id  = o.order_id 
;

/* 10. SUM */
select 
	c.category_name as Categoría,
	p.product_name as Producto,
	od.unit_price as Precio,
	od.quantity  as Cantidad,
	od.unit_price * od.quantity as Venta_Final,
	sum(od.unit_price * od.quantity) over (partition by c.category_name order by c.category_name) as Suma_Total_Ventas_Categorías
from orders as o
inner join order_details as od on od.order_id  = o.order_id 
left join products as p on p.product_id = od.product_id 
inner join categories as c on c.category_id = p.category_id 
;

/* 11. SUM */
select 
	o.ship_country as País, 
	o.order_id as ID_Orden,
	o.shipped_date as Fecha_Envío,
	o.freight as Precio_Envío,
	sum(o.freight) over (partition by o.ship_country) as Suma_Total_Precio_Envío
from orders as o
where o.shipped_date is not null
order by o.ship_country, o.order_id asc
;

/* 12. RANK */
select 
	rank() over (order by sum(od.unit_price) desc) as Ránking,
	o.customer_id as ID_Cliente,
	sum(od.unit_price * od.quantity) as Suma_Total_Ventas
from orders as o
inner join order_details as od on od.order_id  = o.order_id 
group by o.customer_id
order by sum(od.unit_price) desc
;

/* 13. RANK */
select 
	e.employee_id as ID_Empleado,
	concat(e.first_name,' ',e.last_name) as Nombre_Completo_Empleado,
	e.hire_date as Fecha_Contratación,
	rank () over (order by e.hire_date asc) as Ránking
from employees as e 
;

/* 14. RANK */
select 
	p.product_id as ID_Producto,
	p.product_name as Producto,
	p.unit_price as Precio_Unitario,
	rank () over (order by p.unit_price desc) as Ránking
from products as p 
order by p.unit_price desc
;