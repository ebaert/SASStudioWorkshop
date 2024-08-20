*********************************************************;
* Demo: Loading Server-Side Files into CAS              *;
*********************************************************;

* View available data source files and in-memory tables in the Casuser caslib *;
proc casutil incaslib='casuser';
	list files;
	list tables;
quit;


* Load the sales.csv server-side data source file into memory *;
proc casutil;
	load casdata='sales.csv' incaslib='casuser' 
         casout='sales' outcaslib='casuser';
quit;


* View available data source files and in-memory tables in the Casuser caslib *;
proc casutil incaslib='casuser';
	list files;
	list tables;
quit;


* Load the orders_hd.sashdat server-side file into memory *;
proc casutil;
	load casdata='orders_hd.sashdat' incaslib='casuser' 
         casout='orders' outcaslib='casuser';

	list tables incaslib='casuser';
quit;


* Display table metadata such as column names and data types for files or in-memory tables *;
proc casutil;
	contents casdata='orders' incaslib='casuser';
quit;


* Use the CONTENTS procedure to generate a similar report *;
proc contents data=casuser._all_ nods;
run;

proc contents data=casuser.orders varnum;
run;


* Use the MEANS procedure on the orders CAS table *;
proc means data=casuser.orders;
	var RetailPrice Cost;
run;


***********************************************************************;
* Load the orders_hd.parquet file from the Casuser caslib into memory *;
***********************************************************************;

* List available server-side files in the Casuser caslib. Confirm the orders.parquet file exists. *;
proc casutil;
	list files incaslib='casuser';
quit;

* Load the orders.parquet server-side file *;
proc casutil;
	load casdata='orders.parquet' incaslib='casuser' 
         casout='orders_parquet' outcaslib='casuser';

	list tables incaslib='casuser';
quit;


* Load the orders.parquet file from the Casuser caslib into the Public caslib *;
proc casutil;
	load casdata='orders.parquet' incaslib='casuser' 
         casout='orders_parquet' outcaslib='public';

	list tables incaslib='public';
quit;