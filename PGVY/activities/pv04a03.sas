*****************;
* Activity 4.03 *;
*****************;

* Reset your SAS session: Options > Reset SAS session *;


* Create a SAS data set named orders_double with almost 2 million rows *;
data pvbase.orders_double;
	set pvbase.orders pvbase.orders;
run;


**********;
* Step 2 *;
**********;
* Perform a client-side load of the orders_double SAS data set into CAS *;
libname casuser cas caslib='casuser';

data casuser.orders_client_load;
	set pvbase.orders_double;
run;


**********;
* Step 3 *;
**********;
* Perform a server-side load of the orders_double SAS data set into CAS *;
caslib myData path="&path/data";

proc casutil;
	load casdata="orders_double.sas7bdat" incaslib="myData"
		  casout="orders_server_load" outcaslib="casuser";
quit;