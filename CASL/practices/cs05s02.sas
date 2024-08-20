*****************************************************************;
* Lesson 5: Practice 2 Solution                                 *; 
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



*******************************;
* SOLUTION                    *;
*******************************;
proc cas;
	source createColumns;
	    DaysToDeliver=Delivery_Date - Order_Date;
		length Type $10;
		if OrderType=1 then Type='Retail';
		  else if OrderType=2 then Type='Catalog';
		  else if OrderType=3 then Type='Internet';
		  else Type='Unknown';
	endsource;

	table.copyTable /
		table={name="orders",
			   caslib="cs",
			   computedVarsProgram=createColumns,
			   vars={"Continent","DaysToDeliver", "Type"},
			   where="DaysToDeliver > 3 and Type='Internet'"
        },
		casOut={name="orders_delivery", 
                caslib="cs", 
                replace=TRUE
        };

	table.tableInfo / caslib="cs";
quit;