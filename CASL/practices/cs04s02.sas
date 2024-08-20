*****************************************************************;
* Lesson 4: Practice 2 Solution                                 *; 
*****************************************************************;

proc cas;
    cars={name="cars", caslib="casuser"};
    table.columnInfo result=ci / table=cars;

* Store the result table *;
    carsDataDict=ci.columnInfo [,{"Column","Type","Format"}]
                   .compute("TableName","Cars")
                   .compute("Caslib","casuser"); 

* Save the results as a CSV file *;
    saveresult carsDataDict csv="&path/output/cars_data_dictionary.csv";
quit;
