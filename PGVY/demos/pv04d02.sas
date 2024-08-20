*********************************************************;
* Demo: Loading Client-Side Files into CAS              *;
*********************************************************;


* Use traditional SAS DATA step to create a SAS table in the WORK library *;
data work.cars_final;
	set sashelp.cars;
	MPG_Avg = mean(MPG_City, MPG_Highway);
	drop Weight;
	format MSRP dollar16.;
	label MPG_Avg = 'Miles Per Gallon Average';
run;


*******************************;
* PROC CASUTIL - SAS Library  *;
*******************************;

* Load the work.cars_final client-side SAS data set into memory using a SAS library *;
proc casutil;
	load data=work.cars_final
		  casout='cars_dataset_casutil' outcaslib='casuser'; 

	list tables incaslib='casuser';
quit;


*******************************;
* DATA STEP - Single Step     *;
*******************************;

* Prepare the CARS table and load it to CAS in a single DATA step *;
data casuser.cars_final_datastep;
	set sashelp.cars;
	MPG_Avg = mean(MPG_City, MPG_Highway);
	drop Weight;
	format MSRP dollar16.;
	label MPG_Avg = 'Miles Per Gallon Average';
run;

* View available CAS tables in the Casuser caslib *;
proc casutil incaslib='casuser';
	list tables;
quit;


*******************************;
* PROC CASUTIL - Path         *;
*******************************;

* Load the orders.csv client-side file into memory using the file path *;
proc casutil;
	load file="&path/data/orders.csv"
		 casout='orders_csv_casutil' outcaslib='casuser';

	list tables incaslib='casuser';
quit;



*******************************;
* PROC IMPORT                 *;
*******************************;
proc import datafile="&path/data/sales.xlsx"
			dbms=xlsx
			out=casuser.sales_proc_import_xlsx;
quit; 


proc casutil incaslib='casuser';
	list tables;
quit;

* Terminate the CAS session *;
cas mySession terminate;


* Reset the SAS Session - Options > Reset SAS session *;