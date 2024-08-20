*********************************************************;
* Activity 7.02                                         *;
*   NOTE: If you have not setup the Autoexec file in    *;
*         SAS Studio, open and submit startup.sas first.*;
*********************************************************;


proc fedsql;
	select *
	from pvbase.orders
	limit 10;
quit;
