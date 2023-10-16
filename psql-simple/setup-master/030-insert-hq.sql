-- Connect to the store_I_sb
\c hq_db;

-- Insert data into the store table
INSERT INTO public.store (name) VALUES
    ('Store Alfa'),
    ('Store Beta');

-- Insert data into the product table
INSERT INTO public.product (name, description) VALUES
    ('Potato', 'Legumes'),
    ('Orange', 'Fruits');

-- Insert data into the store_product table of store 1
INSERT INTO public.store_product (product_key, store_id) VALUES
    ((SELECT product_key FROM public.product WHERE name = 'Potato'), 1),
    ((SELECT product_key FROM public.product WHERE name = 'Orange'), 1);

-- Insert data into the store_product table of store 2
INSERT INTO public.store_product (product_key, store_id) VALUES
    ((SELECT product_key FROM public.product WHERE name = 'Potato'), 2),
    ((SELECT product_key FROM public.product WHERE name = 'Orange'), 2);
