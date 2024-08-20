*********************************************************;
* Activity 6.05                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;

* Create a table with 10 million rows *;
data casuser.products;
   call streaminit(0);
    do i=1 to 10000000;
        x=rand('normal');
        if x<.10 then Product="A";
            else if x<.30 then Product="B";
            else if x<.60 then Product="C";
            else Product="D"; 
        Quantity=round(rand('uniform',1,100));
        output;
    end;
    drop x i;
run;


* Preview the table *;
proc cas;
    tbl={name="products", caslib="casuser"};
    table.tableInfo / name=tbl.name, caslib=tbl.caslib;
    table.fetch /
        table=tbl,
        to=10,
        index=FALSE;
quit;


* Create a vertical bar chart *;
ods graphics / ;
proc sgplot data=casuser.products;
    vbar Product / 
           response=Quantity 
           stat=sum;
    format Quantity comma16.;
run;
ods graphics / reset;














*****************************;
* SOLUTION                  *;
*****************************;
/*
ods graphics / maxobs=10000000;
proc sgplot data=casuser.products;
    vbar Product / 
           response=Quantity 
           stat=sum;
    format Quantity comma16.;
run;
ods graphics / reset;
*/