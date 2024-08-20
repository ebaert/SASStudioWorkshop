/* Point to Courses -> PGVY */
%let homedir=%sysget(HOME);
%let path=&homedir/Courses/PGVY;

/* Write out log 
filename cre8log "%qsysfunc(pathname(work))/cre8data.log";
proc printto log=cre8log;
run;
*/

cas mySession;
caslib copy_to_casuser path="&path/data/copy-to-casuser";
caslib data_folder path="&path/data";


proc casutil;
    /* Move products.xlsx from copy-to-casuser to the Casuser caslib as a xlsx file  */
    load casdata="products.xlsx" incaslib="copy_to_casuser"  
         casout ="table" outcaslib="casuser" 
         replace;

    save casdata="table" incaslib="casuser"
         casout ="products.xlsx" outcaslib="casuser" 
         replace;

    droptable casdata="table" incaslib="casuser";


    /* Move sales.sas7bdat from copy-to-casuser to the Casuser caslib as (sas7bdat) */
    load casdata="sales.sas7bdat" incaslib="copy_to_casuser"  
         casout = "table" outcaslib="casuser" 
         replace;

    save casdata="table" incaslib="casuser" 
         casout ="sales.sas7bdat" outcaslib="casuser"  
         replace;

    droptable incaslib="casuser" casdata="table";


    /* Move sales.csv from copy-to-casuser to the Casuser caslib as (csv) */
    load casdata="sales.csv" incaslib="copy_to_casuser"
         casout="table" outcaslib="casuser" replace;

    save casdata="table" incaslib="casuser"
         casout="sales.csv" outcaslib="casuser" replace;

    droptable casdata="table" incaslib="casuser";


    /* Move orders.sas7bdat from copy-to-casuser to the Casuser caslib as (sashdat, parquet) */
    load casdata="orders.sas7bdat" incaslib="data_folder"  
         casout ="table" outcaslib="casuser" 
         replace;

    /* sashdat */
    save casdata="table" incaslib="casuser" 
         casout ="orders_hd.sashdat" outcaslib="casuser" 
         replace;

    /* parquet */
    save casdata="table" incaslib="casuser" 
         casout ="orders.parquet" outcaslib="casuser"
         replace;

    droptable incaslib="casuser" casdata="table";

    list files incaslib="casuser";
quit;



/* Load bigOrders and promote to global scope */
/* proc cas; */
/* 	table.tableExists result = tbl / */
/* 		 name='bigOrders', caslib='casuser'; */
/*  */
/* 	Load bigOrders if it's not promoted in Casuser */
/* 	if tbl.exists = 2 then print 'BigOrders is in-memory promoted'; */
/* 	else  */
/* 		table.loadTable /  */
/* 			path='bigOrders.sashdat' caslib='data_folder' */
/* 			casout = {name='bigOrders', caslib='casuser', promote=TRUE}; */
/* quit; */


cas mySession terminate;



/* Macro to delete everything in the Casuser caslib */
/* Don't delete all files from the Casuser caslib (don't use) */
%macro casuserDelete;
    proc fedsql;
    drop table FileInfo force;
    quit;
   
    cas mySession;
    ods select FileInfo;
    ods output fileinfo=fileinfo;
    title "Residual Files to be Deleted from CASUSER";
    proc casutil;
        list files incaslib="casuser";
    run; quit;
    ods output close;
    %if %qsysfunc(exist(work.fileinfo)) %then %do;
    data _null_;
		  set fileinfo end=last;
		  call symputx(cats('file',_n_),name,'l');
		  if last then call symputx('nobs',_n_);
    run;
	
    proc casutil;
			%do i=1 %to &nobs;
            deletesource casdata="&&file&i" incaslib="casuser" quiet;
			%end;
    run; quit;
    %end;
    cas mySession terminate;
%mend;
/* %casuserDelete */
