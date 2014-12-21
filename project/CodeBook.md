Course Project Code Book
========================

Source of the original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The attached R script (run_analysis.R) performs the following to clean up the data:

* Merges the training and test sets to create one data set
        * train/X_train.txt with test/X_test.txt which results in a 10299x561 data frame, as in the original description ("Number of Instances: 10299" and "Number of Attributes: 561")
        * train/subject_train.txt with test/subject_test.txt which results in a 10299x1 data frame with subject IDs
        * train/y_train.txt with test/y_test.txt which also results in a 10299x1 data frame with activity IDs.

* Reads features.txt and extracts only the measurements on the mean and standard deviation for each measurement. The result is a 10299x79 data frame, because only 79 out of 561 attributes are measurements on the mean and standard deviation.

* Reads activity_labels.txt and applies descriptive activity names to name the activities in the data set:
        * WALKING
        * WALKING_UPSTAIRS
        * WALKING_DOWNSTAIRS
        * SITTING
        * STANDING
        * LAYING

* The script also labels the data set with descriptive names: all feature names (attributes) and activity names are converted to camel case. The old and new variable names are described below. Then it merges the 10299x79 data frame containing features with 10299x1 data frames containing activity labels and subject IDs. The result is a 10299x81 data frame such that the first column contains subject IDs, the second column activity names, and the last 79 columns are measurements. Subject IDs are integers between 1 and 30 inclusive. The names of the attributes are similar to the following:


|New Variable Names                                           |Originally Variable Names|
--------------------------------------------------------------|-------------------------|
|Time_Body_*                                       |tBody*      |
|Time_Gravity_*                                    |tGravity*   |
|Freq_Body_*                                       |fBody*      |
|_Standard_Deviation*                              |-std()*     |
|_Mean*                                            |-mean()*    |
|_Magnitute*                                       |Mag()*      |


* Finally, the script creates a 2nd, independent tidy data set with the average of each measurement for each activity and each subject. The result is saved as tidy_data_set_with_the_averages.txt, a 180x81 data frame, where as before, the first column contains activity names, the second column contains subject IDs (see below), and then the averages for each of the 79 attributes are in columns 3...81. There are 30 subjects and 6 activities, thus 180 rows in this data set with averages.