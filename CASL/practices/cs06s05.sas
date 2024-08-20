*****************************************************************;
* Lesson 6: Practice 5 Solution                                 *; 
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

* Store the two way frequency result table in a variable *;
    ftTbl=ft["Table1.List"];
    ftTbl=ftTbl[,{"OrderType","Customer_Group", "Percent"}];

* Save the table variable as a SAS data set *;
    saveresult ftTbl dataOut=work.freqType;
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