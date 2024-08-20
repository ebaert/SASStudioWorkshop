*********************************************************;
* Demo: Modify a DATA Step to Run in CAS                *;
*   NOTE: If you have not setup the Autoexec file in    *;
*         SAS Studio, open and submit startup.sas first.*;
*********************************************************;

/*proc casutil; */
/*    droptable casdata="orders" incaslib="casuser" quiet; */
/*    load casdata="orders_hd.sashdat" incaslib="casuser"  */
/*         outcaslib="casuser" casout="orders" promote; */
/*quit; */

data work.shipping;
    set pvbase.orders end=eof;
    where OrderType ne 1;
    DaysToDeliver=Delivery_Date-Order_Date;
    drop xy: Discount Employee_ID;
    if eof then put _threadid_=   _N_=;
run;