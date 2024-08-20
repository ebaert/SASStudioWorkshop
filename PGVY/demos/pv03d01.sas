***************************;
* Demo: Accessing Caslibs *;
***************************;

* Create a traditional SAS Library to the data folder using the Compute server *;
libname pvbase base "/home/student/Courses/PGVY/data";

* Create a Caslib to the data folder using the CAS server *;
cas mySession sessopts=(caslib=casuser timeout=1800 locale="en_US");

* View all available Caslibs *;
caslib _all_ list;

* Create a library reference to the Casuser caslib using the CAS engine *;
libname casuser cas caslib=casuser;

* Create library references to every caslib using the CAS engine *;
caslib _all_ assign;

* Terminate your CAS session *;
cas mySession terminate;
