1. Total revenue by beer style
-- (join query, aliases)
select b.Style, sum(c.CaseSize * c.CasePrice) as TotalRevenue
from Beer b
inner join Batches bt on b.BeerId = bt.BeerId
inner join Cases c on bt.BatchId = c.BatchId
group by b.Style
order by TotalRevenue desc;
 
2. Top customers by total order value
select cu.Name as CustomerName, sum(ca.CaseSize * ca.CasePrice) as TotalSpent
from Customers cu
inner join Orders o on cu.CustomerId = o.CustomerId
inner join Cases ca on o.OrderId = ca.OrderId
group by cu.Name
order by TotalSpent desc;
 
3. Unpaid or overdue invoices
-- (filter query)
select o.OrderId, cu.Name as CustomerName, i.InvoiceDate, i.PaymentStatus
from Invoices i
inner join Orders o on i.OrderId = o.OrderId
inner join Customers cu on o.CustomerId = cu.CustomerId
where i.PaymentStatus = 'Unpaid'
order by i.InvoiceDate asc;
 
 4. Equipment currently needing service
select Name, Type, MaintenanceDate, Status
from Equipment
where Status = 'Needs Service';
 
 5. Average batch size by beer style
select b.Style, avg(bt.BatchSize) as AvgBatchSize
from Beer b
inner join Batches bt on b.BeerId = bt.BeerId
group by b.Style
order by AvgBatchSize desc;
 
 6. Employees ranked by number of batches worked
-- (multi-table join through junction table)
select e.Name as EmployeeName, e.Role, count(eb.BatchId) as BatchesWorked
from Employees e
inner join EmployeeBatch eb on e.EmployeeId = eb.EmployeeId
group by e.Name, e.Role
order by BatchesWorked desc;
 
7. Ingredient usage by supplier
-- (four-table join)
select s.Name as SupplierName, i.Name as IngredientName, sum(ib.QuantityUsed) as TotalQuantityUsed
from Suppliers s
inner join Ingredients i on s.SupplierId = i.SupplierId
inner join IngredientBatch ib on i.IngredientId = ib.IngredientId
group by s.Name, i.Name
order by TotalQuantityUsed desc;

8. Most recent batch per beer
-- (window function)
select BeerName, BrewDate, BatchSize
from (
    select b.Name as BeerName, bt.BrewDate, bt.BatchSize,
           row_number() over (partition by b.BeerId order by bt.BrewDate desc) as rn
    from Beer b
    inner join Batches bt on b.BeerId = bt.BeerId
) ranked
where rn = 1;
 
9. Beers with no orders yet
-- (left join to find unmatched rows)
select b.Name, b.Style
from Beer b
left join Batches bt on b.BeerId = bt.BeerId
left join Cases c on bt.BatchId = c.BatchId
where c.CaseId is null;
 
10. Orders and their fulfillment status alongside payment status
-- (multi-table join, order-level view)
select o.OrderId, cu.Name as CustomerName, o.OrderStatus, i.PaymentStatus, i.PaymentMethod
from Orders o
inner join Customers cu on o.CustomerId = cu.CustomerId
left join Invoices i on o.OrderId = i.OrderId
order by o.OrderDate desc;
