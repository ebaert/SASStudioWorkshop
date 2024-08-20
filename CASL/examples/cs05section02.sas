*******************************************************;
* Lesson 5 Section 2 - Modifying Tables and Values    *;
*******************************************************;
* - Introduction                                      *;
* - Updating a Table in Place                         *;
* - Using Conditional Logic in the Update Action      *;
* - Creating a New In-Memory Table                    *;
* - Formatting Calculated Columns                     *;
* - Working with SAS Date and Time Values             *;
* - Data Type Conversion                              *;
*******************************************************;

*******************************************************;
* Introduction                                        *;
*******************************************************;

* Load the cars_raw.sas7bdat table *;
proc cas;
    lib="casuser";

* Upload the cars_raw table *;
    upload path="&path/data/my_data/cars_raw.sas7bdat",
           casout={name="cars_raw", 
                   caslib=lib, 
                   replace=TRUE
           };

* Preview casuser *;
    table.tableInfo / caslib=lib;
quit;



*******************************************************;
* Updating a Table in Place                           *;
*******************************************************;

* Update the Type column *;
proc cas;
    cars_raw={name="cars_raw", caslib="casuser"};

* Update table *;
    table.update /
        table=cars_raw,      
        set={
           {var="Type", value="upcase(Type)"} 
        };

* Preview table *;
    table.fetch / table=cars_raw;
quit;


* Update multiple columns *;
proc cas;
    cars_raw={name="cars_raw", caslib="casuser"};

* Update table *;
    table.update /
        table=cars_raw,      
        set={
           {var="Type", value="'Sedan'"},
           {var="Invoice", value="Invoice*1.05"},
           {var="Model", value="strip(Model)"}
        };

* Preview table *;
    table.fetch / table=cars_raw;
quit;



*******************************************************;
* Using Conditional Logic in the Update Action        *;
*******************************************************;

* Using conditional logic: IFC*;
proc cas;
    cars_raw={name="cars_raw", caslib="casuser"};

* Preview prior to update *;
    simple.freq / 
       table=cars_raw,
       input="Origin";

* Update table *;
    table.update /
        table=cars_raw,      
        set={ 
           {var="Origin", value="ifc(upcase(Origin)='USA', upcase(Origin), propcase(Origin))"}
        };

* After update *;
    simple.freq / 
       table=cars_raw,
       input="Origin";
quit;


* Using conditional logic: IFN*;
proc cas;
    cars_raw={name="cars_raw", caslib="casuser"};
    colNames={"Make", "Origin", "Invoice", "Model"};
    filter={where="Make in ('Toyota', 'Chevrolet', 'Acura')"};

* Before update *;
    table.fetch / 
       table=cars_raw || filter ,
       to=60,
       fetchVars=colNames;

* Update table *;
    table.update /
        table=cars_raw,      
        set={ 
           {var="Invoice", value="ifn(Make='Toyota', Invoice*.95, Invoice)"}
        };

* After update *;
    table.fetch / 
       table=cars_raw || filter,
       to=60,
       fetchVars=colNames;
quit;


* Update a subset of rows using the where subparameter *;
proc cas;
table.update /
    table={name="cars_raw", 
           caslib="casuser",
           where="Make='Toyota'"
    },     
    set={
       {var="Invoice", value="Invoice*.95"} 
    };
quit;



*******************************************************;
* Creating a New In-Memory Table                      *;
*******************************************************;

* Create multiple calculated columns (no format) *;
proc cas;
    table.copyTable /
        table={
             name="cars_raw",
             caslib="casuser",
             computedVars={
                         {name="MPG_Avg", label="MPG (Average)"}, 
                         {name="Discount", label="Holiday Discount"}
             },
             computedVarsProgram="
                                MPG_Avg=mean(MPG_City, MPG_Highway);
                                Discount=Invoice*.95;
                                 "
        },
    casout={name="cars_clean", caslib="casuser", replace=TRUE};

* Preview table *;
    table.fetch / table={name="cars_clean", caslib="casuser"};
quit;



*******************************************************;
* Formatting Calculated Columns                       *;
*******************************************************;

* Add a format to calculated columns *;
proc cas;
    table.copyTable /
        table={
             name="cars_raw",
             caslib="casuser",
             computedVars={
                         {name="MPG_Avg", label="MPG (Average)"}, 
                         {name="Discount", label="Holiday Discount", format="dollar14.2"} /* format */
             },
             computedVarsProgram="
                                MPG_Avg=mean(MPG_City, MPG_Highway);
                                Discount=Invoice*.95;
                                 "
        },
    casout={name="cars_clean", caslib="casuser", replace=TRUE};

* Preview table *;
    table.fetch / table={name="cars_clean", caslib="casuser"};
quit;



*******************************************************;
* Working with SAS Date and Time Values               *;
*******************************************************;
* N/A *;



*******************************************************;
* Data Type Conversion                                *;
*******************************************************;

* String variable *;
proc cas;
    x="$5,000.45";
    print x;
    describe x;
quit;


* INFORMAT no decimal specified *;
proc cas;
    x="$5,000.45";
    print x;
    describe x;
    
    x_num=inputn(x,'dollar9.');
    print x_num;
    describe x_num;
quit;


* INFORMAT decimal specified *;
proc cas;
    x="$5,000.45";
    print x;
    describe x;
    
    x_num=inputn(x,'dollar9.2');
    print x_num;
    describe x_num;
quit;


* Compare using a decimal in an informat and without *;
proc cas;
    vals={"$2,900","$800.5","$3,381.97","$25,500","$600.25"};
    do bonus over vals;
        no_d=inputn(bonus,"dollar15.");
        d=inputn(bonus,"dollar15.2");
        print "no_d = " no_d " --------- " "d = " d;
    end;
quit;