*****************************************************************;
* Lesson 3: Practice 1 Solution                                 *; 
*****************************************************************;

proc cas;
    lib="cs";

* Load the table into memory *;
    table.loadTable / 
        path="orders_clean.sashdat", caslib=lib,
        where="Customer_Group='Orion Club Gold members'",
        vars={"Customer_Group","Customer_Type","Postal_Code","RetailPrice","Country"},
        casOut={name="gold_members",
                caslib=lib, 
                replace=TRUE
        };

* View the in-memory table *;
    table.tableInfo / caslib=lib;
quit;