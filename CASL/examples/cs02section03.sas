**********************************************************;
* Lesson 2 Section 3 - CASL Numeric and String Variables *;
**********************************************************;
* - Creating a Numeric and Character Variable            *;
* - Working with Numeric Data                            *;
* - Working with String Data                             *;
**********************************************************;

*******************************************************;
* Creating a Numeric and Character Variable           *;
*******************************************************;

* Create a character and numeric variable *;
proc cas;
    x=3;
    describe x;
    print x;
 
    y="Hello World";
    describe y;
    print y;
quit;



*******************************************************;
* Working with Numeric Data                           *;
*******************************************************;

* Create, describe and print a numeric variable *;
proc cas;
    x=3;
    describe x;
    print x;
quit;


* Use an numeric expression *;
proc cas;
    x = 3 + 4;
    describe x;
    print x;
quit;


* Use the common MEAN function *;
proc cas;
    x=mean(3,4);
    describe x;
    print x;
quit;


* Print a numeric value and a string *;
proc cas;
    x=mean(3,4);
    describe x;
    print "The value of x= " x;
quit;


* Create and print multiple numeric variables *;
proc cas;
    x=mean(3,4);
    print "x=" x;
    y=max(3,4,5);
    print "y=" y;
    z=100;
    print "z=" z;
quit;



*******************************************************;
* Working with String Data                            *;
*******************************************************;

* Create and print a string variable *;
proc cas;
    x="Hello World"; 
    print x;
quit;


* Concatenate two string variables *;
proc cas;
    x1="Hello";
    x2="World";
    x=x1 || x2;
    print x; 
quit;


* Add a space to concatenated string variables *;
* METHOD 1 *;
proc cas;
    x1="Hello ";
    x2="World";
    x=x1 || x2;
    print x; 
quit;

* METHOD 2 *;
proc cas;
    x1="Hello ";
    x2="World";
    x=x1 || " " || x2;
    print x; 
quit;


* Concatenate a string and numeric variable *;
proc cas;
    x="Total number of rows=";
    numRows=300;
    total=x || numRows;
    print total;
quit;


* Using the CATX function *;
proc cas;
    x=catx(" ", "Hello", "there", "world");
    print x; 
quit;


* Using the CATX and UPCASE functions *;
proc cas;
    x1="Hello ";
    x2="World";
    x=upcase(catx(" ",x1, x2));
    print x; 
quit;