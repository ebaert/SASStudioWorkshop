*********************************************************;
* Activity 4.09                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

%include "&path/data/load_heart_raw.sas";

proc cas;
    source myCode;
       if ageAtStart <= 35 then cohort="Younger";
         else if ageAtStart <= 55 then cohort="Mid Range";
         else cohort="Senior";
    endsource;

    table.copyTable /
        table={caslib="cs", name="heart_raw"
               computedVarsProgram=myCode,
               Vars={"ID","Cohort"}
        },
        casout={name="cohorts", caslib="cs", replace=TRUE};

    simple.freq/
       table={name="cohorts", caslib="cs"},
       inputs={"cohort"};
quit;















*****************************;
* SOLUTION                  *;
*****************************;
/* 
proc cas;
    source myCode;
       length cohort varchar(9);
       if ageAtStart <= 35 then cohort="Younger";
         else if ageAtStart <= 55 then cohort="Mid Range";
         else cohort="Senior";
    endsource;

    table.copyTable /
        table={caslib="cs", name="heart_raw"
               computedVarsProgram=myCode,
               Vars={"ID","Cohort"}
        },
        casout={name="cohorts", caslib="cs", replace=TRUE};

    simple.freq/
       table={name="cohorts", caslib="cs"},
       inputs={"cohort"};
quit;
*/