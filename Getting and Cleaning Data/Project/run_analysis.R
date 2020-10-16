# run_analysis.R

library(dplyr)
library(tidyverse)

#setwd("Getting and Cleaning Data/Project/")

#' 1. Merges the training and the test sets to create one data set.

# Reading training data
xtrain <- read.table("train/X_train.txt", header = F)
ytrain <- read.table("train/y_train.txt", header = F)
subject_train <- read.table("train/subject_train.txt", header = F)

# Reading testing data
xtest <- read.table("test/X_test.txt", header = F)
ytest <- read.table("test/y_test.txt", header = F)
subject_test <- read.table("test/subject_test.txt", header = F)

# Read features
features <- read.table("features.txt", header = F)

# Activity labels
act_labels <- read.table("activity_labels.txt", header = F)

# Set names to the variables in each data frame
colnames(xtrain) <- features[,2]
colnames(xtest) <- features[,2]
colnames(ytest) <- "actID"
colnames(ytrain) <- "actID"
colnames(subject_test) <- "subID"
colnames(subject_train) <- "subID"
colnames(act_labels) <- c("actID", "actType")

# Merging training and data sets
mergtrain <- cbind(ytrain, subject_train, xtrain)
mergtest <- cbind(ytest, subject_test, xtest)

all_data <- rbind(mergtest, mergtrain)

#' 2. Extracts only the measurements on the mean and 
#' standard deviation for each measurement.

# Logical vector where mean and std are located. If mean or std are in the 
# colnames as in

colNames <- colnames(all_data)
logVec <- grepl("actID", colNames) | grepl("subID", colNames) |
        grepl("mean",colNames) | grepl("std",colNames)

setMeasurements <- all_data[,logVec]


#' 3. Uses descriptive activity names to name the activities in the data set

setMeasAct <- full_join(setMeasurements, act_labels, by = "actID")

#' 4. Appropriately labels the data set with descriptive variable names.

# This was already done in step 2 

#' 5. From the data set in step 4, creates a second, independent tidy data set 
#' with the average of each variable for each activity and each subject.

secondTidyData <- setMeasAct %>% 
        group_by(subID, actType) %>% # Group by subID and actID
        select(-c(actID)) %>% # Removes subID column
        summarise_all(mean) %>% # Aggregates by taking the mean
        arrange(subID, actType) %>% # Sort by subject and then by actType 
        ungroup() %>% # Removes grouping attribute
        as.data.frame() # Format as data frame

#' Since we have 30 volunteers and 6 activity types we have a data frame with
#' 180 observations

dim(secondTidyData)

View(secondTidyData)

