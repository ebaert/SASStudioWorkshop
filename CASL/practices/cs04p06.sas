*****************************************************************;
* Lesson 4: Practice 6                                          *; 
*****************************************************************;

/* Identify and isolate duplicates in cs.orders_raw */
proc cas;
    tbl= {name="orders_raw", caslib="cs",replace=TRUE};
    table.loadTable result=rl/
        caslib="cs",
        path="orders_raw.sashdat"
        casout=tbl;

/* Variable definition */
    id=  ;
    clean=  ;
    dups=  ;

/* Deduplication */
    deduplication.deduplicate / 
        table=tbl,
        casOut=clean,
        duplicateOut=dups,
        noDuplicateKeys=true;

/* Display Duplicate IDs (use table.fetch)*/
    table.fetch /
       table=  ,
       fetchVars=   ;
quit;
