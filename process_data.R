# Contains the helper functions that process the 
# 'train' and 'test' files and then merges them 
# and selects only the variables with 'mean' or 'std'
# in their names.  Finally a function is provided to
# create a tidy_data_set and to generate the
# 'tidy_data.txt" file on disk

# Augmment the 'train' data set with the subject_id and
# activity code variables
bind.subject.activity.train <- function(){
    large_work_data_set <- 
        bind_cols(select(activity_train, activity), train_data)
    large_work_data_set <-
        bind_cols(subject_train, large_work_data_set)
    large_work_data_set <- tbl_df(large_work_data_set )    
    large_work_data_set
    
}

# select only the subject_is, activity variables and
# all the variables with mean or std in their names
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

# Augment the test data set with the subject_ID and 
# actity_code columns
bind.subject.activity.test <- function(){
    large_work_data_set <- 
        bind_cols(select(activity_test, activity), test_data)
    large_work_data_set <-
        bind_cols(subject_test, large_work_data_set)
    large_work_data_set <- tbl_df(large_work_data_set )    
    large_work_data_set
    
}

# select only the subject_is, activity variables and
# all the variables with mean or std in their names
select.mean.std.test <- function(){
    selector_vector  <- 
        c(
            column_names[grep("subject_ID" ,column_names)],
            column_names[grep("^act",column_names)],
            column_names[grep(".mean.",column_names)],
            column_names[grep(".std.",column_names)]
        )
    
    select(test_subject_activity, one_of(selector_vector))    
    
}

# merge the train and test data frames
merge.train.test.data <- function(){
    total_work_data_set <- 
        bind_rows(train_mean_std, test_mean_std)
    total_work_data_set <- tbl_df(total_work_data_set)
    total_work_data_set
    
}


create.tidy.data.set <- function(){
    data_set <-     
        ( aggregate(full_mean_std, 
                    by=list(full_mean_std$subject_ID,
                            full_mean_std$activity), 
                    mean, simplify = TRUE)) 
    data_set <-(select(data_set, -subject_ID,-activity ))  
    cn <- colnames(data_set)
    cn[1] <- "subject_ID"
    cn[2] <- "activity"
    colnames(data_set) <- cn 
    data_set
    
}





