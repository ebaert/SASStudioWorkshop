*****************;
* Activity 4.01 *;
*****************;

* View available data source files and in-memory tables and in the Casuser Caslib *;
proc casutil incaslib='casuser';
	list files;
	list tables;
quit;

* Load the sales.sas7bdat server-side file into memory in the Casuser caslib *;
proc casutil;

quit;