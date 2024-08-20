*******************************************************;
* Lesson 3 Section 3 - Exploring the CAS Connection   *;
*******************************************************;
* - Loading Files into In-Memory Tables               *;
* - Loading Server-Side Files                         *;
* - Loading Client-Side Files                         *;
* - Accessing and Loading Database Tables             *;
* - Promoting Tables to Global Scope                  *;
* - Saving In-Memory Tables                           *;
* - Dropping In-Memory Tables                         *; 
*******************************************************;

*******************************************************;
* Loading Files into In-Memory Tables                 *;
*******************************************************;
* N/A *;



*******************************************************; 
* - Loading Server-Side Files                         *;
*******************************************************;

proc cas;
    table.loadTable /
        path="sales.sas7bdat", caslib="cs",
        casout={caslib="cs", 
                name="sales",
                replace=TRUE
        };
quit;



*******************************************************; 
* - Loading Client-Side Files                         *;
*******************************************************;

* Load a client-side file *;
proc cas;
    upload path="&path/data/my_data/cars_raw.sas7bdat"
           casOut={name="cars_client",
                   caslib="casuser",
                   replace=TRUE
           };
quit;


* Load a SAS data set *;
proc casutil;
    load data=sashelp.cars
         casout="sashelp_cars"
         outcaslib="casuser"
         replace;
quit;



*******************************************************; 
* - Accessing and Loading Database Tables             *;
*******************************************************; 
* N/A *;



*******************************************************;
* - Promoting Tables to Global Scope                  *;
*******************************************************;
* N/A *;



*******************************************************; 
* - Saving In-Memory Tables                           *;
*******************************************************;
* N/A *;


*******************************************************; 
* - Dropping In-Memory Tables                         *;
*******************************************************; 

proc cas;
    table.dropTable /
       caslib="cs",
       name="sales";
quit;