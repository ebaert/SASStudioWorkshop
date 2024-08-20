*****************************************************************;
* Lesson 6: Practice 2 Solution                                 *; 
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


* Create the crosstab *;
proc cas;
    orders={name="orders", caslib="cs"};
    simple.crossTab /
        table=orders,
        row="OrderType",
        col="Customer_Group",
        weight="RetailPrice",
        aggregator="SUM";
quit;