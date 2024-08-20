*********************************************************;
* Activity 1.01                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

proc cas;
	table.tableInfo / caslib="casuser";
quit;