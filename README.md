# Getting and Cleaning Data Course Project

## Overview 

This repository contains the script (run_analysis.R), Readme (README.md) and CodeBook (CodeBook.md) of my Course Project for the Getting and Cleaning Data course on Coursera.org

## Data

The data used for this Course Project can be downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

However, downloading the file is not necessary since **the script downloads and unzips all necessary data at the beginning**.

A total of eight (8) text files inside the downloaded zip file were used in the script:
* features: Contains all the variable names (a total of 561).
* y_train: The activity code for every observation in the "train" data set (a total of 7352).
* y_test: The activity code for every observation in the "test" data set (a total of 2947).
* subject_test: The subject code for every observation in the "train" data set (a total of 7352).
* subject_train: The subject code for every observation in the "test" data set (a total of 2947).
* activity_labels <- The equivalence between every activity code and its corresponding activity name (a total of 6).
* X_train: All the measurements of every variable for every subject randomly assigned to the "train" data set.
* X_test: All the measurements of every variable for every subject randomly assigned to the "test" data set.


Additional information about the data, such as how and in which conditions it was generated, can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
