*********************************************************;
* Activity 3.04                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

proc casutil;
    load data=
;
quit;


proc cas;
    table.tableInfo / caslib="casuser";
quit;















*****************************;
* SOLUTION                  *;
*****************************;
/*
proc casutil;
    load data=sashelp.class
         casout="class"
         outcaslib="casuser"
         replace;
quit;
*/