*********************************************************;
* Saving CAS Tables as Data Source Files in a Caslib    *;
*   NOTE: If you have not setup the Autoexec file in    *; 
*         SAS Studio, open and submit startup.sas first.*;
*********************************************************;

* Load a subset of the orders_hd.sashdat server-side file into CAS *;
proc casutil;
    load casdata='orders_hd.sashdat' incaslib='casuser'
		 casout='orders_filtered' outcaslib='casuser'
		 label='Orders filtered by internet/catalog customers'
		 where='upcase(Customer_Group) = "INTERNET/CATALOG CUSTOMERS"'
	     vars=('Customer_Group' 'Order_ID' 'RetailPrice' 'Cost')
         replace;

	list tables incaslib='casuser';
quit;


* Save the CAS table as a SASHDAT file *;
proc casutil;
	save casdata='orders_filtered' incaslib='casuser'
		 casout='orders_subset.sashdat' outcaslib='casuser';

	list files incaslib='casuser';
quit;


* Save the CAS table as a PARQUET and CSV file *;
proc casutil incaslib='casuser' outcaslib='casuser';

	* Save as a PARQUET file *;
	save casdata='orders_filtered' 
		 casout='orders_subset.parquet';

	* Save as a CSV file *;
	save casdata='orders_filtered' 
		 casout='orders_subset.csv';

	list files;
quit;



* Delete the data source files that were created in this demo *;
proc casutil incaslib='casuser';
	deletesource casdata='orders_subset.sashdat';
	deletesource casdata='orders_subset.parquet';
	deletesource casdata='orders_subset.csv';

	list files;
quit;