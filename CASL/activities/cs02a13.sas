*********************************************************;
* Activity 2.13                                         *;
* NOTE: If you have not setup the Autoexec file in      *;
*       SAS Studio, open and submit startup.sas first.  *;
*********************************************************;
   
proc cas;
    phones={Apple="iPhone", Google="Pixel", Samsung="Galaxy"};
   *Complete do over statement *;

      print "Company:" || /*key*/ || " - " || "Phone Name:" || /*value*/;
      print "----------------------------";
    end;
quit;














*****************************;
* SOLUTION                  *;
*****************************;
/*
proc cas;
    phones={Apple="iPhone", Google="Pixel", Samsung="Galaxy"};
    do k,v over phones;
      print "Company:" || k || " - " || "Phone Name:" || v;
      print "----------------------------";
    end;
quit;
*/