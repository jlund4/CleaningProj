CleaningProj
============

This is the getting and cleaning data project for coursera
Here is the data I used:
activity_labels - assigns a number to the six activities being measured
subject_test - Gives the subject identifier for those who were in the test group
Y_test - This is the activities identifier for those in the test group
X_test - This is the table of all the measurements for the test group
subject_train - Gives the subject identifier for those who were in the training group
Y_train - This is the activities identifier for those in the training group
X_train - This is the table of all the measurements for the trainiing group

My R script is annotated. I added in these files. I renamed the variables for subjtest, subjtraing, Y_test, Y_train to be 
more explicit in terms of what they are.
I combined the files into one big data set. 
I identified the varibles that measure means and standard deviataions and subsetted the big data set to just extract
those variables. 
I added string variables that tell explicitly what the activities are.
I melted the data to get a long data set where are row provides the subject id, and activity and measurement for every subject, activity, and variable combination in the data set.
I then aggregated the data to get the means for each of these measurements for each subject-activity. 


