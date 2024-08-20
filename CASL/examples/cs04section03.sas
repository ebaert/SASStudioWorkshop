*******************************************************;
* Lesson 4 Section 3 - Validating Data                *;
*******************************************************;
* - Validating Data                                   *; 
* - Identifying and Isolating Duplicates              *;
* - Introduction to Table.copyTable                   *;
* - Subsetting Rows and Columns in CopyTable          *;
* - Using copyTable to Validate Data                  *;
*******************************************************;

*******************************************************;
* Validating Data                                     *;
*******************************************************;

* Load and explore the table *;
proc cas;
* load *;
    lib="casuser";
    tbl="cars_raw";
    upload path="&path/data/my_data/"||tbl||".sas7bdat",
           casOut={caslib=lib,
                   name=tbl,
                   replace=True};

* Preview rows *;
    table.fetch / 
        table={caslib="casuser", name="cars_raw"},
        index=false,
        to=5;

* View column attributes *;
    table.columnInfo result=ri / 
        table={caslib="casuser",   
               name="cars_raw"};
    
    print ri.columnInfo[,{"column","type"}];
quit;



*******************************************************; 
* Identifying and Isolating Duplicates                *;
*******************************************************;
proc cas;
    id={"Make","Model","DriveTrain"};
    sourceTbl={caslib="casuser",name="cars_raw",groupBy=id};
    clean={caslib="casuser",name="cars_clean",replace=TRUE};
    dups={caslib="casuser",name="cars_dups",replace=TRUE};
    
    deduplication.deduplicate / 
        table=sourceTbl,
        casOut=clean,
        duplicateOut=dups,
        noDuplicateKeys=TRUE;
quit;



*******************************************************;
* Introduction to Table.copyTable                     *;
*******************************************************;

* Calculated column with expression *;
proc cas;
    table.copyTable /
       table={caslib="casuser", name="cars_raw",
              computedVars={
                         {name="MPG_Avg", label="Average MPG"}
              },
              computedVarsProgram=
                            "MPG_Avg=mean(MPG_City,MPG_Highway);"
       },
       casout={caslib="casuser", name="cars_clean", replace=TRUE};

    table.fetch / table={caslib="casuser", name="cars_clean"};
quit;


* IF/THEN *;
proc cas;
    table.copyTable /
       table={caslib="casuser", name="cars_raw",
              computedVars={
                     {name="MPG_Avg", label="Average MPG"},
                     {name="Tier"}
              },
              computedVarsProgram=
                   "MPG_Avg=mean(MPG_City,MPG_Highway);
                    if Invoice < 30000 then Tier='Low Tier';
                       else Tier='High Tier';"
       },
       casout={caslib="casuser", name="cars_clean", replace=TRUE};

    table.fetch / table={caslib="casuser", name="cars_clean"};
quit;


* Using a SOURCE block *;
proc cas;
    source myCode;
        MPG_Avg=mean(MPG_City, MPG_Highway);
        if Invoice < 30000 then Tier='Low Tier';
           else Tier='High Tier';
    endsource;
    
    table.copyTable /
        table={caslib="casuser", name="cars_raw"
               computedVars={
                     {name="MPG_Avg", label="Average MPG"},
                     {name="Tier"}
               },
               computedVarsProgram=myCode
        },
       casout={caslib="casuser", name="cars_clean", replace=TRUE};

    table.fetch / table={caslib="casuser", name="cars_clean"};
quit;


* Using a SOURCE block with a LENGTH statement *;
proc cas;
    source myCode;
        length Tier varchar(9);
        MPG_Avg=mean(MPG_City, MPG_Highway);
        if Invoice < 30000 then Tier='Low Tier';
           else Tier='High Tier';
    endsource;
    
    table.copyTable /
        table={caslib="casuser", name="cars_raw"
               computedVars={
                     {name="MPG_Avg", label="Average MPG"},
                     {name="Tier"}
               },
               computedVarsProgram=myCode
        },
       casout={caslib="casuser", name="cars_clean", replace=TRUE};

    table.fetch / table={caslib="casuser", name="cars_clean"};
quit;



*******************************************************;
* Subsetting Rows and Columns in CopyTable            *;
*******************************************************;

proc cas;
    table.copyTable /
        table={caslib="casuser", name="cars_raw",
               computedVars={
                           {name="MPG_Avg", label="Average MPG"}
               },
               computedVarsProgram=
                       "MPG_Avg=mean(MPG_City,MPG_Highway);",
               vars={"Make","Model","MPG_Avg"},
               where="MPG_Avg>40"
        },
        casout={name="cars_highMPG", caslib="casuser", replace=TRUE};

    table.fetch / table={caslib="casuser", name="cars_highMPG"};
quit;



*******************************************************;
* Using copyTable to Validate Data                    *;
*******************************************************;

proc cas;
    source flagCode;
        if DriveTrain=propcase(DriveTrain) then badRow=0;
            else badRow=1;
    endsource;
    
    table.copyTable /
       table={caslib="casuser", name="cars_raw",
              computedVars={
                         {name="badRow",label="Bad Row"}
              },
              computedVarsProgram=flagCode,
              where="badRow=1"
       },
       casout={name="cars_badRows",caslib="casuser", replace=TRUE};

    table.fetch / table={caslib="casuser", name="cars_badRows"};
quit;