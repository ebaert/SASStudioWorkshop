*****************************************************************;
* Lesson 6: Practice 4 Solution                                 *; 
*****************************************************************;

* Load the orders table *;
proc cas;
    lib="cs";
    table.loadTable / 
        path="orders_clean.sashdat", caslib=lib,
        casOut={name="orders",caslib=lib, replace=TRUE};
quit;


* Preview the orders table *;
proc cas;
    orders={name="orders",caslib="cs"};
    table.columnInfo / table=orders;
    table.fetch / table=orders;
quit;



* Generating Descriptive Statistics Using Aggregate *;
proc cas;
* Input table *;
    inTbl={name="orders",
           caslib="cs",
           groupBy="OrderType",
           computedVarsProgram="TotalProfit=RetailPrice-(Cost*Quantity);"
    };

* Output table *;
    outTbl={name="TotalProfit_Summary", caslib="cs"};

* Use aggregate to analyze the orders table *;
    aggregation.aggregate /
        table=inTbl,
        varSpecs={ 
            {name="TotalProfit", agg="MEDIAN"},
            {name="TotalProfit", subSet={"MIN","MAX"}}
        },
        casOut=outTbl || {replace=TRUE};

* Preview the new table *;
    table.fetch / table=outTbl;
quit;