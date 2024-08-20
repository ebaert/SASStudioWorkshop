*********************************************************;
* Activity 8.04                                         *;
*   NOTE: If you have not setup the Autoexec file in    *;
*         SAS Studio, open and submit startup.sas first.*;
*********************************************************;

proc cas;
    table.loadTable / 
        path="orders_hd.sashdat", caslib="casuser", 
        casOut={name="orders", caslib="casuser", replace=true};
/* Complete the simple.summary action */
    simple.summary /  ;	

/* Preview the table */
    table.fetch / 
        table={name="ordersSum", caslib='casuser'}, 
        fetchvars={"Continent", "_MEAN_"};
quit;
