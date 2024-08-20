*****************************************************************;
* Lesson 4: Practice 5                                          *; 
*****************************************************************;

/***************************************************************************
 Validate heart_raw data to ensure it data conforms to business rules.
 - Blood pressure rules:
       if 20 <= Diastolic <= 200  then badDBP=0;
       else badDBP=1;

 - Output table should include only these columns:
 - AgeAtDeath, Smoking_Status, Diastolic,and badDBP
 - Compute Diastolic value frequencies where badDBP is 1 and 
 - AgeAtDeath is not missing. 
***************************************************************************/
%include "&path/data/load_heart_raw.sas";

proc cas;
    inTbl= {name="heart_raw", caslib="cs"};
    outTbl={name="heart_badFlags", caslib="casuser"};
    
    source flagCode;
    
    
    endsource;
    
    table.copyTable /
        table=inTbl
    
       ,casout=outTbl||{replace=TRUE}
    ;
    simple.freq /
        table=outTbl,
;
quit;