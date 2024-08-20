*******************************************************;
* Lesson 6 Section 2 - Summarizing Data with Actions  *;
*******************************************************;
* - Summary Statistics Using the Summary Action       *;
* - Summary Statistics Using the Aggregate Action     *;
* - Frequency and Crosstabulation Reports             *;
* - Additional Analytic Actions                       *;
*******************************************************;

*******************************************************;
* Summary Statistics Using the Summary Action         *;
*******************************************************;
proc cas;
    simple.summary /
        table={name="cars", 
               caslib="casuser",
            groupBy="Origin"},
        inputs={"MSRP", "Cylinders"},
        subSet={"MIN","MAX","MEAN"}
        casOut={name="originAnalysis", caslib="casuser", replace=TRUE};

* Preview *;
    table.fetch / 
        table={name="originAnalysis", caslib="casuser"},
        index=FALSE;
quit;



*******************************************************;
* Summary Statistics Using the Aggregate Action       *;
*******************************************************;
* Specify specific summary statistics *;
proc cas;
    aggregation.aggregate / 
        table={name="cars", caslib="casuser"},
        varSpecs={
             {name="MSRP", subSet={"MIN", "MAX", "MEAN"}}, 
             {name="Cylinders", subSet={"MIN", "MAX", "MEAN"}}
        };
quit;


* Group summary statistics by a specific category *;
proc cas;
    aggregation.aggregate / 
        table={name="cars",  
               caslib="casuser", 
               groupBy="Origin"},
        varSpecs={
             {name="MSRP", subSet={"MIN", "MAX", "MEAN"}}, 
             {name="Cylinders", subSet={"MIN", "MAX", "MEAN"}}
        };
quit;


* Save the results to a CAS table *;
proc cas;
    aggregation.aggregate / 
        table={name="cars", 
               caslib="casuser", 
               groupBy="Origin"},
        varSpecs={
             {name="MSRP", subSet={"MIN", "MAX", "MEAN"}}, 
             {name="Cylinders", subSet={"MIN", "MAX", "MEAN"}}
        },
        casOut={name="originAnalysis2", caslib="casuser", replace=TRUE};

* Preview *;
    table.fetch / 
        table={name="originAnalysis2", caslib="casuser"},
        index=FALSE;
quit;


* Compare the results of the summary and aggregate actions *;
proc cas;
* simple.summary action *;
    simple.summary /
        table={name="cars", 
               caslib="casuser",
            groupBy="Origin"},
        inputs={"MSRP", "Cylinders"},
        subSet={"MIN","MAX","MEAN"}
        casOut={name="originAnalysis", caslib="casuser", replace=TRUE};

* aggregation.aggregate action*;
    aggregation.aggregate / 
        table={name="cars", 
               caslib="casuser", 
               groupBy="Origin"},
        varSpecs={
             {name="MSRP", subSet={"MIN", "MAX", "MEAN"}}, 
             {name="Cylinders", subSet={"MIN", "MAX", "MEAN"}}
        },
        casOut={name="originAnalysis2", caslib="casuser", replace=TRUE};

* Preview the output tables of each action *;
    table.fetch / 
        table={name="originAnalysis", caslib="casuser"},
        index=FALSE;
    table.fetch / 
        table={name="originAnalysis2", caslib="casuser"},
        index=FALSE;
quit;


* Additional aggregate action functionality *;
proc cas;
    aggregation.aggregate / 
        table={name="cars", caslib="casuser"},
        varSpecs={
          {name="MSRP", agg="MEDIAN"},
          {name="MSRP", agg="PERCENTILE"},
          {name="Cylinders", subset={"MAX","MIN"}}
        };
quit;



*******************************************************;
* Frequency and Crosstabulation Reports               *;
*******************************************************;

* Simple one-way frequency using simple.freq *;
proc cas;
    simple.freq /
        table={name="cars", caslib="casuser"},
        inputs={"Origin", "Type"};
quit;


* Simple one-way frequency with the freqTab action *;
proc cas;
    freqtab.freqtab /
        table={name="cars", caslib="casuser"},
        tabulate={
            {vars="Origin"}, 
            {vars="Type"}
        };
quit;


* Two-way frequency *;
proc cas;
    freqtab.freqtab /
        table={name="cars", caslib="casuser"},
        tabulate={ 
              {vars={"Origin", "Type"}}
        };
quit;


* Multiple two-way frequency reports *;
proc cas;
    freqtab.freqtab /
        table={name="cars", caslib="casuser"},
        tabulate={ 
              {vars="Origin", cross={"Type", "Cylinders"}}
        };
quit;


* Simple crosstabulation *;
proc cas;
    simple.crossTab / 
        table={name="cars", caslib="casuser"},
        row="Type",
        col="Origin";
quit;
        


*******************************************************;
* Additional Analytic Actions                         *;
*******************************************************;
* N/A *;