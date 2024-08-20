*********************************************************;
* Activity 3.02                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

proc cas;
    table.caslibInfo;
quit;















*****************************;
* SOLUTION                  *;
*****************************;
/*
proc cas;
    table.caslibInfo;
    table.fileInfo / caslib="cs";
    table.tableInfo / caslib="cs";
quit;
*/