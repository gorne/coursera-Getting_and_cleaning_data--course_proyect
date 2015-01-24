# 1) Merges the training and the test sets to create one data set.
# set the working directory where data was extracted
setwd("/home/lucas/LUCAS/trabajo/doctorado/cursos/Getting and cleaning data/quizzes/proyect")

# a) get the data from all variables from test
Xtest <- read.table("UCI HAR Dataset/test/X_test.txt")

# b) get the activity and subject that correspond to each record in the data
Activity_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# c) combine all above in a data.frame
Xtest <- cbind(subject_test, Activity_test, Xtest)


# d)repeat steps "a", "b" and "c" in training data set
Xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")

Activity_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

Xtrain <- cbind(subject_train, Activity_train, Xtrain)

# e) merge Xtest and Xtrain
Xall <- rbind(Xtest, Xtrain)

# f) put the correct name to each variable
features <- read.table("UCI HAR Dataset/features.txt")
features <- as.vector(features[,2])

colnames(Xall) <- c("subject","activity",features)

library(dplyr)
Xall_tbl <- tbl_df(Xall)

duplicated(features)	# there are duplicated colnames, but...

Xall_tbl <- unique(Xall_tbl, MARGIN=2)
ncol(Xall_tbl)		# the information in columns are not duplicated

#so we need to change the duplicated names
dupli <- duplicated(features) #we identify the duplicated names
dupli_n <- sum(duplicated(features)) # there are 84 duplicated names
duplinum <- as.character(c(1:dupli_n))

j=1
for(i in 1:length(features)){
	if (dupli[i]==TRUE){
		features[i] <- paste(features[i], duplinum[j], sep=".")
		j=j+1
	}
}
#we add a arbitrary number to each duplicated name to ensure that names became uniques

#now we reload colnames
colnames(Xall) <- c("subject","activity",features)
colnames(Xall_tbl) <- c("subject","activity",features)

# g) write.table(Xall, "data1.txt", row.name=FALSE)

# 2) Extracts only the measurements on the mean and standard deviation for each measurement.

subXall_tbl <- select(Xall_tbl, subject, activity, contains("mean()"), contains("std()"))
 
# 3) Uses descriptive activity names to name the activities in the data set.
activities <- read.table("UCI HAR Dataset/activity_labels.txt")

subXall_tbl$activity <- cut(subXall_tbl$activity, breaks=6, labels=activities[,2])
write.table(subXall_tbl, "data2.txt", row.name=FALSE)

# 4) Appropriately labels the data set with descriptive variable names.
# the data set is already with descriptive variable names

# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
bySub_byAct <- group_by(subXall_tbl, subject, activity)

bySub_byAct_mean <- summarise_each(bySub_byAct,funs(mean))

write.table(bySub_byAct_mean, "bySub_byAct_mean.txt", row.name=FALSE)
