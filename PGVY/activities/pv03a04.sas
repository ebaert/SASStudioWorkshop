*****************;
* Activity 3.04 *;
*****************;

* Run the CAS statement if you do not have an active CAS session *;
cas mySession;

caslib myCaslib path="<insertpath>";

proc casutil incaslib='pvcas';
    list files;
quit;

caslib myCaslib clear;