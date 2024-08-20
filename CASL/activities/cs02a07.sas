*********************************************************;
* Activity 2.07                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;
   
proc cas;
    libs={"casuser", "formats", "samples"};
* Complete the loop *;
      table.tableInfo / caslib=x;
    end;
quit;
















*****************************;
* SOLUTION                  *;
*****************************;
/*
proc cas;
    libs={"casuser", "formats", "samples"};
*Complete the loop*;
    do x over libs;
      table.tableInfo / caslib=x;
    end;
quit;
*/