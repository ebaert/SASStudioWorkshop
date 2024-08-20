*****************************************************************;
* Lesson 5: Practice 3                                          *; 
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