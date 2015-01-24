# coursera-Getting_and_cleaning_data--course_project
tidy data from the accelerometers from the Samsung Galaxy S smartphone. Course project for Getting and Cleaning data in coursera


This project contain one R script called run_analysis.R.

"run_analysis.R" works with the data collected from the accelerometers from the Samsung Galaxy S smartphone available at:
	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

A full description is available at the site where the data was obtained: 
	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

"run_analysis.R" does the following:
	1) Merges the training and the test sets to create one data set. It saves the data set as a txt file called "data1.txt"
	2) Extracts only the measurements on the mean and standard deviation for each measurement. 
	3) Uses descriptive activity names to name the activities in the data set.
	4) Appropriately labels the data set with descriptive variable names. It saves the data sub-set (which contains means and sd) as a txt file called "data2.txt"
	5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. It saves the new data set as a txt file called "bySub_byAct_mean.txt"



Steps in the script:
1) Merges the training and the test sets to create one data set.
	0) set the working directory where data was extracted
	a) get the data from all variables from test
	b) get the activity and subject that correspond to each record in the data
	c) combine all above in a data.frame
	d) repeat steps "a", "b" and "c" in training data set
	e) merge Xtest and Xtrain
	f) put the correct name to each variable
	g) save the data set as "data1.txt"

2) Extracts only the measurements on the mean and standard deviation for each measurement.

3) Uses descriptive activity names to name the activities in the data set.

4) Appropriately labels the data set with descriptive variable names.
	save the data sub-set (which contains means and sd) as a txt file called "data2.txt"

5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	save the new data set as a txt file called "bySub_byAct_mean.txt"
