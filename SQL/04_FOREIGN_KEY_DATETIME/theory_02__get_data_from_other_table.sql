USE OnlineStore;

SELECT * FROM Customer;
SELECT * FROM Orders;

SELECT
    order_id,
    (SELECT
            customer_name
        FROM
            Customer AS c
        WHERE
            c.customer_id = o.customer_id
        LIMIT 1) AS customer_name,
    product_name
FROM
    Orders AS o;
