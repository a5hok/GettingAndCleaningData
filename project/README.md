Course Project
==============

* Unzip the source (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) into a folder on your local drive, say $HOME/Documents/GettingAndCleaningData/ (where $HOME is the home directory of the user. On windows this is likely to be C:\Users\username\ )

* Copy run_analysis.R into the unzipped folder ($HOME/Documents/GettingAndCleaningData/UCI HAR Dataset)

* In RStudio: setwd("$HOME/Documents/GettingAndCleaningData/UCI HAR Dataset")

* In RStudio: source("run_analysis.R")

* The output of step 5 of the analysis is a tidy data set - tidy_data_set_with_the_averages.txt

* Use data <- read.table("tidy_data_set_with_the_averages.txt") to read the data. The resulting data frame is 180x68 as there are 30 subjects and 6 activities, thus "for each activity and each subject" means 30 * 6 = 180 rows. 

* Note that the provided R script makes no assumptions on numbers of records, only on locations of files.