*****************;
* Activity 3.05 *;
*****************;

* Insert path to the PGVY/data folder *;
%let path= ;


*****************************************************;
* Create a Base SAS Library to the PGVY/data folder *;
*****************************************************;

* Create a SAS library named PVBASE to the PGVY/data folder *;
libname pvbase "&path";

* View available SAS data sets in the PVBASE library *;
proc contents data=pvbase._all_ nods;
run;


*****************************************************;
* Create a caslib to the PGVY/data folder           *;
*****************************************************;

* Create a CAS session if necessary *;
cas mySession;

* Create a caslib named PVCAS to the PGVY/data folder *; 
caslib pvcas path="&path";

* View files and tables in the PVCAS caslib *;
proc casutil incaslib='pvcas';
	list files;
quit;

* Terminate the CAS session *;
cas mySession terminate;