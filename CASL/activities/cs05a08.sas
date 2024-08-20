*********************************************************;
* Activity 5.08                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

proc cas;
    source q;
        create table heart_alive as
           select *
             from casuser.heart
             where Status="Alive";
    endsource;

    fedSQL.execDirect / 
          query=q;
quit;


*****************************;
* SOLUTION                  *;
*****************************;
/*
proc cas;
    source q;
        create table heart_alive as
           select *
             from casuser.heart
             where Status='Alive';
    endsource;

    fedSQL.execDirect / 
          query=q;
quit;
*/