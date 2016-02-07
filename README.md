# GCD-course-project

The script loads the activity labels and features, then the test and training sets. 

These are merged, then only the relevant columns selected using dplyr.
Descriptive activity names added, then the column moved next to activity codes for readability.
Variable names are then tidied up and made more descriptive:
    * the "t" and "f" prefixes are substituted for "time" and "frequencydomain", respectively
    * extra dots are removed, but left dots to outline std vs mean and the xyz axis
    * all names converted to lowercase
    
A new dataset is created by grouping the data by subject and activity type, showing the mean of each variable.
