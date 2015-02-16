# Contains the helper functions that load the zipped 
# file to local disc and then unzips the files required for the
# to local variables.


# This code loads the zip file to local disk and 
# places it in the 'data' directory

load.zip.file <- function(){
    if(!file.exists("data")){dir.create("data")}
    
    download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',
                  "./data/project.zip",method="auto" )    
    
}

# unzip the 'UCI HAR Dataset/activity_labels.txt'
# file into an 'activity' data frame

unzip.activity <- function(){
    activity <- read.table(unz("./data/project.zip", "UCI HAR Dataset/activity_labels.txt"), header=F,sep="",as.is=2 )
    activity <- tbl_df(activity)
    colnames(activity) <- c("Code","Name")
    activity    
}

unzip.features <- function(){
    column_names <- read.table(unz("./data/project.zip", "UCI HAR Dataset/features.txt"), header=F,sep="")
    column_names <- tbl_df(column_names)
    colnames(column_names) <- c("ID", "features")    
    remove.duplicate.names(column_names)
}

remove.duplicate.names <- function(column_names){
    f <- as.character(column_names$features)
    class(f)
    f[1:302]
    f[345:381]
    f[424:460]
    f[503:561]
    f <- (c(f[1:302],f[345:381],f[424:460],f[503:561] ))
    f    
    
}

unzip.subject.train <- function(){
    
    subject_train <- read.table(unz("./data/project.zip", "UCI HAR Dataset/train/subject_train.txt"), header=F,sep="")
    subject_train <- tbl_df(subject_train)
    colnames(subject_train) <- c("subject_ID")
    subject_train    
}

unzip.subject.test <- function(){
    subject_test <- read.table(unz("./data/project.zip", "UCI HAR Dataset/test/subject_test.txt"), header=F,sep="")
    subject_test <- tbl_df(subject_test)
    colnames(subject_test) <- c("subject_ID")
    subject_test    
    
}

unzip.train.data <- function(column_names){
    train_data <- read.table(unz("./data/project.zip", "UCI HAR Dataset/train/X_train.txt"), header=F,sep="")
    train_data <- tbl_df(train_data)
    train_data <- remove.duplicate.columns(train_data)
    colnames(train_data) <- column_names
    train_data
}

remove.duplicate.columns <- function(data){
    data <- bind_cols(
        select(data, num_range("V",1:302)), 
        select(data, num_range("V",345:381)),
        select(data, num_range("V",424:460)),
        select(data, num_range("V",503:561))
        ) 

    data 
}

unzip.test.data <- function(column_names){
    test_data <- read.table(unz("./data/project.zip", "UCI HAR Dataset/test/X_test.txt"), header=F,sep="")
    test_data <- tbl_df(test_data)
    test_data <- remove.duplicate.columns(test_data)
    colnames(test_data) <- column_names
    test_data
}

unzip.activity.train <- function(){
    activity_vector <- read.table(unz("./data/project.zip", "UCI HAR Dataset/train/y_train.txt"), header=F,sep="")
    activity_vector  <- tbl_df(activity_vector )
    colnames(activity_vector) <- c("activity_code")
    activity_vector <- mutate(activity_vector, activity = activity$Name[activity_code])
    activity_vector

}
unzip.activity.test <- function(){
    activity_vector <- read.table(unz("./data/project.zip", "UCI HAR Dataset/test/y_test.txt"), header=F,sep="")
    activity_vector  <- tbl_df(activity_vector )
    colnames(activity_vector) <- c("activity_code")
    activity_vector <- mutate(activity_vector, activity = activity$Name[activity_code])
    activity_vector     
    
}

bind.subject.activity <- function(){
    large_work_data_set <- 
        bind_cols(select(activity_train, activity), train_data)
    large_work_data_set <-
        bind_cols(subject_train, large_work_data_set)
    large_work_data_set <- tbl_df(large_work_data_set )    
    large_work_data_set
    
}

select.mean.std.train <- function(){
    selector_vector  <- 
        c(
            column_names[grep("subject_ID" ,column_names)],
            column_names[grep("^act",column_names)],
            column_names[grep(".mean.",column_names)],
            column_names[grep(".std.",column_names)]
        )
     
        select(train_subject_activity, one_of(selector_vector))    

}
