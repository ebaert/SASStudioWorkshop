*******************************************************;
* Lesson 5 Section 3 - Data Preparation Actions       *;
*******************************************************;
* - Using the DataStep CAS Action                     *;
* - Altering Table Metadata                           *;
* - Imputing Missing Values                           *;
* - Transpose Action                                  *;
* - Dynamically Removing Outliers                     *;
*******************************************************;

*******************************************************;
* Load the cars_raw.sas7bdat table                    *;
*******************************************************;
proc cas;
    lib="casuser";
    upload path="&path/data/my_data/cars_raw.sas7bdat"
           casout={name="cars_raw", 
                   caslib=lib, 
                   replace=TRUE
           };
    table.tableInfo / caslib=lib;
quit;



*******************************************************;
* Using the DataStep CAS Action                       *;
*******************************************************;

* runCode action *;
proc cas;
    dataStep.runCode /
        code=
             "
             data casuser.cars_clean;
                set casuser.cars_raw;
                Origin=propcase(Origin,' ');
                Model=strip(Model);
             run;
             "
;
quit;   


* runCode action with the SOURCE statement *;
proc cas;
* Create the source variable *;
    source ds;
        data casuser.cars_clean;
            set casuser.cars_raw;
            Origin=propcase(Origin,' ');
            Model=strip(Model);
        run;
    endsource;

* Apply the source variable to runCode *;
    dataStep.runCode /
        code=ds;        
quit;



*******************************************************;
* Altering Table Metadata                             *;
*******************************************************;

* Create a copy of cars_raw and name it cars_raw2 *;
proc cas;
    cars_raw={name="cars_raw", caslib="casuser"};
    cars_raw2={name="cars_raw2", caslib="casuser"};

    table.copyTable /
        table=cars_raw,
        casOut=cars_raw2 || {replace=TRUE};

    table.tableInfo / caslib=cars_raw2.caslib;
quit;


* Modify the name, label and drop columns *;
proc cas;
    table.alterTable /
        name="cars_raw2", caslib="casuser",
        rename="cars_raw_copy",
        label="Copy of the cars_raw table with less columns", 
        drop={"DriveTrain", "MSRP", "Origin"};

    table.tableInfo / caslib="casuser";
quit;


* View the column information of the cars_raw_copy table *;
proc cas;
    table.columnInfo /
       table={name="cars_raw_copy", caslib="casuser"};
quit;


* Modify the attributes of the Invoice column *;
proc cas;
    table.alterTable /
        name="cars_raw_copy", caslib="casuser",
        columns={
              {name="Invoice", label="Car Invoice Price", format="dollar14.2"}
        };

    table.columnInfo /
       table={name="cars_raw_copy", caslib="casuser"};
quit;
    


*******************************************************;
* Imputing Missing Values                             *;
*******************************************************;
* N/A *;



*******************************************************;
* Transposing Table                                   *;
*******************************************************;
* Create a wide table *;
data casuser.profits_wide;
    call streaminit(999);
    do Country="US","CA","GR","PT";
        do Region="A","B","C";
        Year2018=round(rand('uniform',100000,2000000),.01);
        Year2019=round(rand('uniform',100000,2000000),.01);
        Year2020=round(rand('uniform',100000,2000000),.01);
        output;
        end;
    end;
    format Year: dollar14.2;
run; 

proc print data=casuser.profits_wide;
run;



*******************************************************;
* Dynamically Removing Outliers                       *;
*******************************************************;
* N/A *;