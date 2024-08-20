*********************************************************;
* Activity 8.02                                         *;
*   NOTE: If you have not setup the Autoexec file in    *;
*         SAS Studio, open and submit startup.sas first.*;
*********************************************************;

* Reset the SAS session (Options > Reset SAS session) to clear the pvcas caslib *;


* Loading an Excel file can take up to a minute *;
proc cas;
    table.addCaslib / 
        name="pvcas" path="&path/data";
    table.loadTable / 
        path="customers.xlsx" caslib="pvcas",
        casout={caslib="casuser", name="custFrance", 
                replace="true"},
	    where="Country='France'";
    table.tableDetails / 
        caslib="casuser", name="custFrance";
quit;
