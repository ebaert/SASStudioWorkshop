*****************************************************************;
* Lesson 5: Practice 1                                          *; 
*****************************************************************;

* Load the sashelp.shoes table into memory *;
proc casutil;
	load data=sashelp.shoes 
         outcaslib="casuser" 
         casout="shoes" 
         replace;
run;

* Preview the shoes table *;
proc cas;
	shoes={name="shoes", caslib="casuser"};

	table.fetch / 
		table=shoes,
		index=FALSE,
		to=10;
	simple.freq /
		table=shoes,
		inputs={"Region"};
quit;