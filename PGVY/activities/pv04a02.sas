*****************;
* Activity 4.02 *;
*****************;

* Load the sashelp.prdsal2 client-side file into memory in the Casuser caslib *;
proc casutil;

quit;


* Display table metadata such as column names and data types for files or in-memory tables.*;
proc casutil incaslib='casuser';
	contents casdata='prdsal_cas';
quit;