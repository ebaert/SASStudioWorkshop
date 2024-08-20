*********************************************************;
* Activity 4.07                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

proc cas;
    heartTbl={caslib="casuser",name="heart"};
    simple.distinct result=rd / 
       table=heartTbl;

    print rd.Distinct.where(!(Column like '%_Status') )
                      [,{"Column","NDistinct","NMiss"}];
quit;















*****************************;
* SOLUTION                  *;
*****************************;
/*
proc cas;
    heartTbl={caslib="casuser",name="heart"};
    simple.distinct result=rd / 
       table=heartTbl;

    print rd.Distinct.where((Column like '%_Status') )
                      [,{"Column","NDistinct"}];
quit;
*/