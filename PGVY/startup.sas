* Terminate the CAS session. If mySession does not exist an error is returned. Ignore the error. *;
cas mySession terminate;

* Store the path of the PGVY course folder *;
%let homedir=%sysget(HOME);
%let path=&homedir/Courses/PGVY;

* Create traditional SAS library reference to the course PGVY/data folder *;
libname pvbase "&path/data";

* Create CAS session *;
cas mySession sessopts=(caslib=casuser timeout=1800);

* Create a libref to a Caslib *;
libname casuser cas caslib='casuser' sessref='mySession';