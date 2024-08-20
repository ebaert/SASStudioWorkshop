*********************************************************;
* Activity 4.04                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

proc cas;
	simple.freq result=f/
	   table={caslib="casuser", name="heart"},
	   input={"BP_Status","Chol_Status","Weight_Status","Smoking_Status"};

	fTab=f.Frequency;
	print fTab;
quit;















*****************************;
* SOLUTION                  *;
*****************************;
/*
proc cas;
	simple.freq result=f/
	   table={caslib="casuser", name="heart"},
	   input={"BP_Status","Chol_Status","Weight_Status","Smoking_Status"};
	
	fTab=f.Frequency;
	print fTab.where(Frequency>2500);
quit;
*/