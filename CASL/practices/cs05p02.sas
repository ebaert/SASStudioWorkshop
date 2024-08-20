*****************************************************************;
* Lesson 5: Practice 2                                          *; 
*****************************************************************;

* Load the orders_clean.sashdat file into memory *;
proc cas;
    orders={name="orders", caslib="cs"};

    table.loadtable / 
        path="orders_clean.sashdat", caslib="cs",
        casOut=orders || {replace=TRUE};

    table.columnInfo /
        table=orders;

    table.fetch /
        table=orders,
        index=FALSE,
        to=10;
quit;