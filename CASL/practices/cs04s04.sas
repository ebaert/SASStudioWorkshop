*****************************************************************;
* Lesson 4: Practice 4 Solution                                 *; 
*****************************************************************;

/* Identify Continuous Numerical Variables (numeric, distinct count >= 20% of total rows); */
%include "&path/data/load_orders_raw.sas";


proc cas;
   ordersTbl = {name="orders_raw", caslib="cs"};
   table.columnInfo result=ri/
      table=ordersTbl;

/*    describe ri; */

/* c. Add a selection operator to store Column values as an array in varList*/
   varList=ri.ColumnInfo.where(/* Exclude character variables*/
                                  !(Type like '%char%') 
                               /* Exclude variable names not useful for analysis */
                              and !(Column like '%ID')
                              and !(lowcase(Column) like '%date')
                              and !(lowcase(Column) like 'xy%'))
                              [,"Column"]
   ;

    print varList;

/*  d. Use varList to select inputs for simple.distinct  */
   simple.distinct result=rd/ 
       table=ordersTbl,
       inputs=varlist;

   print rd.distinct;

/*  e. Use simple.numRows to find the number of rows in the table */
   simple.numRows result=nr / 
      table=ordersTbl;

   print rd.Distinct.where(NDistinct >=nr.numrows*.2);
quit;