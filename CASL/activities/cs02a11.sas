*********************************************************;
* Activity 2.11                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;
   
proc cas;
    tbl={name="cars", caslib="casuser"};
    describe tbl;
    simple.numRows / table=tbl;
quit;
















*****************************;
* SOLUTION                  *;
*****************************;
/*
* Bracket notation *;
proc cas;
    tbl={name="cars", caslib="casuser"};
    tbl["where"]="MSRP < 20000";
    describe tbl;
    simple.numRows / table=tbl;
quit;

* Dot notation *;
proc cas;
    tbl = {name="cars", caslib="casuser"};
    tbl.where="MSRP < 20000";
    describe tbl;
    simple.numRows / table=tbl;
quit;

* Concatenation Operator *;
proc cas;
    tbl={name="cars", caslib="casuser"};
    tbl=tbl || {where="MSRP < 20000"};
    describe tbl;
    simple.numRows / table=tbl;
quit;
*/