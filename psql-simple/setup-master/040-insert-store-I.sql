-- Connect to the store_I_sb
\c store_I_sb;


--Ok so as we talked the following data should come from the replication 
/*
-- Insert data into the store table
INSERT INTO public.store (name) VALUES
    ('Store Alfa');

-- Insert data into the store table
INSERT INTO public.store (name) VALUES
    ('Store Alfa');

-- Insert data into the product table
INSERT INTO public.product (name, description) VALUES
    ('Potato', 'Legumes'),
    ('Orange', 'Fruits');

-- Insert data into the store_product table
INSERT INTO public.store_product (product_key, store_id, price) VALUES
    ((SELECT product_key FROM public.product WHERE name = 'Potato'), 1, 10.00),
    ((SELECT product_key FROM public.product WHERE name = 'Orange'), 1, 20.00);

*/



-- Data where hq is not owner

-- Insert data into the customer table
INSERT INTO public.customer (nif, name, address, phone_number, store_key) VALUES
    (123456789, 'Customer Alfa', 'Address 1', 111111111, 1);

-- Insert data into the sale table
INSERT INTO public.sale (purchase_time, purchase_amount, store_key, customer_key) VALUES
    ('2023-10-14 10:00:00', 1, 1, 123456789),
    ('2023-10-16 14:15:00', 4, 1, 123456789);
	
-- Insert data into the sale_item table
INSERT INTO public.sale_item (sale_key, product_key, item_price)
SELECT s.sale_key, p.product_key, 0
FROM public.sale s
JOIN public.customer c ON s.customer_key = c.nif
JOIN public.product p ON p.name in ('Potato', 'Orange')
JOIN public.store_product sp ON sp.product_key = p.product_key
WHERE c.nif = 123456789;

