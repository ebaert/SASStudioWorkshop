*****************************************************************;
* Lesson 3: Practice 2 Solution                                 *; 
*****************************************************************;

proc cas;
    lib="cs";
    colNames={"Date","Air"};

* Load a client-side file into memory *;
    upload path="&path/practices/air.txt"
           casOut={name="air_upload",caslib=lib,replace=TRUE}
           importOptions={fileType="DELIMITED",
                          delimiter="|",
                          getNames=FALSE,
                          vars=colNames
           };

* Preview the new in-memory table *;
    table.fetch / table={name="air_upload",caslib=lib};
quit;