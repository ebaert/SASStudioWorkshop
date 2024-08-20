*********************************************************;
* Demo: Modifying DATA Step Code to Run in CAS          *;
*   NOTE: If you have not setup the Autoexec file in    *;
*         SAS Studio, open and submit startup.sas first.*;
*********************************************************;

***********************************************;
* SAS Compute DATA Step - 1                   *;
***********************************************;
data work.gold_members(where=(Customer_Group='Orion Club Gold members'));
	set pvbase.orders;
	Country = upcase(Country);
	Profit = RetailPrice - (Quantity * Cost);
	keep Order_ID Customer_Group Customer_Type Country Quantity RetailPrice Cost Profit;
run;



***********************************************;
* Execute the DATA Step in CAS                *;
***********************************************;
********************************************************************************************;
* Run the same DATA step in CAS by using the libref to a Caslib.                           *;
* The WHERE= data set option on the output CAS table is not supported in CAS.              *;
* CAS will attempt to send the entire CAS table back to the Compute server for processing. *;
********************************************************************************************;

* Load the orders_hd.sashdat file into CAS *;
proc casutil;
   droptable casdata="orders" incaslib="casuser" quiet;
   load casdata="orders_hd.sashdat" incaslib="casuser" 
        outcaslib="casuser" casout="orders" promote;
quit;


* Run the same DATA step in CAS (error) *;
options msglevel=i;
data casuser.gold_members(where=(Customer_Group='Orion Club Gold members'));
	set casuser.orders;
	Country = upcase(Country);
	Profit = RetailPrice - (Quantity * Cost);
	keep Order_ID Customer_Group Customer_Type Country Quantity RetailPrice Cost Profit;
run;


***************************************************************;
* Modify the DATA step to ensure the processing occurs in CAS *;
***************************************************************;
* METHOD 1 *;
data casuser.gold_members;
	set casuser.orders(where=(Customer_Group='Orion Club Gold members')); *<---Move the WHERE data set option *;
	Country = upcase(Country);
	Profit = RetailPrice - (Quantity * Cost);
	keep Order_ID Customer_Group Customer_Type Country Quantity RetailPrice Cost Profit;
run;

* METHOD 2 *;
data casuser.gold_members;
	set casuser.orders;
	where Customer_Group='Orion Club Gold members'; *<---Use the WHERE statement *;
	Country = upcase(Country);
	Profit = RetailPrice - (Quantity * Cost);
	keep Order_ID Customer_Group Customer_Type Country Quantity RetailPrice Cost Profit;
run;



***********************************************;
* SAS Compute DATA Step - 2                   *;
***********************************************;
data work.gold_members;
	set pvbase.orders;
	where Customer_Group='Orion Club Gold members'; 
	Country = upcase(Country);
	CountryLetter = first(Country); 
	Profit = RetailPrice - (Quantity * Cost);
	keep Order_ID Customer_Group Customer_Type Country Quantity RetailPrice Cost Profit CountryLetter;
run;


***********************************************;
* Execute the DATA Step in CAS                *;
***********************************************;
********************************************************************************************;
* Run the same DATA step using the libref to a Caslib to process that data in CAS.         *;
* The FIRST function is not available in CAS.                                              *;
* CAS will attempt to send the entire CAS table back to the Compute server for processing. *;
********************************************************************************************;
data casuser.gold_members / sessref=mySession;
	set casuser.orders;
	where Customer_Group='Orion Club Gold members';
	Country = upcase(Country);
	CountryLetter = first(Country); 
	Profit = RetailPrice - (Quantity * Cost);
	keep Order_ID Customer_Group Customer_Type Country Quantity RetailPrice Cost Profit CountryLetter;
run;

* FIRST Function Documentation: https://go.documentation.sas.com/doc/en/pgmsascdc/v_038/lefunctionsref/p1af3wnk52qg49n1xcdk1wpcmucy.htm *;

* Change the FIRST function to SUBSTR to run in CAS *;
data casuser.gold_members /sessref=mySession;
	set casuser.orders;
	where Customer_Group='Orion Club Gold members';
	Country = upcase(Country);
	CountryLetter=substr(Country,1,1); *<---SUBSTR is CAS enabled *;
	Profit = RetailPrice - (Quantity * Cost);
	keep Order_ID Customer_Group Customer_Type Country Quantity RetailPrice Cost Profit CountryLetter;
run;
options msglevel=n;