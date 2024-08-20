*********************************************************;
* Activity 3.03                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

proc cas;
    table.fileInfo / caslib="cs";
quit;


proc cas;
    lib="cs";

* Load a SASHDAT file *;
    table.loadTable /
         path=/*file-name*/, caslib=/*caslib-name*/,
         casout={caslib=lib,
                 replace=TRUE};

* Preview the CAS in-memory table *;
    table.tableInfo / caslib=lib;
quit;















*****************************;
* SOLUTION                  *;
*****************************;
/*
proc cas;
    lib="cs";

* Load a SASHDAT file *;
    table.loadTable /
         path="orders_clean.sashdat", caslib=lib,
         casout={caslib=lib,
                 replace=TRUE};

* Preview the CAS in-memory table *;
    table.tableInfo / caslib=lib;
quit;
*/