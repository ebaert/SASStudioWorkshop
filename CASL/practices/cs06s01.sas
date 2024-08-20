*****************************************************************;
* Lesson 6: Practice 1 Solution                                 *; 
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


* Analyze the orders table *;
proc cas;
* Set input and output table information *;
    inputTbl={name="orders",
              caslib="cs", 
              groupBy="Customer_Group ",
              computedVarsProgram="TotalProfit=RetailPrice-(Cost*Quantity);"
    };

    outTbl={name="Group_Analysis", caslib="cs"};

* Add a computed column and summarize the table *;
    simple.summary / 
       table=inputTbl,
       inputs={"TotalProfit","RetailPrice","Quantity"},
       subSet={"MIN","MAX","MEAN","SUM"},
       casOut=outTbl || {replace=TRUE};

* View the newly created table *;
    table.fetch / table=outTbl;
quit;




