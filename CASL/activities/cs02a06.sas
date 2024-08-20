*********************************************************;
* Activity 2.06                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

proc cas;
    columns=["Age" , "DOB" , "Sales" , "Quantity"];
quit;
















*****************************;
* SOLUTION                  *;
*****************************;
/*;
proc cas;
    columns={"Age" , "DOB" , "Sales" , "Quantity"};
    print columns[2:3];
quit;
*/