*******************************************************;
* Lesson 2 Section 4 - CASL Arrays                    *;
*******************************************************;
* - Introduction to CASL Arrays                       *;
* - Accessing Array Elements                          *;
* - Using an Array in a CAS Action                    *;
* - Iterating Through an Array                        *;
* - Array Operators                                   *;
* - Using Array Functions                             *;
*******************************************************;

*******************************************************;
* Introduction to CASL Arrays                         *;
*******************************************************;

* Create an array *;
proc cas;
    x={"orders", "cars", "customers"};
    describe x;
    print x;
quit;


* Create arrays with mixed data types *;
proc cas;
    x={"orders", "cars", "customers"};
    colNames={"Employee_ID", "Job_Title", "Department"}; 
    percentVals={25, 50, 70, 99}; 
    vals={4, "Job_Title", "Company", 2};
    all={1, "Title", {1,2,3,4}, "Table"};   
    print x colNames percentVals vals all;
    describe x colNames percentVals vals all;
quit;



*******************************************************;
* Accessing Array Elements                            *;
*******************************************************;

* Create an array *;
proc cas;
    colNames={"EmployeeID","JobTitle","Company","Department"};
    print colNames;
quit;


* Subset an array by position *;
proc cas;
    colNames={"EmployeeID","JobTitle","Company","Department"};
    print colNames[3];
quit;


* Subset an array by lower and upper bounds *;
proc cas;
    colNames={"EmployeeID","JobTitle","Company","Department"};
    print colNames[2:4];
quit;


* Subset an array by field positions *;
proc cas;
    colNames={"EmployeeID","JobTitle","Company","Department"};
    print colNames[{1,4}];
quit;



*******************************************************;
* Using an Array in a CAS Action                      *;
*******************************************************;

* Use the distinct action *;
proc cas;
    simple.distinct / table="cars";
quit;


* Use the distinct action with an array for the inputs parameter *;
proc cas;
    simple.distinct / 
        table="cars",
        inputs={"Make", "Type", "Cylinders"};
quit;


* Create an array and use as a parameter value *;
proc cas;
    colNames={"Make", "Type", "Cylinders"};
    simple.distinct / 
        table="cars",
        inputs=colNames;
quit;


* Use an array variable in multiple actions *;
proc cas;
    colNames={"Make", "Type", "Cylinders"};
    simple.distinct / 
        table="cars",
        inputs=colNames;
    table.fetch /
        table="cars",
        fetchVars=colNames;
quit;



*******************************************************;
* Iterating Through an Array                          *;
*******************************************************;

* Use multiple actions on two tables *;
proc cas;
    table.fetch / table="cars", to=5;
    table.tableDetails / name="cars";  
    table.columnInfo / table="cars";  
    table.fetch / table="heart", to=5;  
    table.tableDetails / name="heart";   
    table.columnInfo / table="heart";
quit; 


* Basic array loop *;
proc cas;
    do x over {"Agapi", "José", "Diya"};
       print x; 
    end;
quit;  


* Loop over an array variable *;
proc cas;
    names={"Agapi", "José", "Diya"};
    do x over names;
       print x; 
    end; 
quit; 



*******************************************************;
* Array Operators                                     *;
*******************************************************;

* Append a single value to an array *;
proc cas;
    x = {1,2,3,4,5};
    x = x || 100;

    print x;
quit;


* Append an array to another array *;
proc cas;
    x = {1,2,3,4,5};
    y = {4,5,6,7};

    print x || y;
quit;


* Find unique values in two arrays *;
proc cas;
    x = {1,2,3,4,5};
    y = {4,5,6,7};
    print x / y;
quit;


* Find common values in two arrays *;
proc cas;
    x = {1,2,3,4,5};
    y = {4,5,6,7};

    print x & y;
quit;


* Compare two arrays for equality *;
proc cas;
    x = {1,2,3,4,5};
    y = {4,5,6,7};

    equality = x == y;
    print equality;
    describe equality;
quit;

 
* Check an array for a single value *;
proc cas;
    z = {4,5,6,7,4,4};

    y = 5 == z;
    print y;
    describe y;
quit;

proc cas;
    z = {4,5,6,7,4,4};

    y = 4 == z;
    print y;
    describe y;
quit;

proc cas;
    x = {4,5,6,7,4,4};
    
    y = 200 == x;
    print y;
    describe y;
quit;



*******************************************************;
* Using Array Functions                               *;
*******************************************************;

* Number of elements in an array *;
proc cas;
    x={1,2,100,300,3,4,5};
    print dim(x);
quit;

* Sort arrays *;
proc cas;
    x={1,2,100,300,3,4,5};
    y=sort(x);
    describe y;
    print y;
quit;


proc cas;
    x={1,2,100,300,3,4,5};
    print sort_rev(x);
quit;