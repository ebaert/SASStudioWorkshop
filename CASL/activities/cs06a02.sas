*********************************************************;
* Activity 6.02                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

proc cas;
    heart={name="heart", caslib="casuser"};

* Preview the first five rows *;
    table.fetch / 
       table=heart,
       to=5,
       index=FALSE,
       fetchVars={"AgeAtStart", "Height", "Weight"};

* View the column information *;
    table.columnInfo / table=heart;
quit;


proc cas;
    heart={name="heart", caslib="casuser"};
    simple.summary /
        table=heart
	;
quit;














*****************************;
* SOLUTION                  *;
*****************************;
/*
proc cas;
    heart={name="heart", caslib="casuser"};
    simple.summary /
        table=heart,
        input={"AgeAtStart", "Height", "Weight"},
        subSet={"MEAN", "STD"};
quit;
*/
