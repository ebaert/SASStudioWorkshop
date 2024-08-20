*****************************************************************;
* Lesson 5: Practice 1 Solution                                 *; 
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



*******************************;
* SOLUTION 1                  *;
*******************************;
proc cas;
	shoes={name="shoes", caslib="casuser"};

	source combine;
		ifc(find(Region,"Europe","i")>0,"Europe",Region);
	endsource;

	table.update /
		table=shoes,
		set={
		   {var="Region", value=combine}
		};

	simple.freq /
		table=shoes,
		inputs={"Region"};
quit;



*******************************;
* SOLUTION 2                  *;
*******************************;
proc cas;
	shoes={name="shoes", 
           caslib="casuser",
	       where="find(Region,'Europe','i')>0"
     };

	table.update /
		table=shoes,
		set={
		   {var="Region", value="'Europe'"}
		};

	simple.freq /
		table=shoes,
		inputs={"Region"};
quit;		