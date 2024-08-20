*******************************************************;
* Lesson 5 Section 4 - Using SQL in CAS               *;
*******************************************************;
* - Introduction to the FedSql Action Set             *;
* - Simple FedSQL Query                               *;
* - Creating CAS Tables Using SQL                     *;
* - Joins                                             *;
*******************************************************;

*******************************************************;
* Introduction to the FedSql Action Set               *;
*******************************************************;
* N/A *;



*******************************************************;
* Simple FedSQL Query                                 *;
*******************************************************;

* Simple query, use active caslib to select table *;
proc cas;
    fedSQL.execDirect / 
         query="select Make, Model, MSRP 
                   from cars 
                   limit 10";
quit;


* Simple query, specify the casuser caslib *;
proc cas;
    fedSQL.execDirect / 
         query="select Make, Model, MSRP 
                   from casuser.cars 
                   limit 10";
quit;


* Use a SOURCE block *;
proc cas;
    source q;
       select Make, Model, MSRP 
           from casuser.cars 
           limit 10;
    endsource;
    fedSQL.execDirect / query=q;
quit;



*******************************************************;
* Creating CAS Tables Using SQL                       *;
*******************************************************;

* Create and replace a table *;
proc cas;
source q;
create table casuser.cars_preview{options replace=TRUE} as
    select Make, Model, MSRP 
        from casuser.cars 
        limit 10;
endsource;
fedSQL.execDirect / query=q;
quit;



*******************************************************;
* Joins                                               *;
*******************************************************;
* N/A *;