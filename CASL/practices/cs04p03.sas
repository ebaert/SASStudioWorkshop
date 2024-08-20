*****************************************************************;
* Lesson 4: Practice 3                                          *; 
*****************************************************************;

* Identify categorical variable columns (distinct count<20) *;
proc cas;
    heartTbl = {name="heart", caslib="casuser"};
    simple.distinct /
        
    ;
    print rd.Distinct;
run;
quit;
