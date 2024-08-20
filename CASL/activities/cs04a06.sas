*********************************************************;
* Activity 4.06                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

proc cas;
	simple.freq result=f/
	   table={caslib="casuser", name="heart"},
	   input={"BP_Status","Chol_Status","Weight_Status","Smoking_Status"};
	fTab=f.Frequency;

*add saveresult to save fTab as SAS dataset work.heart_freq;

quit;

proc print data=work.heart_freq;
run;















*****************************;
* SOLUTION                  *;
*****************************;
/*
proc cas;
	simple.freq result=f/
	   table={caslib="casuser", name="heart"},
	   input={"BP_Status","Chol_Status","Weight_Status","Smoking_Status"};
	fTab=f.Frequency;
	saveresult ftab dataout=work.heart_freq;
quit;
*/

* ALTERNATE SOLUTION *;
/*
proc cas;
	simple.freq result=f/
	   table={caslib="casuser", name="heart"},
	   input={"BP_Status","Chol_Status","Weight_Status","Smoking_Status"};
	fTab=f.Frequency;
	saveresult ftab dataout=heart_freq lib=work;
quit;
*/ 