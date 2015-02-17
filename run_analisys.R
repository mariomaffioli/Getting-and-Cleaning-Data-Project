# Getting and Cleaning Data
# 
# THis is the main script that invokes all the 
# help functions required to complete the assigment
# 
# Let us first make sure that the environment is clear
rm(list=ls())

# load libraries
library(dplyr)

# source auxiliary scripts
source("load_data.R")

# load zip file to local disk
load.zip.file() 

# Unzip files and create data frames
activity <- unzip.activity()
column_names <- unzip.features()
subject_train <- unzip.subject.train()
subject_test <- unzip.subject.test()
train_data <- unzip.train.data(column_names)
test_data <- unzip.test.data(column_names)
activity_train <- unzip.activity.train()
activity_test <- unzip.activity.test()

# Process train data
train_subject_activity <- bind.subject.activity.train()
column_names <- colnames(train_subject_activity)
train_mean_std <- select.mean.std.train()

# Process train data
test_subject_activity <- bind.subject.activity.test()
test_mean_std <- select.mean.std.test()

# merge train and test data
full_mean_std <- merge.train.test.data()

# create tidy_data set
tidy_data_set <- create.tidy.data.set()

# Write the tidy_data set out to a file
write.table(tidy_data_set, file="tidy_data.txt", 
            row.names=FALSE) 

