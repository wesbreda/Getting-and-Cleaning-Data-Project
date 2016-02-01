#run_analysis.R
#1-31-2016
#Getting and Cleaning Data Final Project

library(dplyr)
library(tidyr)

#Obtain data files for the assignment and unzip
if (!file.exists("UCI HAR Dataset")) {  
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "data_folder.zip")
  unzip("data_folder.zip")
  }

#Get features and activity lables
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", sep = "", header = FALSE, col.names = c("activity", "description"))
features <- read.table("UCI HAR Dataset/features.txt", sep = "", header = FALSE)

#Get test and train data and subject id data
subject_test_df <- tbl_df(read.table("UCI HAR Dataset/test/subject_test.txt"))
subject_train_df <- tbl_df(read.table("UCI HAR Dataset/train/subject_train.txt"))

y_test_df <- tbl_df(read.table("UCI HAR Dataset/test/y_test.txt", sep = "", header = FALSE, col.names = c("activity")))
y_train_df <- tbl_df(read.table("UCI HAR Dataset/train/y_train.txt", sep = "", header = FALSE, col.names = c("activity")))

X_train_df <- tbl_df(read.table("UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE, col.names = features[[2]]))
X_test_df <- tbl_df(read.table("UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE, col.names = features[[2]]))

#Part 1: Merge the datasets into one dataset
X_df <- rbind(X_test_df, X_train_df)
y_df <- rbind(y_test_df, y_train_df)
subject_df <- rbind(subject_test_df, subject_train_df)

#Part 2: Extract Mean and Standard Devation columns only
X_df_select <- select(X_df, matches("mean|std"))

#Part 3: Give names to activities in data set and add subject ids
X_df_select <- mutate(X_df_select, subject = subject_df$V1, activity = y_df$activity)
X_df_select$activity[X_df_select$activity==1] <- "WALKING"
X_df_select$activity[X_df_select$activity==2] <- "WALKING_UPSTAIRS"
X_df_select$activity[X_df_select$activity==3] <- "WALKING_DOWNSTAIRS"
X_df_select$activity[X_df_select$activity==4] <- "SITTING"
X_df_select$activity[X_df_select$activity==5] <- "STANDING"
X_df_select$activity[X_df_select$activity==6] <- "LAYING"


#Part 4: Appropriately named variables
#This as added to the column names when the files were read into R.

#Part 5: Independent tidy data set with the average of each variable by activity.
X_df_group <- group_by(X_df_select, activity, subject)
tidy_summary_data <- summarise_each(X_df_group, funs(mean))
write.table(tidy_summary_data, "final_data_table.txt", row.names = FALSE)
