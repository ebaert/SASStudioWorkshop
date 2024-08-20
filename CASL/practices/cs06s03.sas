*****************************************************************;
* Lesson 6: Practice 3 Solution                                 *; 
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



******************;
* SOLUTION 1     *;
******************;
proc cas;
    orders={name="orders",caslib="cs"};
    freqTab.freqTab /
        table=orders,
        tabulate={
               {vars={"OrderType"},cross={"Country", "Customer_Group"}}
        },
        order="FREQ",
        tabDisplay="LIST";
quit;



******************;
* SOLUTION 2     *;
******************;
proc cas;
    orders={name="orders",caslib="cs"};
    freqTab.freqTab /
        table=orders,
        tabulate={
               {vars={"OrderType","Country"}},
               {vars={"OrderType","Customer_Group"}}
        },
        order="FREQ",
        tabDisplay="LIST";
quit;