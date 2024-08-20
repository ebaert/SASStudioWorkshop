*********************************************************;
* Demo: Promoting CAS Tables                            *;
*********************************************************;

* Reset the SAS session (Options > Reset SAS session) *;


* View available  in-memory tables in the Casuser caslib *;
proc casutil incaslib='casuser';
	list files;
	list tables;
quit;



* Load the orders.parquet data source file into memory *;
proc casutil;
	load casdata='orders.parquet' incaslib='casuser'
		 casout='orders_session' outcaslib='casuser'; 

	* Confirm the orders_session CAS table is not promoted *;
	list tables incaslib='casuser';
quit;


* Go to Visual Analytics and try to access the ORDERS_SESSION CAS table. Notice that the table is not available. *;


* Load the orders.parquet data source file as global scope *;
proc casutil;
	load casdata='orders.parquet' incaslib='casuser'
		 casout='orders_global' outcaslib='casuser'
		 promote; 

	* Confirm the SALES_SESSION_SCOPE table is promoted *;
	list tables incaslib='casuser';
quit;


* Go to Visual Analytics and try to access the ORDERS_GLOBAL CAS table *;


* Terminate the CAS session *;
cas mySession terminate;


* Reset the SAS session (Options > Reset SAS session) *;


* View available CAS tables in the Casuser caslib *;
proc casutil incaslib='casuser';
	list tables;
quit;