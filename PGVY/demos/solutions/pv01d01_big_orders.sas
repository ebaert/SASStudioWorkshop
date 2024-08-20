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

proc contents data=pvbase.bigOrders;
run;
title;

proc freq data=pvbase.bigOrders;
    tables Country OrderType;
run;

proc means data=pvbase.bigOrders;
    var RetailPrice;
    output out=bigOrders_sum;
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

cas mySession sessopts=(caslib=casuser timeout=1800);
libname casuser cas caslib = 'casuser';

/* bigOrders was loaded into memory in cre8data.sas. If it is no longer 
   in memory, uncomment the following statement. */
/* %include "/home/student/Courses/PGVY/data/load_bigOrders.sas"; */

title "CAS Server PROCS";

proc contents data=casuser.bigOrders;
run;
title;

proc freqtab data=casuser.bigOrders;
    table Country OrderType;
run;

proc mdsummary data=casuser.bigOrders;
    var RetailPrice;
    output out=casuser.bigOrders_sum;
run;

proc print data=casuser.bigOrders_sum;
run;

/* Stop timer */
data _null_;
  dur = datetime() - &_timer_start;
  put 30*'-' / ' TOTAL DURATION:' dur time13.2 / 30*'-';
run;



/*************************************/
/* Drop global scope table           */
/*************************************/
proc casutil;
	droptable casdata="bigOrders" incaslib="casuser" quiet;
quit;

/* Terminate CAS connection */
cas mySession terminate;