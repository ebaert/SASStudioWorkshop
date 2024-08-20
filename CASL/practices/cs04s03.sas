*****************************************************************;
* Lesson 4: Practice 3 Solution                                 *; 
*****************************************************************;

proc cas;
    heartTbl = {name="heart", caslib="casuser"};
    simple.distinct result=rd/
        table=heartTbl;

    print rd.Distinct.where(nDistinct<20 and nMiss<100);
quit;
