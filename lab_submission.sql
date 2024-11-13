-- (i) A Procedure called PROC_LAB5
CREATE PROCEDURE PROC_LAB5
AS
BEGIN
    CREATE TABLE #CustomerRevenue (
        CustomerID INT,
        TotalRevenue DECIMAL(10,2)
    );

    INSERT INTO #CustomerRevenue (CustomerID, TotalRevenue)
    SELECT 
        o.CustomerID, 
        SUM(od.Quantity * od.Price) AS TotalRevenue
    FROM 
        Orders o
    INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
    GROUP BY o.CustomerID;

    SELECT 
        c.CustomerName, 
        cr.TotalRevenue
    FROM 
        Customers c
    INNER JOIN #CustomerRevenue cr ON c.CustomerID = cr.CustomerID
    ORDER BY cr.TotalRevenue DESC;

    DROP TABLE #CustomerRevenue;
END;


-- (ii) A Function called FUNC_LAB5

CREATE FUNCTION FUNC_LAB5(@ProductID INT)
RETURNS INT
AS
BEGIN
    DECLARE @TotalQuantity INT;

    SELECT @TotalQuantity = SUM(od.Quantity)
    FROM OrderDetails od
    WHERE od.ProductID = @ProductID;

    RETURN @TotalQuantity;
END;

-- (iii) A View called VIEW_LAB5
CREATE VIEW VIEW_LAB5
AS
SELECT 
    o.OrderID, 
    c.CustomerName, 
    c.City, 
    o.OrderDate, 
    SUM(od.Quantity * od.Price) AS OrderTotal
FROM 
    Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.OrderID, c.CustomerName, c.City, o.OrderDate;