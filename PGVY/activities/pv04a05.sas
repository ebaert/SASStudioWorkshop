*********************************************************;
* Activity 4.05                                         *;
*   NOTE: If you have not setup the Autoexec file in    *; 
*         SAS Studio, open and submit startup.sas first.*;
*********************************************************;


* Load the orders_hd SAS data set into CAS if it doesn't exist *;
proc casutil;
    load casdata='orders_hd.sashdat' incaslib='casuser'
		 casout='orders_global' outcaslib='casuser';
quit;


* Drop the orders_global CAS table from the Casuser caslib *;
proc casutil;

quit;


* Terminate the CAS session *;
cas mySession terminate;







