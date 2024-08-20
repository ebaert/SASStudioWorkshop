*********************************************************;
* Activity 4.03                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

proc cas;
	simple.summary result=rs/
	   table={caslib="casuser", name="cars"},
	   input={"MSRP"},
	   subSet={"MAX", "MEAN", "MIN", "N", "NMISS", "VAR"};
quit;















*****************************;
* SOLUTION                  *;
*****************************;
/* 
proc cas;
	simple.summary result=rs/
	   table={caslib="casuser", name="cars"},
	   input={"MSRP"},
	   subSet={"MAX", "MEAN", "MIN", "N", "NMISS", "VAR"};
	describe rs;
quit;
*/