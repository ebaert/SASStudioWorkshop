*********************************************************;
* Activity 3.05                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

proc casutil;
    load data=sashelp.baseball
         casout="baseball"
         outcaslib="casuser"
         replace;
quit;


proc cas;
    table.tableInfo / caslib="casuser";
quit;















*****************************;
* SOLUTION                  *;
*****************************;
/*
proc casutil;
    load data=sashelp.baseball
         casout="baseball"
         outcaslib="casuser"
         promote;
quit;



* Code to drop the table if necessary *;
proc cas;
    table.dropTable / name="baseball", caslib="casuser";
quit;
*/