*********************************************************;
* Activity 2.12                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;
   
proc cas;
    builtins.serverStatus result=r;
    describe r;
    print "-------------------";
quit;















*****************************;
* SOLUTION                  *;
*****************************;
/*
proc cas;
    builtins.serverStatus result=r;
    describe r;
    print "-------------------";
    tbl=r.server;
    describe tbl;
quit;
*/