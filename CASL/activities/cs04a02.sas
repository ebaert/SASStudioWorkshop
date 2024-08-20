*********************************************************;
* Activity 4.02                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

proc cas;

run;















*****************************;
* SOLUTION                  *;
*****************************;
/*
proc cas;
    table.fetch /
       table={name="heart", 
              caslib="casuser",
              where="Status='Alive'"
       },
       to=5;
run;
*/