*********************************************************;
* Activity 4.05                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;
 
proc cas;
    simple.freq result=freqs/
       table={caslib="casuser", 
              name="heart",
              where="DeathCause is not null"},
       input={"BP_Status"};
    fTab=freqs.Frequency;
    
    print fTab.compute({"Pct","Population Percentage",percent6.2},
                        Frequency/sum(            ))[,{1,2,6}];
quit;















*****************************;
* SOLUTION                  *;
*****************************;
/*
proc cas;
    simple.freq result=freqs/
       table={caslib="casuser", 
              name="heart",
              where="DeathCause is not null"},
       input={"BP_Status"};
    fTab=freqs.Frequency;

    print fTab.compute({"Pct","Population Percentage",percent6.2},
                        Frequency/sum(fTab[,"Frequency"]))[,{1,2,6}];
quit;
*/