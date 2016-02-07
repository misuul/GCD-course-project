run_analysis <- function() {
    ## 0) Read raw data
    activity_labels <- read.table("activity_labels.txt")
    features <- read.table("features.txt")
    subject_test <- read.table("test/subject_test.txt")
    y_test <- read.table("test/y_test.txt")
    X_test <- read.table("test/X_test.txt")
    subject_train <- read.table("train/subject_train.txt")
    y_train <- read.table("train/y_train.txt")
    X_train <- read.table("train/X_train.txt")
    
    ## 1) Merge the test and training sets
    subject <- rbind(subject_test, subject_train)
    y <- rbind(y_test, y_train)
    X <- rbind(X_test, X_train)
    colnames(subject) <- c("subject_test")
    colnames(y) <- c("activity_code")
    colnames(X) <- features[,2]
    d <- cbind(subject, y, X)
    
    ## 2) Extract only the measurements on mean and standard deviation for each feature
    library(dplyr)
    dt <- tbl_df(d)
    valid_column_names <- make.names(names = names(dt), unique = TRUE, allow_ = TRUE)
    names(dt) <- valid_column_names
    grep("(\\.std|\\.mean\\()", valid_column_names)
    df <- select(dt, subject_test, activity_code, mscols)
    
    ## 3) Use descriptive activity names
    dm <- mutate(df, activity_name = activity_labels[df$activity_code, 2])
    lastCol <- dim(dm)[2]
    dm <- dm[,c(1, 2, lastCol, 3:(lastCol-1))]
    
    ## 4) Label dataset with descriptive variable names
    nm <- names(dm)
    nm <- gsub("tBody", "timeBody", nm)
    nm <- gsub("tGravity", "timeGravity", nm)
    nm <- gsub("fBody", "frequencyDomainBody", nm)
    nm <- gsub("Gyro", "Gyroscope", nm)
    nm <- gsub("\\.\\.", ".", nm)
    nm <- gsub("\\.\\.", ".", nm)
    nm <- tolower(nm)
    nm <- gsub("bodybody", "body", nm)
    colnames(dm) <- nm
    
    ## 5) Create a second dataset with the average of each variable for each activity and each subject
    smr <- dm %>% group_by(subject_test, activity_name) %>% summarise_each(funs(mean))
    smr
}
