*********************************************************;
* Activity 2.10                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;
   
proc cas;
    tbl = {name="cars", caslib="casuser", where="Make='Acura'"};
    print tbl;
quit;
















*****************************;
* SOLUTION                  *;
*****************************;
/*
* Bracket Notation *;
proc cas;
    tbl = {name="cars", caslib="casuser", where="Make='Acura'"};
    print tbl;
    describe tbl;
    print tbl["where"];
quit;

* Dot Notation *;
proc cas;
    tbl = {name="cars", caslib="casuser", where="Make='Acura'"};
    print tbl;
    describe tbl;
    print tbl.where;
quit;
*/