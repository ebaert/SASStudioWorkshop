*******************************************************;
* Lesson 4 Section 2 - Characterizing Data            *;
*******************************************************;
* - Characterizing Data                               *;
*******************************************************;

*******************************************************;
* Characterizing Data                                 *;
*******************************************************;

proc cas;
   carsTbl = {name="cars", caslib="casuser"};
   simple.distinct result=rd/ 
       table=carsTbl;
 
   describe rd;
   print rd.Distinct;
quit;


proc cas;
   carsTbl = {name="cars", caslib="casuser"};
   simple.numRows result=nr / 
      table=carsTbl;

   simple.distinct result=rd/ 
       table=carsTbl;
 
   print rd.Distinct.where(NDistinct<.1*nr.Numrows);
quit;


proc cas;
   carsTbl = {name="cars", caslib="casuser"};
   simple.numRows result=nr / 
      table=carsTbl;

   simple.distinct result=rd/ 
       table=carsTbl;
 
   print rd.Distinct.where(NDistinct<.1*nr.Numrows)[,{1,2}];
quit;