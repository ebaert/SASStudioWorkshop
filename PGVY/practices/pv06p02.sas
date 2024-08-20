*********************************************************;
* Lesson 6, Practice #2                                 *;
*   NOTE: If you have not setup the Autoexec file in    *;
*         SAS Studio, open and submit startup.sas first.*;
*********************************************************;

proc transpose data=pvbase.qtr_sales out=qtr_sales_rotate(drop=_name_);
    var Sales;
    id Qtr;
    by Product_ID;
run;


