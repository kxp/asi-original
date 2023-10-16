-- add extension for uuid
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- creates the store db
CREATE DATABASE "store_I_sb"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;


-- Connect to the new database
\c store_I_sb;


-- creates athe strore table

CREATE TABLE public.store
(
    store_id serial NOT NULL,
    name text,
    PRIMARY KEY (store_id)
);

ALTER TABLE IF EXISTS public.store
    OWNER to postgres;



-- creates the product table


CREATE TABLE public.product
(
    product_key uuid DEFAULT gen_random_uuid() NOT NULL,
    name text,
    description text,
    PRIMARY KEY (product_key)
);

ALTER TABLE IF EXISTS public.product
    OWNER to postgres;


-- creates the customer table, depends on the store 

CREATE TABLE public.customer
(
    nif integer NOT NULL,
    name text,
    address text,
    phone_number integer,
    store_key integer,
    -- fk defs
    PRIMARY KEY (nif),
    CONSTRAINT fk_store_key
      FOREIGN KEY(store_key) 
	  REFERENCES store(store_id) 
);

ALTER TABLE IF EXISTS public.customer
    OWNER to postgres;
    

-- creates the sale table

CREATE TABLE public.sale
(
    sale_key uuid DEFAULT gen_random_uuid() NOT NULL,
    purchase_time timestamp with time zone,
    purchase_amount numeric,
    store_key integer,
    customer_key integer,
    PRIMARY KEY (sale_key),
    -- store fk def
    CONSTRAINT fk_store_key
      FOREIGN KEY(store_key) 
	  REFERENCES store(store_id),
	-- customer fk def
	 CONSTRAINT fk_customer_key
      FOREIGN KEY(customer_key) 
	  REFERENCES customer(nif) 
);

ALTER TABLE IF EXISTS public.sale
    OWNER to postgres;

-- creates the sale item table

CREATE TABLE public.sale_item
(
    sale_item_key uuid DEFAULT gen_random_uuid() NOT NULL,
    sale_key uuid NOT NULL,
    product_key uuid NOT NULL,
    item_price numeric NOT NULL,
    PRIMARY KEY (sale_item_key),
    -- sale fk for the sale_key
    CONSTRAINT fk_sale_key
      FOREIGN KEY(sale_key) 
	  REFERENCES sale(sale_key),
    -- product fk for the product_key
    CONSTRAINT fk_product_key
      FOREIGN KEY(product_key) 
	  REFERENCES product(product_key)
);

ALTER TABLE IF EXISTS public.sale_item
    OWNER to postgres;

-- creates the store_product table

CREATE TABLE public.store_product
(
    store_product_key uuid DEFAULT gen_random_uuid() NOT NULL,
    product_key uuid NOT NULL,
    store_id integer NOT NULL,
    price numeric,
    PRIMARY KEY (store_product_key),
    -- sale fk for the store_key
    CONSTRAINT fk_store_id
      FOREIGN KEY(store_id) 
	  REFERENCES store(store_id),
    -- product fk for the product_key
    CONSTRAINT fk_product_key
      FOREIGN KEY(product_key) 
	  REFERENCES product(product_key)
);

ALTER TABLE IF EXISTS public.store_product
    OWNER to postgres;