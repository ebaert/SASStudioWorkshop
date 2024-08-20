*********************************************************;
* Activity 2.01                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

proc casutil incaslib="casuser";
    load data=sashelp.airline 
         outcaslib="casuser" casout="airline" replace; 
    list files;
    list tables;
quit;

proc contents data=casuser.airline;
run;

proc means data=casuser.airline;
    var Air;
    class Region;
run;















*****************************;
* SOLUTION                  *;
*****************************;
/*
cas conn listhistory 5;
*/