## Overview

The script run_analysis.R performs the five tasks required for the Course Project. Namely, run_analysis.R:

*Uses descriptive activity names to name the activities in the data set
*Extracts only the measurements on the mean and standard deviation for each measurement. 
*Merges the training and the test sets to create one data set.
*Appropriately labels the data set with descriptive variable names. 
*Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

It should be noted that in the original definition of the Course Project, naming the activities with aproppriate names was the third step.

## Required packages

The following packages must be installed previous to running the script, and are automatically initialized at the start of the script.

* dplyr
* reshape2


## Steps

1. Prepare the necessary files by creating a folder in which to store them, and then downloading and unzipping the file. 
2. Read all the tables required for the project from the specified folder and store them as data frames using the read.table() function.
3. Add a column to the X_train and X_test containing the names of the activities.
4. Merge the training and the test sets to create one data set and arranges the values based on Subject and Activity using the arrange() function from the dplyr package.
5. Extract only the measurements on the mean and standard deviation by filtering the variable names containing "mean()" or "std()" using the grep() function.
6. Label the columns of the data frame with appropriate, more understandable variable names using the gsub() function.
7. Create a tidy data set with only the average of each of the variables, using the melt() and dcast() functions from the reshape2() package.
8. Export the tidy data set created in the previous step to a text file called tidy_data_set.txt using the write.table() function.

## Variables

* url: Link to the zip file with the data.
* features: Data frame with the data from features.txt 
* y_train: Data frame with the data from y_train.txt
* y_test: Data frame with the data from y_test.txt
* subject_test: Data frame with the data from subject_test.txt
* subject_train: Data frame with the data from subject_train.txt
* activity_labels <- Data frame with the data from activity_labels.txt
* X_train: Data frame with the data from X_train.txt
* X_test: Data frame with the data from X_test.txt 
* data: The "X_train" and "X_test" data frames binded.
* means: A numerical vector containing the position of the columns in "X_train" and "X_test" with the string "mean()" in them
* sdevs: A numerical vector containing the position of the columns in "X_train" and "X_test" with the string "std()" in * them
* filter: A numerical vector containing the position of the columns in "X_train" and "X_test" with either the string "mean()" or "std()" in them
* data2: The values of the data frame "data", excluding all columns whose names don not include either the string "mean()" or "std()" in them
* moltenData: A molten data frame made from data frame "data2" using the columns "Subject" and "Activity" as ID's
* tidy_ds: A data framet containing the averages of every column in "data2" for every combination of "Subject" and "Activity"
