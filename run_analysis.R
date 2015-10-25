# load train data
x_train <- read.table("./train/X_train.txt", quote="\"", comment.char="")
subject_train <- read.table("./train/subject_train.txt", quote="\"", comment.char="")
y_train <- read.table("C:./train/y_train.txt", quote="\"", comment.char="")

dt1 <- x_train
dt1$y <- y_train$V1
dt1$subject <- subject_train$V1

#load test data
x_test <- read.table("./test/X_test.txt", quote="\"", comment.char="")
subject_test <- read.table("./test/subject_test.txt", quote="\"", comment.char="")
y_test <- read.table("C:./test/y_test.txt", quote="\"", comment.char="")

dt2 <- x_test
dt2$y <- y_test$V1
dt2$subject <- subject_test$V1

# (1) merge train and test data
dt_a <- rbind(dt1, dt2) 

# (2) extract only the measurements on the mean and 
#     standard deviation for each measurement
dt_b <- dt_a[,c("y","subject", "V1", "V2", "V3", "V4", "V5", "V6", "V41", "V42", "V43", "V44", "V45", "V46", 
                               "V81", "V82", "V83", "V84", "V85", "V86",
                               "V121", "V122", "V123", "V124", "V125", "V126", "V161", "V162", "V163", 
                               "V164", "V165", "V166", "V201", "V202", "V214",
                               "V215", "V227", "V228", "V240", "V241", "V253", "V254", 
                               "V266", "V267", "V268", "V269", "V270", "V271", "V345", "V346", "V347", 
                               "V348", "V349", "V350", "V424", "V425", "V426", "V427", "V428", "V429", 
                               "V503", "V504", "V516", "V517", "V529", "V530", "V542", "V543")]

# (3) create descriptive activity names
y <- c("1", "2", "3", "4", "5", "6")
activity <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
act_df <- data.frame(y, activity)

dt_c <- merge(act_df, dt_b, by = "y")
dt_c$y <- NULL

# (5) average of each variable for each activity and each subject
library(plyr)
# label the data set with descriptive variable names
dt_d <- rename(dt_c, c("V1" = "tBodyAcc-mean()-X", "V2" = "tBodyAcc-mean()-Y", "V3" = "tBodyAcc-mean()-Z", 
                             "V4" = "tBodyAcc-std()-X", "V5" = "tBodyAcc-std()-Y", "V6" = "tBodyAcc-std()-Z", 
                             "V41" = "tGravityAcc-mean()-X", "V42" = "tGravityAcc-mean()-Y", "V43" = "tGravityAcc-mean()-Z", 
                             "V44" = "tGravityAcc-std()-X", "V45" = "tGravityAcc-std()-Y", "V46" = "tGravityAcc-std()-Z", 
                             "V81" = "tBodyAccJerk-mean()-X", "V82" = "tBodyAccJerk-mean()-Y", "V83" = "tBodyAccJerk-mean()-Z", 
                             "V84" = "tBodyAccJerk-std()-X", "V85" = "tBodyAccJerk-std()-Y", "V86" = "tBodyAccJerk-std()-Z",
                             "V121" = "tBodyGyro-mean()-X", "V122" = "tBodyGyro-mean()-Y", "V123" = "tBodyGyro-mean()-Z", 
                             "V124" = "tBodyGyro-std()-X", "V125" = "tBodyGyro-std()-Y","V126" = "tBodyGyro-std()-Z", 
                             "V161" = "tBodyGyroJerk-mean()-X", "V162" = "tBodyGyroJerk-mean()-Y", "V163" = "tBodyGyroJerk-mean()-Z", 
                             "V164" = "tBodyGyroJerk-std()-X", "V165" = "tBodyGyroJerk-std()-Y", "V166" = "tBodyGyroJerk-std()-Z", 
                             "V201" = "tBodyAccMag-mean()", "V202" = "tBodyAccMag-std()", 
                             "V214" = "tGravityAccMag-mean()", "V215" = "tGravityAccMag-std()", 
                             "V227" = "tBodyAccJerkMag-mean()", "V228" = "tBodyAccJerkMag-std()", 
                             "V240" = "tBodyGyroMag-mean()", "V241" = "tBodyGyroMag-std()", 
                             "V253" = "tBodyGyroJerkMag-mean()", "V254" = "tBodyGyroJerkMag-std()", 
                             "V266" = "fBodyAcc-mean()-X", "V267" = "fBodyAcc-mean()-Y", "V268" = "fBodyAcc-mean()-Z", 
                             "V269" = "fBodyAcc-std()-X", "V270" = "fBodyAcc-std()-Y", "V271" = "fBodyAcc-std()-Z", 
                             "V345" = "fBodyAccJerk-mean()-X", "V346" = "fBodyAccJerk-mean()-Y", "V347" = "fBodyAccJerk-mean()-Z", 
                             "V348" = "fBodyAccJerk-std()-X", "V349" = "fBodyAccJerk-std()-Y", "V350" = "fBodyAccJerk-std()-Z", 
                             "V424" = "fBodyGyro-mean()-X", "V425" = "fBodyGyro-mean()-Y", "V426" = "fBodyGyro-mean()-Z", 
                             "V427" = "fBodyGyro-std()-X", "V428" = "fBodyGyro-std()-Y", "V429" = "fBodyGyro-std()-Z", 
                             "V503" = "fBodyAccMag-mean()", "V504" = "fBodyAccMag-std()", 
                             "V516" = "fBodyBodyAccJerkMag-mean()", "V517" = "fBodyBodyAccJerkMag-std()", 
                             "V529" = "fBodyBodyGyroMag-mean()", "V530" = "fBodyBodyGyroMag-std()", 
                             "V542" = "fBodyBodyGyroJerkMag-mean()", "V543" = "fBodyBodyGyroJerkMag-std()"))
#dt_e = group_by(dt_d, "activity", "subject")

tidy_db <- ddply(dt_d, .(activity, subject), numcolwise(mean))

write.table(tidy_db, "run_analysis_result.txt", row.name = FALSE)