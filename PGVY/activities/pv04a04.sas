*********************************************************;
* Activity 4.04                                         *;
*   NOTE: If you have not setup the Autoexec file in    *; 
*         SAS Studio, open and submit startup.sas first.*;
*********************************************************;

proc casutil;
    load data=pvbase.orders 
         casout="orders_loadbase" outcaslib='casuser' replace;
quit;

proc casutil;
    load casdata="orders_hd.sashdat" incaslib='casuser'
         casout="orders_loadhdat" outcaslib='casuser' replace;
quit;