*********************************************************;
* Activity 5.06                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

proc cas;
    source ds;
         data casuser.car_id;
            set casuser.cars;
            MSRP=MSRP * .90;
            First_Letter=first(Make);
            keep First_Letter Make Model MSRP;
         run;
    endsource;

* Use the source code in the runCode action *;
    datastep.runCode / code=ds;

* Preview new table *;
    table.fetch / table={name="car_id", caslib="casuser"};
quit;
           













   
*****************************;
* SOLUTION                  *;
*****************************;
/*
proc cas;
    source ds;
         data casuser.car_id;
            set casuser.cars;
            MSRP=MSRP * .90;
            First_Letter=substr(Make,1,1);
            keep First_Letter Make Model MSRP;
         run;
    endsource;

* Use the source code in the runCode action *;
    datastep.runCode / code=ds;

* Preview new table *;
    table.fetch / table={name="car_id", caslib="casuser"};
quit;
*/
