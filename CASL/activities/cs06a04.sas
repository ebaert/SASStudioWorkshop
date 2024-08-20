*********************************************************;
* Activity 6.04                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

proc cas;
    heart={name="heart", caslib="casuser"};

* Preview the first five rows *;
    table.fetch / 
       table=heart,
       to=5,
       fetchVars={"Chol_Status", "BP_Status", "Smoking_Status"}
       index=FALSE;

* View the column information *;
    table.columnInfo / table=heart;
quit;


proc cas;
    heart={name="heart", caslib="casuser"};
    freqTab.freqTab /
        table=heart,
        tabulate={
              {vars={"Chol_Status","BP_Status","Smoking_Status"}}  
        };
quit;














*****************************;
* SOLUTION                  *;
*****************************;
/*
proc cas;
    heart={name="heart", caslib="casuser"};
    freqTab.freqTab /
        table=heart,
        tabulate={
              {vars={"Chol_Status","BP_Status","Smoking_Status"}}  
        },
        tabDisplay="LIST";
quit;
*/
