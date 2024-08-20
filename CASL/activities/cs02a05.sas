*********************************************************;
* Activity 2.05                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

proc cas;
* CARS table *;
    table.fetch / table="cars", to=5;
    table.tableDetails / name="cars";
    table.columnInfo / table="cars";
* HEART table *;
    table.fetch / table="heart", to=5;
    table.tableDetails / name="heart";
    table.columnInfo / table="heart";
quit;















*****************************;
* SOLUTION                  *;
*****************************;
/*
proc cas;
* Set variables *;
    tbl1="cars";
    tbl2="heart";
    n=5;
* CARS table *;
    table.fetch / table=tbl1, to=n;
    table.tableDetails / name=tbl1;
    table.columnInfo / table=tbl1;
* HEART table *;
    table.fetch / table=tbl2, to=n;
    table.tableDetails / name=tbl2;
    table.columnInfo / table=tbl2;
quit;
*/