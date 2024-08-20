*********************************************************;
* Demo: Comparing SAS Compute Server and CAS Server     *;
*       Processing Speeds                               *;
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

* Set paths *;
%let homedir=%sysget(HOME);
%let path=&homedir/Courses/PGVY;

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
/* Reset the SAS Session             */
/* Options > Reset SAS session       */
/*************************************/ 



/*************************************/
/* CAS Server with CAS-enabled PROCS */
/*************************************/

* Start timer *;
%let _timer_start = %sysfunc(datetime());  

* Set paths *;
%let homedir=%sysget(HOME);
%let path=&homedir/Courses/PGVY;

cas mySession sessopts=(caslib=casuser timeout=1800);
libname casuser cas caslib = 'casuser';

title "CAS-Enabled PROCS";

proc casutil;
   load casdata="orders_hd.sashdat" incaslib="casuser"
        outcaslib="casuser" casout="orders" replace; 
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

cas mySession terminate;
