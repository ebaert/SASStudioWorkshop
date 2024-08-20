*********************************************************;
* Activity 5.02                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

proc cas;
    lib="casuser";
    upload path=""
           casout={name="cars_raw", 
                   caslib=lib, 
                   replace=TRUE
           };
    table.tableInfo / caslib=lib;
quit;















*****************************;
* SOLUTION                  *;
*****************************;
/*
proc cas;
    lib="casuser";
    upload path="&path/data/my_data/cars_raw.sas7bdat"
           casout={name="cars_raw", 
                   caslib=lib, 
                   replace=TRUE
           };
    table.tableInfo / caslib=lib;
quit;
*/