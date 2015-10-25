# Data Cleaning Project : Zografoula Vagena

The run_analysis.R should reside in the same directory as the
test/ and train/ directories and does the following. 

* Reads the train and test files (./train/X_train.txt, ./train/subject_train.txt, ./train/y_train.txt
  and ./test/X_test.txt, ./test/subject_test.txt, ./test/y_test.txt) using the read.table command
* Merges the training and the test sets to create one data set
* Extracts only the measurements on the mean and standard deviation for each measurement by
  subsetting the previous data frame
* joins the data frame with one that has descriptive activity names using the merge command 
* renames the appropriate columns to label the data set with descriptive variable names 
* uses ddply to group by (activity, subject) and get the mean of each variable for eash such group
* writes the final data frame to a .txt file using the write.table command

