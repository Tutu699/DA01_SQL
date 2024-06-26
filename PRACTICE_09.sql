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
ALTER COLUMN status TYPE varchar 
  
ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN productline TYPE varchar 

ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN customername TYPE varchar 

ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN addressline1 TYPE varchar

ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN city TYPE varchar

ALTER TABLE sales_dataset_rfm_prj 
ALTER COLUMN state TYPE varchar

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
SET QTR_ID = EXTRACT(QUARTER FROM orderdate);

ALTER TABLE sales_dataset_rfm_prj 
ADD COLUMN MONTH_ID TEXT
UPDATE sales_dataset_rfm_prj 
SET MONTH_ID = EXTRACT(MONTH FROM orderdate);

ALTER TABLE sales_dataset_rfm_prj 
ADD COLUMN YEAR_ID TEXT
UPDATE sales_dataset_rfm_prj 
SET YEAR_ID = EXTRACT(YEAR FROM orderdate);

5.
with min_max as
(select 
Q1-1.5*IQR as min_value
Q3+1.5*IQR as max_value
from (select 
percentile_cont(0.25) within group (order by quantityordered) as Q1,
percentile_cont(0.75) within group (order by quantityordered) as Q3,
percentile_cont(0.75) within group (order by quantityordered) - percentile_cont(0.25) within group (order by quantityordered) as IQR,
percentile_cont(0.25) within group (order by quantityordered) 
from sales_dataset_rfm_prj) as a)

select * from sales_dataset_rfm_prj
where quantityordered<(select min_value from min_max)
or quantityordered<(select max_value from min_max)








