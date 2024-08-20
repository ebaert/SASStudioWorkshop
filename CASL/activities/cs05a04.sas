*********************************************************;
* Activity 5.04                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

* 1. Load and cars_raw.sas7bdat *;
proc cas;
    lib="casuser";
    upload path="&path/data/my_data/cars_raw.sas7bdat"
           casout={name="cars_raw", 
                   caslib=lib, 
                   replace=TRUE
           };
    table.tableInfo / caslib=lib;
quit;


* 2. Format a new calculated column *;
proc cas;
    table.copyTable /
        table={name="cars_raw",
               caslib="casuser",
               computedVars={
                           {name="InvoiceEuro", label="Invoice (Euro)"}
               },
               computedVarsProgram="InvoiceEuro=Invoice*.82;",
               vars={"Make", "Model", "Invoice", "InvoiceEuro"}
        },
        casOut={name="EuroPrices", caslib="casuser", replace=TRUE};

* Preview table *;
    table.fetch / 
        table={name="EuroPrices", caslib="casuser"};
quit;
















*****************************;
* SOLUTION                  *;
*****************************;
/*
proc cas;
    table.copyTable /
        table={name="cars_raw",
               caslib="casuser",
               computedVars={
                           {name="InvoiceEuro", label="Invoice (Euro)", format="eurox14.2"}
               },
               computedVarsProgram="InvoiceEuro=Invoice*.82;",
               vars={"Make", "Model", "Invoice", "InvoiceEuro"}
        },
        casOut={name="EuroPrices", caslib="casuser", replace=TRUE};

* Preview table *;
    table.fetch / 
        table={name="EuroPrices", caslib="casuser"};
quit;
*/