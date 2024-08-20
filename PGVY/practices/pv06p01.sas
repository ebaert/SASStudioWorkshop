*********************************************************;
* Lesson 6, Practice #1                                 *;
*   NOTE: If you have not setup the Autoexec file in    *;
*         SAS Studio, open and submit startup.sas first.*;
*********************************************************;

proc casutil;
    droptable casdata="employees" incaslib="casuser" quiet;
    load data=pvbase.employees outcaslib="casuser" casout="employees" promote;
quit;

proc mdsummary data=casuser.employees;
    /* insert statements */
run;

title "Average Salary by Country";
proc print data=casuser.country_summary(drop=Country_f _Column_);
    var Country--_mean_;
    format _M: dollar8.;
run;
title;
