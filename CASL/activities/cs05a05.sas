*********************************************************;
* Activity 5.05                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

data casuser.datatypes;
    date_char="18JUN2019";
    output;
    date_char="03NOV2020";
    output;
run;


proc cas;
    tbl={name="datatypes", caslib="casuser"};
    table.fetch / 
       table=tbl,
       index=False;
    table.columnInfo / table=tbl;
quit;


proc cas;
    outTbl={name="converted", caslib="casuser"};

* Convert column data type *;
    table.copyTable /
        table={name="datatypes", caslib="casuser",
               computedVars={
                           {name="date_num"}
               }
               computedVarsProgram=/*Convert the date_char character column*/
         },
         casOut=outTbl || {replace=TRUE};

* Preview table *;
    table.fetch / 
       table=outTbl,
       index=False;
    table.columnInfo / table=outTbl; 
quit;

  













 
*****************************;
* SOLUTION                  *;
*****************************;
/*
proc cas;
    outTbl={name="converted", caslib="casuser"};

* Convert column data type *;
    table.copyTable /
        table={name="datatypes", caslib="casuser",
               computedVars={
                           {name="date_num"}
               }
               computedVarsProgram="date_num=inputn(date_char,'anydtdte.');"
         },
         casOut=outTbl || {replace=TRUE};

* Preview table *;
    table.fetch / 
       table=outTbl,
       index=False;
    table.columnInfo / table=outTbl; 
quit;
*/
