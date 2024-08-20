**********************************************************************;
* Demo: Modifying Foundation SAS Procedures to Run in CAS            *;
*   NOTE: If you have not setup the Autoexec file in                 *;
*         SAS Studio, open and submit startup.sas first.             *;
**********************************************************************;

* Confirm the ORDERS table is available in CAS*;
proc casutil incaslib = 'casuser';
	list tables;
quit;


/* Uncomment and run this step if ORDERS is not loaded to the CASUSER caslib */
/* proc casutil; */
/*    droptable casdata="orders" incaslib="casuser" quiet; */
/*    load casdata="orders_hd.sashdat" incaslib="casuser"  */
/*         outcaslib="casuser" casout="orders" promote; */
/* quit; */


*****************************;
* Run FREQ in CAS           *;
*****************************;

* Modify PROC FREQ to run in CAS *;
proc freq data=casuser.orders;
	tables Customer_Group;
quit;



*****************************;
* Append Data in CAS        *;
*****************************;

* (error) Append a SAS data set to a CAS table *;
proc append base=casuser.orders
			data=pvbase.orders_new;
quit;


* Load the client-side SAS data set into CAS *;
proc casutil;
	load data=pvbase.orders_new
		 casout='orders_new' outcaslib='casuser' replace;

	list tables incaslib='casuser';
quit;

* Append the CAS tables *;
data casuser.orders(append=yes);
    set casuser.orders_new;
run;



*****************************;
* Plot Large CAS Tables     *;
*****************************;
* Create a bar chart of a CAS table by modifying the DATALIMIT= option *;
proc sgplot data=casuser.orders;
	vbar Customer_Group;
run;



* Summarize the data in the CAS server and create a smaller, summarized table *;
proc freqtab data=casuser.orders;
	tables Customer_Group /	out=casuser.customer_groups;
quit;

* Plot the smaller 3 row CAS table *;
proc sgplot data=casuser.customer_groups;
	vbar Customer_Group / response=Count;
run;



*******************************;
* Reload the ORDERS CAS table *;
*******************************;
* Delete and reupload the ORDERS CAS table to remove the appened rows *;
proc casutil;
   droptable casdata="orders" incaslib="casuser" quiet;
   load casdata="orders_hd.sashdat" incaslib="casuser" 
        outcaslib="casuser" casout="orders" promote;
quit;