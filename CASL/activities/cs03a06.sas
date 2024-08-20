*********************************************************;
* Activity 3.06                                         *;
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
    table.save /
        table={name="baseball", caslib="casuser"},
        caslib="", name="", replace=TRUE;

    table.fileInfo / caslib="cs";
quit;















*****************************;
* SOLUTION                  *;
*****************************;
/*
proc cas;
    table.save /
        table={name="baseball", caslib="casuser"},
        caslib="cs", name="baseball.sashdat", replace=TRUE;

    table.fileInfo / caslib="cs";
quit;
*/