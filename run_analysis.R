library(dplyr)
library(reshape2)

########################
##   0. Preparation   ##
########################

## Download the .zip file and unzip it, 
## resulting in the whole data set unzipped in a directory called "UCI HAR Dataset"

if(!file.exists("./Course Project"))  {
        dir.create("./Course Project")
        }

url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./Course Project/Dataset.zip")
unzip("./Course Project/Dataset.zip", exdir = "./Course Project")

## Read all the tables required for this project and store them as data frames

features <- read.table("./Course Project/UCI HAR Dataset/features.txt", quote="\"", stringsAsFactors=FALSE)
y_train <- read.table("./Course Project/UCI HAR Dataset/train/y_train.txt", quote="\"", stringsAsFactors=FALSE)
y_test <- read.table("./Course Project/UCI HAR Dataset/test/y_test.txt", quote="\"", stringsAsFactors=FALSE)
subject_test <- read.table("./Course Project/UCI HAR Dataset/test/subject_test.txt", quote="\"", stringsAsFactors=FALSE)
subject_train <- read.table("./Course Project/UCI HAR Dataset/train/subject_train.txt", quote="\"", stringsAsFactors=FALSE)
activity_labels <- read.table("./Course Project/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
X_train <- read.table("./Course Project/UCI HAR Dataset/train/X_train.txt", quote="\"", stringsAsFactors=FALSE, col.names = features$V2)
X_test <- read.table("./Course Project/UCI HAR Dataset/test/X_test.txt", quote="\"", stringsAsFactors=FALSE, col.names = features$V2)

#################################################################################
##                                                                             ##
## 3. Uses descriptive activity names to name the activities in the data set   ##
##                                                                             ##
#################################################################################


## Add a column called Activity to X_train and X_test, containing the names of the activities. The code takes the activity code from y_train and
## x_train, and extracts the matching activity name from the correspondent value in activity_labels

X_train$Activity <- activity_labels$V2[y_train$V1]
X_test$Activity <- activity_labels$V2[y_test$V1]

#######################################################################
##                                                                   ##
## 1. Merges the training and the test sets to create one data set.  ##
##                                                                   ##
#######################################################################


## Add a column to X_train and X_test with the subjects IDs, previously stored in the data frames subject_train and subject_test
X_train$Subject <- subject_train$V1
X_test$Subject <- subject_test$V1

## Bind the two main tables (X_train and X_test) in a new dataframe called data
data <- rbind(X_train, X_test)
data <- arrange(data, Subject, Activity)

#################################################################################################
##                                                                                             ##
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.  ##
##                                                                                             ##
#################################################################################################

means <- grep("mean()", features$V2)
sdevs <- grep("std()", features$V2)
filter <- sort(c(means, sdevs))
data2 <- data[,c(562,563,filter)]

#############################################################################
##                                                                         ##
## 4. Appropriately labels the data set with descriptive variable names.   ##
##                                                                         ##
#############################################################################

names(data2)<-gsub("^t", "Time-", names(data2))
names(data2)<-gsub("^f", "Frequency-", names(data2))
names(data2)<-gsub("Acc", "Accelerometer", names(data2))
names(data2)<-gsub("Gyro", "Gyroscope", names(data2))
names(data2)<-gsub("Mag", "Magnitude", names(data2))
names(data2)<-gsub("BodyBody", "Body", names(data2))
names(data2)<-gsub("\\.\\.\\.", "-", names(data2))
names(data2)<-gsub("\\.\\.", "", names(data2))
names(data2) <- gsub("\\.std","-Standard_Deviation",names(data2))
names(data2) <- gsub("\\.mean","-Mean",names(data2))
names(data2) <- gsub("MeanFreq","Mean_Frequency",names(data2))

#######################################################################################################################################################
##                                                                                                                                                   ##
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. ##
##                                                                                                                                                   ##
#######################################################################################################################################################

## Melt the data2 data frame, and use dcast from library reshape2 to create a tidy table with the means for part 5 of the assignment
moltenData <- melt(data2, id=c("Subject", "Activity"))
tidy_ds <- dcast(moltenData, Subject + Activity ~ variable, mean)

## Finally, we export the tidy data set to a text file

write.table(tidy_ds, file = "tidy-data-set.txt", row.name=FALSE)
