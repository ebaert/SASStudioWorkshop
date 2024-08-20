*******************************************************;
* Lesson 4 Section 1 - Exploring Table Structure      *;
*******************************************************;
* - Exploring Table Structure                         *;
* - A Quick Look at Table Values                      *;             
* - Working With Action Results                       *;
* - Exploring Action Results                          *;
* - Accessing Result Table Values                     *;
* - Result Table Computed Columns                     *;
* - Saving CASL Results                               *; 
*******************************************************;

*******************************************************;
* Exploring Table Structure                           *;
*******************************************************;

* View table structure *;
proc cas;
    table.columninfo /
       table={caslib="casuser",name="cars"};
quit;



*******************************************************;
* A Quick Look at Table Values                        *;
*******************************************************;

* View the first 20 rows *;
proc cas;
    table.fetch /
       table={caslib="casuser",name="cars"};
quit;


* View specific columns and rows. Sort by MSRP *;
proc cas;
    table.fetch /
        table={caslib="casuser", name="cars",
               where="Make='Toyota'"},
        fetchVars={"Make","Model","Type","MSRP"},
        sortBy={
              {name="MSRP",order="DESCENDING"}
        };
quit;


* View rows 3 - 5 *;
proc cas;
    table.fetch /
        table={caslib="casuser", name="cars",
               where="Make='Toyota'"},
        fetchVars={"Make","Model","Type","MSRP"},
        sortBy={
              {name="MSRP",order="DESCENDING"}
        },
        from=3,
        to=5;
quit;



*******************************************************;             
* Working With Action Results                         *;
*******************************************************;

* Store the result of numRows *;
proc cas;
    simple.numRows result=nr /
        table={caslib="casuser", name="cars",
               where="Make='Toyota'"};
    describe nr;
    print nr;
quit;


* Print all the rows where Make is Toyota using the result of numRows *;
proc cas;
    carsTbl={caslib="casuser", name="cars",
             where="Make='Toyota'"};
    
    simple.numRows result=nr / 
        table= carsTbl; 
    table.fetch /
        table=carsTbl,
        fetchVars={"Make","Model","Type","MSRP"},
        to=nr.numrows;
quit;



*******************************************************;
* Exploring Action Results                            *;
*******************************************************;

proc cas;
    simple.numRows result=nr/ 
        table={caslib="casuser", name="cars"};
    describe nr;
    simple.freq result=originFreq/
        table={caslib="casuser", name="cars"},
        input={"Origin"};
    describe originFreq;

    print originFreq.Frequency;
quit;



*******************************************************;
* Accessing Result Table Values                       *;
*******************************************************;

proc cas;
    simple.freq result=originFreq/
        table={caslib="casuser", name="cars"},
        input={"Origin"};
    fTab=originFreq.Frequency;

    print "The table named " fTab.name " has " 
           fTab.nrows "rows and " fTab.ncols "columns".;

    print fTab[2:3,{"CharVar", "Frequency"}];

    print fTab[,"Frequency"];

    print "NOTE: Total is " sum(fTab[,"Frequency"]);

    print fTab.where(Frequency > 130);
quit;



*******************************************************;
* Result Table Computed Columns                       *;
*******************************************************; 

proc cas;
    simple.freq result=originFreq/
        table={caslib="casuser", name="cars"},
        input={"Origin"};
    fTab=originFreq.Frequency;
    print fTab.compute({"Col1","Percent of Total",percent6.2},  
                        Frequency/sum(fTab[,"Frequency"]));

    print fTab.compute({"Col1","Percent of Total",percent6.2},  
                        Frequency/sum(fTab[,"Frequency"]))
                       .where(Col1>0.35);
quit;



*******************************************************;
* Saving CASL Results                                 *;
*******************************************************; 

proc cas;
    carsTbl={caslib="casuser", name="cars",
             where="Make='Toyota'"};
    
    simple.numRows result=nr / table=carsTbl;
    
    table.fetch result=rf / 
        table=carsTbl,
        fetchVars={"Make","Model","Type","MSRP"},
        to=nr.numRows;
    toyotas=rf.fetch;
 
* Save as a CAS table *; 
    saveresult toyotas caslib="casuser" casout="Toyota";

* Save as a data source file *;
    table.save /
       caslib="casuser"
       table="Toyota"
       name="Toyota.sashdat"
       replace=true; 

* Save as a SAS data set *;
    saveresult toyotas dataout=work.toyotas;

quit;


* Visualize the SAS data set *;
title "Analysis of Toyota Cars";
ODS LAYOUT GRIDDED COLUMNS=2;
ODS REGION;

title "MSRP";
proc sgplot data=work.toyotas;
    histogram MSRP;
    density MSRP;
    density MSRP / type=kernel;
run;

ODS REGION;
title "Types";
proc sgplot data=work.toyotas;
    vbar type;
run;
ODS LAYOUT END;
title;


****************;
* Clean up     *;
****************;
* Deletes saved files *;
proc cas;
    table.dropTable / 
        caslib="casuser", 
        name="Toyota";

    table.deleteSource / 
        caslib="casuser",
        source="Toyota.sashdat";

    table.fileInfo / caslib="casuser";

    table.tableInfo / caslib="casuser";
quit;

proc delete data=work.toyotas;
run;