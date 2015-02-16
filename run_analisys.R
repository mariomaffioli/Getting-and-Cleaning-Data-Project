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

# Unazip files and create data frames
activity <- unzip.activity()
column_names <- unzip.features()
subject_train <- unzip.subject.train()
subject_test <- unzip.subject.test()
train_data <- unzip.train.data(column_names)
test_data <- unzip.test.data(column_names)
activity_train <- unzip.activity.train()
activity_test <- unzip.activity.test()


