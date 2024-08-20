*******************************************************;
* Lesson 2 Section 5 - CASL Dictionaties              *;
*******************************************************;
* - Introduction to CASL Dictionaries                 *;
* - Creating a Dictionary in CASL                     *;
* - Accessing and Modifying a Dictionary              *;
* - Using a Dictionary in a CAS Action                *;
* - CAS Actions Return a Dictionary                   *;
* - Iterating Through a Dictionary                    *;
*******************************************************;

*******************************************************;
* Introduction to CASL Dictionaries                   *;
*******************************************************;

* Array *;
proc cas;
    employee={"Kris Hansen","Manager",45000};
    print "Salary: " employee[3];
quit;



*******************************************************;
* Creating a Dictionary in CASL                       *;
*******************************************************;

* Create a dictionary - Short Form *;
proc cas;
    emp={name="Kris Hansen",
         title="Manager",
         salary=45000};
    describe emp;
    print emp;
quit;


* Create a dictionary - Long Form *;
proc cas;
    emp.name="Kris Hansen";
    emp.title="Manager";
    emp.salary=45000;
    describe emp;
    print emp;
quit;


* Create a dictionary - Square Brackets *;
proc cas;
    emp["name"]="Kris Hansen";
    emp["title"]="Manager";
    emp["salary"]=45000;
    describe emp;
    print emp;
quit;

* Create a dictoinary - Square Brackets with Variables *;
proc cas;
    x="name";
    y="title";
    z="salary";
    emp[x]="Kris Hansen";
    emp[y]="Manager";
    emp[z]=45000;
    describe emp;
    print emp;
quit;



*******************************************************;
* Accessing and Modifying a Dictionary                *;
*******************************************************;

* Access value using brackets *;
proc cas;
    emp={name="Kris Hansen",
         title="Manager",
         salary=45000};
   print emp["name"]; 
quit;


* Access values using the dot operator *;
proc cas;
    emp={name="Kris Hansen",
         title="Manager",
         salary=45000};
    print emp.name;
quit;


* Delete a dictionary key-value pair using brackets *;
proc cas;
    emp={name="Kris Hansen",
         title="Manager",
         salary=45000};
    delete emp["title"];
    print emp;
quit;


* Delete a dictionary key-value pair using dot notation *;
proc cas;
    emp={name="Kris Hansen",
         title="Manager",
         salary=45000};
    delete emp.title;
    print emp;
quit;

* Adding a dictionary key-value pair using brackets *;
proc cas;
    emp={name="Kris Hansen",
         title="Manager",
         salary=45000};
    emp["title"]="Supervisor";
    print emp;
quit;


* Adding a dictionary key-value pair using dot notation *;
proc cas;
    emp={name="Kris Hansen",
         title="Manager",
         salary=45000};
    emp.title="Supervisor";
    print emp;
quit;



*******************************************************;
* Using a Dictionary in a CAS Action                  *;
*******************************************************;

* CAS actions on the same table without a dictionary variable *;
proc cas;
    table.fetch / table={name="cars",caslib="casuser"};
    table.columnInfo / table={name="cars",caslib="casuser"};
    simple.numRows / table={name="cars",caslib="casuser"}; 
quit;


* CAS actions using a dictionary variable *;
proc cas;
    tbl={name="cars", caslib="casuser"};
    table.fetch / table=tbl;
    table.columnInfo / table=tbl;
    simple.numRows / table=tbl;
quit;



*******************************************************;
* CAS Actions Return a Dictionary                     *;
*******************************************************;

* Execute a CAS action *;
proc cas;
    carsTbl={name="cars", caslib="casuser"};
    table.fetch / table=carsTbl;
quit;


* Execute a CAS action and store the results in a dictionary *;
proc cas;
    carsTbl={name="cars", caslib="casuser"};
    table.fetch result=r / table=carsTbl;
quit;


* View the description of the result variable of a CAS action *;
proc cas;
    carsTbl={name="cars", caslib="casuser"};
    table.fetch result=r / table=carsTbl;
    describe r;
quit;


* Print the table from a CAS action result dictionary *;
proc cas;
    carsTbl={name="cars", caslib="casuser"};
    table.fetch result=r / table=carsTbl;
    describe r;
    print r.Fetch;
quit;



*******************************************************;
* Iterating Through a Dictionary                      *;
*******************************************************;

* Loop over a dictionary *;
proc cas;
    x={A=1, B="Bat", C=100, D="Dog"};
    do k, v over x;
       print "The key is: " k ", and the value is: " v;
    end;
quit;