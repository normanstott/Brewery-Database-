# Brewery-Database-

**Brewery Operations Database**

A relational database design and analysis project modeling the full operations of a brewery — production, sales, staffing, and supply chain — with a set of analytical queries answering real business questions.

**The question**

Can a single relational schema support both day-to-day brewery operations (tracking batches, orders, and inventory) and business-level analysis (revenue, top customers, equipment maintenance, staffing)?

**Schema overview**

The database models 12+ interconnected entities across three operational areas:

- **Production**:** Beer, Batches, Equipment, Ingredients, Suppliers
- **Sales:** Customers, Orders, Invoices, Cases
- **Staffing:** Employees, and junction tables (EmployeeBatch, EquipmentBatch, IngredientBatch) linking staff, equipment, and ingredients to specific batches

Tables are built and populated through parameterized stored procedures rather than raw insert statements, keeping the schema easy to rebuild and repopulate with new data.

**Analytical queries**

10 queries covering joins, aggregation, filtering, and one window function.

1. Total revenue by beer style
2. Top customers by total order value
3. Unpaid or overdue invoices
4. Equipment currently needing service
5. Average batch size by beer style
6. ranked by number of batches worked
7. Ingredient usage by supplier
8. Beers with no orders yet (left join to surface unmatched rows)
9. Orders with combined fulfillment and payment status

**Tools used**

SQL Server (T-SQL), stored procedures, ERD design

**About**

Built by Norman Stott as a database design and SQL analysis portfolio project.
