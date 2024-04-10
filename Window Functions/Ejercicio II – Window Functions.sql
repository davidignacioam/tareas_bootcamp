
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

