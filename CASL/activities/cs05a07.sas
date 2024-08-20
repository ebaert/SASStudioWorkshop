*********************************************************;
* Activity 5.07                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

* 1. Load and preview the heart_raw.sashdat table *;
proc cas;
    heart_raw={name="heart_raw", 
               caslib="cs", 
               fileName="heart_raw.sashdat"};
    table.loadTable /
         path=heart_raw.fileName,
         casout={name=heart_raw.name, 
                 caslib=heart_raw.caslib, 
                 replace=TRUE};
    table.columnInfo / 
         table={name=heart_raw.name, 
                caslib=heart_raw.caslib};
quit;


* 2. Complete the empty dictionary *;
proc cas;
    tbl={name="heart_raw", caslib="cs"};

* Add a label to the Diastolic column *;
    table.alterTable /
        name=tbl.name, caslib=tbl.caslib,
        columns={
               { }
        };

* View the column information *;
    table.columnInfo /
        table=tbl;
quit;















*****************************;
* SOLUTION                  *;
*****************************;
/*
proc cas;
    tbl={name="heart_raw", caslib="cs"};

* Add a label to the Diastolic column *;
    table.alterTable /
        name=tbl.name, caslib=tbl.caslib,
        columns={
               {name="Diastolic", label="Diastolic Pressure"}
        };

* View the column information *;
    table.columnInfo /
        table=tbl;
quit;
*/
