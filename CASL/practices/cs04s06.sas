*****************************************************************;
* Lesson 4: Practice 6 Solution                                 *; 
*****************************************************************;

/* Identify and isolate duplicates in cs.orders_raw */
proc cas;
    tbl= {name="orders_raw", caslib="cs",replace=TRUE};
    table.loadTable result=rl/
        caslib="cs",
        path="orders_raw.sashdat"
        casout=tbl;

/* Variable definition */
    id={"Customer_ID","Order_ID","Product_ID"};
    clean={caslib="cs",name="orders_clean",replace=TRUE};
    dups={caslib="cs",name="orders_dups",replace=TRUE};
    delete tbl.replace;
    tbl.groupBy=id;

/* Deduplication */
    deduplication.deduplicate / 
        table=tbl,
        casOut=clean,
        duplicateOut=dups,
        noDuplicateKeys=true;

/* Display Duplicate IDs (use table.fetch)*/
    delete dups.replace;
    table.fetch /
       table=dups,
       fetchVars=id;
quit;
