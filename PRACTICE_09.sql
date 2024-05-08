1.
ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN priceeach TYPE numeric USING (trim(priceeach)::numeric)

ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN ordernumber TYPE numeric USING (trim(ordernumber)::numeric)

ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN quantityordered TYPE integer USING (quantityordered::integer)

ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN orderlinenumber TYPE integer USING (orderlinenumber::integer)

ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN sales TYPE numeric USING (trim(sales)::numeric)

ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN orderdate TYPE timestamp with time zone USING (trim(orderdate)::timestamp with time zone)

ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN productcode TYPE varchar

ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN status TYPE text 
  
ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN productline TYPE text 

ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN customername TYPE text 

ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN addressline1 TYPE text

ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN city TYPE text

ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN state TYPE text

ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN country TYPE text

ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN territory TYPE text

ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN contactfullname TYPE text

ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN dealsize TYPE text

ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN productcode TYPE text

ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN phone TYPE text

ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN postalcode TYPE text

alter table sales_dataset_rfm_prj
alter addressline2 type text

ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN msrp TYPE numeric USING (trim(msrp)::numeric)
3. 
ALTER TABLE sales_dataset_rfm_prj 
ADD COLUMN  contactfirstname VARCHAR(50)
UPDATE sales_dataset_rfm_prj 
SET contactfirstname=SUBSTRING(contactfullname FROM 1 FOR (POSITION ('-' IN contactfullname)-1))

ALTER TABLE sales_dataset_rfm_prj 
ADD COLUMN contactlastname VARCHAR(50)
UPDATE sales_dataset_rfm_prj 
SET contactlastname=SUBSTRING(contactfullname FROM (POSITION ('-' IN contactfullname)+1) FOR LENGTH(contactfullname))
4.
ALTER TABLE sales_dataset_rfm_prj 
ADD COLUMN QTR_ID TEXT
UPDATE sales_dataset_rfm_prj 
SET QTR_ID = 
CASE
   WHEN EXTRACT(MONTH FROM orderdate) IN (1,2,3) THEN 'I'
   WHEN EXTRACT(MONTH FROM orderdate) IN (4,5,6) THEN 'II'
   WHEN EXTRACT(MONTH FROM orderdate) IN (7,8,9) THEN 'III'
   ELSE 'IV'
END;

ALTER TABLE sales_dataset_rfm_prj 
ADD COLUMN MONTH_ID TEXT
UPDATE sales_dataset_rfm_prj 
SET MONTH_ID = EXTRACT(MONTH FROM orderdate);

ALTER TABLE sales_dataset_rfm_prj 
ADD COLUMN YEAR_ID TEXT
UPDATE sales_dataset_rfm_prj 
SET YEAR_ID = EXTRACT(YEAR FROM orderdate);










