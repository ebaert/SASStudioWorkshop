*****************************************************************;
* Lesson 5: Practice 3 Solution                                 *; 
*****************************************************************;

* Load the cars_raw.sas7bdat file into memory *;
proc cas;
	cars={name="cars_raw", caslib="casuser"};

	upload path="&path/data/my_data/cars_raw.sas7bdat"
		   casOut=cars || {replace=TRUE};

	table.columnInfo /
		table=cars;

	simple.distinct / table=cars;
quit;



*******************************;
* SOLUTION                    *;
*******************************;
proc cas;
	inTbl={name="cars_raw", caslib="casuser"};
	outTbl={name="cars_imputed", caslib="casuser"};

	datapreprocess.impute /
		table=inTbl,
		casOut=outTbl || {replace=TRUE},
		inputs={"EngineSize","Cylinders"},
		methodInterval="MEDIAN",
		copyAllVars=TRUE;
quit;