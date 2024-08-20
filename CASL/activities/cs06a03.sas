*********************************************************;
* Activity 6.03                                         *;
*   NOTE: If you have not setup the Autoexec file in    *;
*         SAS Studio, open and submit startup.sas first.*;
*********************************************************;

proc cas;
    heart={name="heart", caslib="casuser"};
    table.fetch / 
       table=heart,
       index=FALSE;
quit;


proc cas;
    heart={name="heart", caslib="casuser"};
    aggregation.aggregate /
        table=heart,
        varSpecs={
            {name="Cholesterol", agg="Median"}
        };
quit;















*****************************;
* SOLUTION                  *;
*****************************;
/*
proc cas;
    heart={name="heart", caslib="casuser"};
    aggregation.aggregate /
        table=heart,
        varSpecs={
            {name="Cholesterol", agg="Median"},
            {name="Cholesterol", subSet={"MIN","MEAN","MAX"}}
        };
quit;
*/

