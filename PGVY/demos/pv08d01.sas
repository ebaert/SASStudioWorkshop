*********************************************************;
* Demo: Summarizing Data and Benchmarking with CASL     *;
*   NOTE: If you have not setup the Autoexec file in    *;
*         SAS Studio, open and submit startup.sas first.*;
*********************************************************;

/**************************************************************************************/
/* If you are following the video demonstration, the data has been changed from the   */
/* bigorders table to the orders table. The data size has been reduced for training   */
/* purposes. You will still see some performance gains on the CAS server with the     */
/* new data.                                                                          */
/**************************************************************************************/


/************************************/
/* Compute Server on Base SAS Table */
/************************************/

* Start timer *;
%let _timer_start = %sysfunc(datetime());  

title "Compute Server PROCS";

libname pvbase "&path/data";

proc contents data=pvbase.orders;
run;
title;

proc freq data=pvbase.orders;
    tables Country OrderType;
run;

proc means data=pvbase.orders;
    var RetailPrice;
    output out=orders_sum;
run;

/* Stop timer */
data _null_;
  dur = datetime() - &_timer_start;
  put 30*'-' / ' TOTAL DURATION:' dur time13.2 / 30*'-';
run;



/*************************************/
/* CAS Server with CAS-enabled PROCS */
/*************************************/

* Start timer *;
%let _timer_start = %sysfunc(datetime());  

title "CAS-Enabled PROCS";

libname casuser cas caslib='casuser';

proc casutil;
   load casdata="orders_hd.sashdat" incaslib="casuser"
        casout="orders" outcaslib="casuser" replace; 
   contents casdata="orders" incaslib="casuser";
quit;
title;

proc freqtab data=casuser.orders;
    table Country OrderType;
run;

proc mdsummary data=casuser.orders;
    var RetailPrice;
    output out=casuser.orders_sum;
run;

/* Stop timer */
data _null_;
  dur = datetime() - &_timer_start;
  put 30*'-' / ' TOTAL DURATION:' dur time13.2 / 30*'-';
run;



/* Reset the SAS session (Options > Reset SAS session) */

/************************/
/* CAS Server with CASL */
/************************/

* Start timer *;
%let _timer_start = %sysfunc(datetime());  

title "CASL Results";
proc cas;
    table.loadTable / 
        path="orders_hd.sashdat", caslib="casuser", 
        casOut={name="orders", 
                caslib="casuser", 
                replace=true};
    table.columnInfo / 
        table={name="orders", caslib="casuser"};
    simple.freq / 
        table={name="orders", caslib="casuser"}, 
        inputs={"Country", "OrderType"};
    simple.summary / 
        table={name="orders", caslib="casuser"}, 
        input={"RetailPrice"}, 
        casOut={name='orders_sum', replace=true};
quit;
title;

/* Stop timer */
data _null_;
  dur = datetime() - &_timer_start;
  put 30*'-' / ' TOTAL DURATION:' dur time13.2 / 30*'-';
run;