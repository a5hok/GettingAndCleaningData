library(plyr)
library(reshape2)

# Source of data for this project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# This R script does the following:

# 1. Merges the training and the test sets to create one data set.

# Read in Xtrain data
Xtrain <- read.table("train/X_train.txt",header=FALSE)
Xtest <- read.table("test/X_test.txt",header=FALSE)
data_set_Xtrain_Xtest <- rbind (Xtrain,Xtest)


# Read in Y data - Activity Labels
Ytrain <- read.table("train/Y_train.txt",header=FALSE)
Ytest <- read.table("test/Y_test.txt",header=FALSE, stringsAsFactors=FALSE)
data_set_Ytrain_Ytest <- rbind (Ytrain,Ytest)

# Read in subject data
subject_train_data <- read.table("train/subject_train.txt",header=FALSE)
subject_test_data <- read.table("test/subject_test.txt",header=FALSE)
subject_data <- rbind (subject_train_data,subject_test_data)

# read in the features table to add as column names to merged file of Xtrain and Xtest observations
features_table <- read.table("features.txt",header=FALSE)

# put the features table into a features vector
features_vector <- features_table[,2]

# copy the features into the column names of the merged data frame
colnames(data_set_Xtrain_Xtest) <- features_vector

# Read in activity descriptions
activity_names_table <- read.table("activity_labels.txt",header=FALSE)
activity_list <- as.character(activity_names_table[,2])

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# Extracts only the measurements on the mean
extract_data_set_mean <- data_set_Xtrain_Xtest[, grepl("mean()", names(data_set_Xtrain_Xtest))]

# Extracts only the measurements on standard deviation 
extract_data_set_std <- data_set_Xtrain_Xtest[, grepl("std()", names(data_set_Xtrain_Xtest))]

# Merge the measurements on the mean and standard deviation for each measurement.
extract_data_set_mean_std <- cbind (extract_data_set_mean,extract_data_set_std)

# add activity column in the beginning of the data frame
extract_data_set_mean_std_f <- cbind (data_set_Ytrain_Ytest,extract_data_set_mean_std)

# add column name for the activity column
colnames (extract_data_set_mean_std_f)[1] <- c("Activity")

# 3. Uses descriptive activity names to name the activities in the data set.

# 1 WALKING
# 2 WALKING_UPSTAIRS
# 3 WALKING_DOWNSTAIRS
# 4 SITTING
# 5 STANDING
# 6 LAYING

extract_data_set_mean_std_final <- extract_data_set_mean_std_f
row_count_extract <- nrow(extract_data_set_mean_std_final)
Activity_Label = " "
for (i in 1:row_count_extract) { index_1 <- extract_data_set_mean_std_final[i,1]
+                                  Activity_Label[i] <- activity_list[index_1]
+ }

# Merge the measurements on the mean and standard deviation for each measurement.
extract_data_set_mean_std_final_with_activity_name <- cbind (Activity_Label,extract_data_set_mean_std_final)

# add column name for the activity label column
colnames (extract_data_set_mean_std_final_with_activity_name)[1] <- c("Activity_Label")

# add subject column in the beginning of the data frame
extract_data_set_mean_std_final_with_activity_name2 <- cbind (subject_data,extract_data_set_mean_std_final_with_activity_name)

# add column name for the subject column
colnames (extract_data_set_mean_std_final_with_activity_name2)[1] <- c("Subject")

# remove integer activity column
extract_temp <- extract_data_set_mean_std_final_with_activity_name2
extract_temp$Activity <- NULL

# 4. Appropriately labels the data set with descriptive activity names.

colnames(extract_temp) <- gsub("tBody", "Time_Body_", colnames(extract_temp))
colnames(extract_temp) <- gsub("tGravity", "Time_Gravity_", colnames(extract_temp))
colnames(extract_temp) <- gsub("fBody", "Freq_Body_", colnames(extract_temp))
colnames(extract_temp) <- gsub("-std()", "_Standard_Deviation", colnames(extract_temp))
colnames(extract_temp) <- gsub("-mean()", "_Mean", colnames(extract_temp))
colnames(extract_temp) <- gsub("Mag()", "_Magnitute", colnames(extract_temp))

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

extract_temp_mean2 <- ddply(extract_temp, .(Activity_Label,Subject),numcolwise(mean))
write.table(extract_temp_mean2, file = "tidy_data_set_with_the_averages.txt", row.name=FALSE)