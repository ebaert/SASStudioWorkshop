*********************************************************;
* Activity 5.03                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

* 1. Load and preview heart_raw.sashdat *;
proc cas;
* Create a dictionary with input and output information for the table *;
    heart_raw={name="heart_raw", 
               caslib="cs", 
               fileName="heart_raw.sashdat"
    };

* Load the heart_raw.sashdat file using the dictionary values *;
    table.loadTable /
         path=heart_raw.fileName,
         casout={name=heart_raw.name, 
                 caslib=heart_raw.caslib, 
                 replace=TRUE
         };

* Preview the table *;
    table.tableInfo / caslib=heart_raw.caslib;
    table.fetch / 
         table={name=heart_raw.name, 
                caslib=heart_raw.caslib
         };
quit;



* 2. Update a Column *;
proc cas;
* Create a dictionary with table information *;
    heart_raw={name="heart_raw", 
               caslib="cs", 
               where="DeathCause is null"
    }; 

* Update the table *; 
    table.update /
        table=heart_raw,
        set={
             {var=, value=} 
        };

* Preview the table for all rows where DeathCause is Unknown Cause *;
    heart_raw.where="DeathCause='Unknown Cause'";
    table.fetch / 
        table=heart_raw, 
        to=5;
quit;
















*****************************;
* SOLUTION                  *;
*****************************;
/*
proc cas;
* Create a dictionary with table information *;
    heart_raw={name="heart_raw", 
               caslib="cs", 
               where="DeathCause is null"
    }; 

* Update the table *; 
    table.update /
        table=heart_raw,
        set={
             {var="DeathCause", value="'Unknown Cause'"} 
        };

* Preview the table for all rows where DeathCause is Unknown Cause *;
    heart_raw.where="DeathCause='Unknown Cause'";
    table.fetch / 
        table=heart_raw, 
        to=5;
quit;
*/