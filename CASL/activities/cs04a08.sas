*********************************************************;
* Activity 4.08                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

%include "&path/data/load_heart_raw.sas";

proc cas;
    sourceTbl={};
    clean={caslib="cs",name="heart_single", replace=TRUE};
    dups={caslib="cs",name="heart_dups"};

    deduplication.deduplicate / 
       table=sourceTbl,
       casOut=clean,
       duplicateOut=dups,
       noDuplicateKeys=true;

    table.fetch result=rf/
       table=dups;

    print rf.Fetch[,{1,2}];
quit;















*****************************;
* SOLUTION                  *;
*****************************;
/*
proc cas;
    sourceTbl={caslib="cs",
               name="heart_raw",
               groupBy="ID"};
    clean={caslib="cs",name="heart_single"};
    dups={caslib="cs",name="heart_dups"};

    deduplication.deduplicate / 
       table=sourceTbl,
       casOut=clean,
       duplicateOut=dups,
       noDuplicateKeys=true;

    table.fetch result=rf/
       table=dups;

    print rf.Fetch[,{1,2}];
quit;
*/