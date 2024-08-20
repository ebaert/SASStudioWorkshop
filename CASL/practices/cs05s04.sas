*****************************************************************;
* Lesson 5: Practice 4 Solution                                 *; 
*****************************************************************;

* Create the new CAS table *;
data casuser.hr_emps;
    call streaminit(999);
    do Department="Human Resources","IT","R & D","Marketing","Analysts","Sales";
        Year0=round(rand('uniform',10,15),1);
        Year1=round(rand('uniform',15,20),1);
        Year2=round(rand('uniform',20,25),1);
        Year3=round(rand('uniform',25,30),1);
        Year4=round(rand('uniform',30,35),1);
        Year5=round(rand('uniform',35,40),1);
        output;
    end;
run; 



*******************************;
* SOLUTION                    *;
*******************************;
proc cas;
	tbl={name="hr_emps", caslib="casuser"};
	outTbl={name="hr_narrow", caslib="casuser"};
	
	transpose.transpose /
		table=tbl || {groupBy="Department", computedVarsProgram="ID='TotalEmps'"},
		id="ID",
		transpose={"Year0","Year1","Year2","Year3","Year4","Year5"},
		name="Year",
		casOut=outTbl || {replace=TRUE};

	table.alterTable /
		name=outTbl.name,
		caslib=outTbl.caslib,
		columns={
			{name="Year", label="Hire Year"}
		};

	table.fetch / table=outTbl;
	table.columnInfo / table=outTbl;
quit;


* Create the Visualization *;
proc sgplot data=casuser.hr_narrow
			noborder;
	vbar Department / 
       group=Year 
	   groupdisplay=cluster
       response=TotalEmps 
       stat=sum;
	yaxis label="Total Employees";
	keylegend / position=top;
run;

