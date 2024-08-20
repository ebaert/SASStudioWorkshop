*****************************************************************;
* Lesson 6: Practice 5                                          *; 
*****************************************************************;

* Load the orders table *;
proc cas;
    lib="cs";
    table.loadTable / 
        path="orders_clean.sashdat", caslib=lib,
        casOut={name="orders",caslib=lib, replace=TRUE};
quit;



* Create the two-way frequency report *;
proc cas;
    orders={name="orders",caslib="cs"};

    freqTab.freqTab result=ft /
        table=orders,
        tabulate={
               {vars={"OrderType","Customer_Group"}}
        },
        order="FREQ",
        tabDisplay="LIST";

    describe ft;
    print ft;
quit;



* Create a bar chart *;
proc sgplot data=work.freqType
            noborder;
    vbar OrderType / 
         group=Customer_Group
         groupdisplay=cluster
         response=Percent
         nooutline;
    keylegend / noborder;
quit;