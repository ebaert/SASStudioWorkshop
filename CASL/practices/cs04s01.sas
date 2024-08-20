*****************************************************************;
* Lesson 4: Practice 1 Solution                                 *; 
*****************************************************************;

* Load the sales.sas7bdat server-side file into memory *;
proc cas;
    tbl={name="sales.sas7bdat",caslib="cs"};
    outTbl={name="sales",caslib="cs"};

    table.loadTable /
        path=tbl.name, caslib=tbl.caslib,
        casOut=outTbl || {replace=TRUE};

* Explore the new table *;
    tbl={name="sales", caslib="cs"};
    table.fetch / table=tbl to=5;
    table.columnInfo / table=tbl;
    simple.numRows / table=tbl;
    simple.freq / 
        table=tbl, 
        input="Job Title";
quit;