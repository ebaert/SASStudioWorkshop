*********************************************************;
* Activity 3.07                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

proc cas;
    table.tableInfo / caslib="casuser";
quit;


* Load SASHELP.BASEBALL if necessary *;
/*
proc casutil;
    load data=sashelp.baseball
         casout="baseball"
         outcaslib="casuser";
quit;
*/


proc cas;
    table.dropTable /
          caslib="", name="";

    table.tableInfo / caslib="casuser";
quit;















*****************************;
* SOLUTION                  *;
*****************************;
/*
proc cas;
    table.dropTable /
          caslib="casuser", name="baseball";

    table.tableInfo / caslib="casuser";
quit;
*/