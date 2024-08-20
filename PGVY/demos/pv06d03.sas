**********************************************************************;
* Demo: Comparing Machine Learning Procedures in SAS Viya            *;
*   NOTE: If you have not setup the Autoexec file in                 *;
*         SAS Studio, open and submit startup.sas first.             *;
**********************************************************************;

* Create the fake data *;
%include "&path/data/create_fakeML.sas";

* Turn on the CAS server metrics to include detailed performance metrics and reports in the SAS log *;
options sessopts=(metrics=TRUE);


*******************************************;
* DATA EXPLORATION - CORRELATION          *;
*******************************************;

* Compute Server CORR Procedure *;
proc corr data=work.fakedata;
run;


* Load the client-side SAS data set to CAS *;
proc casutil;
	load data=work.fakedata
	casout='fakedatacas' outcaslib='casuser' replace;
quit;

* CAS Correlation Procedure *;
proc correlation data=casuser.fakedatacas;
run;



******************************;
* LOGISTIC REGRESSION        *;
******************************;

* Compute Server Logistic Regression Procedure *;
proc logistic data=work.fakedata;
	class c:;
	model yBinary=x: c: / selection=backward;
run;


* Compute Server High Performance Logistic Regression Procedure *;
proc hplogistic data=work.fakedata;
	class c: ;
	model yBinary = x: c:;
	selection method=backward;
run;


* CAS Logistic Regression Procedure *;
proc logselect data=casuser.fakedatacas;
	class c:;
	model yBinary=x: c:;
	selection method=backward;
run;



******************************;
* LINEAR REGRESSION          *;
******************************;

* Compute Server Linear Regression Procedure *;
proc glmselect data=work.fakedata;
	class c:;
	model yNormal=x: c:;
run;


* Compute Server High Performance Linear Regression Procedure *;
proc hpreg data=work.fakedata;
	class c:;
	model yNormal = x: c:;
run;


* CAS Linear Regression Procedure *;
proc regselect data=casuser.fakedatacas;
	class c:;
	model yNormal=x: c:;
run;


* Turn off CAS metrics *;
options sessopts=(metrics=FALSE);

*****************************************************************;
* SAS Documentation                                             *;
*****************************************************************;
* SAS Procedures and Their Corresponding CAS-Enabled Procedures *; 
* and CAS Actions                                               *; 
*****************************************************************;
* https://go.documentation.sas.com/doc/en/pgmsascdc/default/procs2actions/p0275qj00ns5pen16ijvuz8f8j5k.htm *;