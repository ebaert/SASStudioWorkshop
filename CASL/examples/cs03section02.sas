***************************************************************;
* Lesson 3 Section 2 - Exploring and Accessing Data Sources   *;
***************************************************************;
* - Accessing Data in the SAS Compute Server                  *;
* - Accessing Data in CAS                                     *;
* - Exploring Caslibs                                         *;
* - Caslib Attributes                                         *;
* - Viewing Caslibs in SAS Studio                             *;
***************************************************************;

*******************************************************;
* Accessing Data in the SAS Compute Server            *;
*******************************************************;
* N/A *;



*******************************************************;
* Accessing Data in CAS                               *;
*******************************************************;
* N/A *;



*******************************************************;
* Exploring Caslibs                                   *;
*******************************************************;

* View available caslibs *;
proc cas;
    table.caslibInfo;
quit;


* View available data source files *;
proc cas;
    table.fileInfo / caslib="casuser";
quit;


* View available in-memory tables *;
proc cas;
    table.tableInfo / caslib="casuser";
quit;



*******************************************************;
* Caslib Attributes                                   *;
*******************************************************;

* View available caslibs and attributes *;
proc cas;
    table.caslibInfo;
quit;



*******************************************************;
* Viewing Caslibs in SAS Studio                       *;
*******************************************************;

* Create a library reference to a caslib *;
libname casuser cas sessref="conn" caslib="casuser";