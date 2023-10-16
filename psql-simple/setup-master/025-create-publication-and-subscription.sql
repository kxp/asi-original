
-- Connect to the HEADQUARTERS
\c hq_db;


--STORE
-- Headquarters Publish the store table
CREATE PUBLICATION pubstore1 FOR TABLE store WHERE (store_id = 1);
CREATE PUBLICATION pubstore2 FOR TABLE store WHERE (store_id = 2);

--PRODUCT
-- Headquarters Publish the product table
CREATE PUBLICATION pubproduct1 FOR TABLE product (product_key, name, description);
CREATE PUBLICATION pubproduct2 FOR TABLE product (product_key, name, description);

--STOREPRODUCT
-- Headquarters Publish the relation between stores and products with price 0 
CREATE PUBLICATION pubstoreproductforstore1 FOR TABLE store_product WHERE (store_id = 1);
CREATE PUBLICATION pubstoreproductforstore2 FOR TABLE store_product WHERE (store_id = 2);

SELECT pg_create_logical_replication_slot('substorestore1','pgoutput');
SELECT pg_create_logical_replication_slot('subproductstore1','pgoutput');
SELECT pg_create_logical_replication_slot('substoreproductstore1','pgoutput');

SELECT pg_create_logical_replication_slot('substorestore2','pgoutput');
SELECT pg_create_logical_replication_slot('subproductstore2','pgoutput');
SELECT pg_create_logical_replication_slot('substoreproductstore2','pgoutput');


-- Connect to Store1
\c store_I_sb;


-- In BD store_I_sb --> Store1 subscribe to store table

CREATE SUBSCRIPTION substorestore1 CONNECTION 'host=localhost dbname=hq_db user=postgres' PUBLICATION pubstore1 WITH (create_slot = false);

-- In BD store_I_sb --> Store1 subscribe to product table
CREATE SUBSCRIPTION subproductstore1 CONNECTION 'host=localhost dbname=hq_db user=postgres' PUBLICATION pubproduct1 WITH (create_slot = false);

-- In BD store_I_sb --> Store1 subscribe to storeproduct table
CREATE SUBSCRIPTION substoreproductstore1 CONNECTION 'host=localhost dbname=hq_db user=postgres' PUBLICATION pubstoreproductforstore1 WITH (create_slot = false);

--CUSTOMER
-- In BD store_I_sb --> Store1 publish the Customer table
CREATE PUBLICATION pubcustomerstore1 FOR TABLE customer (nif, name, address, store_key);

---SALE
-- In BD store_I_sb --> Store1 publish the Sale table
CREATE PUBLICATION pubsalestore1 FOR TABLE sale;

--SALEITEM
-- In BD store_I_sb --> Store1 publish the SaleItem table
CREATE PUBLICATION pubsaleitemstore1 FOR TABLE sale_item;

SELECT pg_create_logical_replication_slot('subcustomerstore1','pgoutput');
SELECT pg_create_logical_replication_slot('subsalestore1','pgoutput');
SELECT pg_create_logical_replication_slot('subsaleitemstore1','pgoutput');




-- Connect to Store2
\c store_II_sb;


-- In BD store_II_sb --> Store2 subscribe to store table
CREATE SUBSCRIPTION substorestore2 CONNECTION 'host=localhost dbname=hq_db user=postgres' PUBLICATION pubstore2 WITH (create_slot = false);

-- In BD store_II_sb --> Store2 subscribe to product table
CREATE SUBSCRIPTION subproductstore2 CONNECTION 'host=localhost dbname=hq_db user=postgres' PUBLICATION pubproduct2 WITH (create_slot = false);

-- In BD store_II_sb --> Store2 subscribe to storeproduct table
CREATE SUBSCRIPTION substoreproductstore2 CONNECTION 'host=localhost dbname=hq_db user=postgres' PUBLICATION pubstoreproductforstore2 WITH (create_slot = false);

--CUSTOMER
-- In BD store_II_sb --> Store2 publish the Customer table
CREATE PUBLICATION pubcustomerstore2 FOR TABLE customer (nif, name, address, store_key);

--SALE
-- In BD asi_store2 --> Store2 publish the Sale table
CREATE PUBLICATION pubsaleStore2 FOR TABLE sale;

--SALEITEM
-- In BD asi_store2 --> Store2 publish the SaleItem table
CREATE PUBLICATION pubsaleitemstore2 FOR TABLE sale_item;


SELECT pg_create_logical_replication_slot('subcustomerstore2','pgoutput');
SELECT pg_create_logical_replication_slot('subsalestore2','pgoutput');
SELECT pg_create_logical_replication_slot('subsaleitemstore2','pgoutput');


-- Connect to the HEADQUARTERS
\c hq_db;


-- Headquarters Subcribes the customer table from Store1 and Store2
CREATE SUBSCRIPTION subcustomerstore1 CONNECTION 'host=localhost dbname=store_I_sb user=postgres' PUBLICATION pubcustomerstore1 WITH (create_slot = false);
CREATE SUBSCRIPTION subcustomerstore2 CONNECTION 'host=localhost dbname=store_II_sb user=postgres' PUBLICATION pubcustomerstore2 WITH (create_slot = false);
-- Headquarters Subcribes the Sale table from Store1 and Store2
CREATE SUBSCRIPTION subsalestore1 CONNECTION 'host=localhost dbname=store_I_sb user=postgres' PUBLICATION pubsalestore1 WITH (create_slot = false);
CREATE SUBSCRIPTION subsalestore2 CONNECTION 'host=localhost dbname=store_II_sb user=postgres' PUBLICATION pubsalestore2 WITH (create_slot = false);
 -- Headquarters Subcribes the SaleItem table from Store1 and Store2
CREATE SUBSCRIPTION subsaleitemstore1 CONNECTION 'host=localhost dbname=store_I_sb user=postgres' PUBLICATION pubsaleitemstore1 WITH (create_slot = false);
CREATE SUBSCRIPTION subsaleitemstore2 CONNECTION 'host=localhost dbname=store_II_sb user=postgres' PUBLICATION pubsaleitemstore2 WITH (create_slot = false);
 






