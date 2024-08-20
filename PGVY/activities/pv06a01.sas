*********************************************************;
* Activity 6.01                                         *;
*   NOTE: If you have not setup the Autoexec file in    *;
*         SAS Studio, open and submit startup.sas first.*;
*********************************************************;


* Confirm the ORDERS CAS table is in-memory *;
proc casutil;
	list tables incaslib='casuser';
quit;

/* Uncomment and run this step if ORDERS is not loaded to the CASUSER caslib */
/* proc casutil; */
/*    droptable casdata="orders" incaslib="casuser" quiet; */
/*    load casdata="orders_hd.sashdat" incaslib="casuser"  */
/*         outcaslib="casuser" casout="orders" promote; */
/* quit; */


proc freq data=casuser.orders;
	tables Customer_Group;
run;