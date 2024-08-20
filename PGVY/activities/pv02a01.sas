*****************;
* Activity 2.01 *;
*****************;

* Set path to the PGVY course folder *;
%let path=;

libname pvbase "&path/data";

* View available SAS tables in the pvbase library *;
proc contents data=pvbase._all_ nods;
run;

* Preview the products table *;
proc print data=pvbase.products (obs=10);
run;


* Run the FREQ procedure on the Product_line column *;
proc freq data=pvbase.products;
	tables Product_line;
run;

