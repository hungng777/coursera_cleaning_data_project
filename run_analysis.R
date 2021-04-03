
# Assume the current working directory contains the data directory "UCI HAR Dataset".
# Change the working directory to the data directory.
setwd("UCI HAR Dataset")


# Require the following R libraries.
library(tidyr)
library(dplyr)


# Read in features.
features <- scan("features.txt", what="character")
#
features <- features[seq(2, length(features), 2)]
# An alternative:
# features <- features[seq_along(features] %% 2 > 0]

# Appropriately labels the data set with descriptive variable names.
# - change "-" to "." since "-" is an invalid variable character
# - remove "()" since both "(" and ")" are invalid variable characters
# Example:
#   - "tBodyAcc-mean()-X" is converted to "Time.BodyAcceleration.mean.X"
#
features <- gsub("^t", "Time.", features)
features <- gsub("^f", "Freq.", features)
features <- gsub("Acc", "Acceleration", features)
features <- gsub("Gyro", "Gyration", features)
features <- gsub("Mag", "Magnitude", features)
features <- gsub("\\-", ".", features)				# 
features <- gsub("\\(\\)", "", features)			


# Read in activity label file as a data.frame.
# Variable "activity" contains descriptive activity names. 
activity_labels <- read.table("activity_labels.txt", col.names=c("activity_id", "activity"))


# Read in all training related data
subject <- read.table("train/subject_train.txt", col.names=c("subject"))
activity <- read.table("train/y_train.txt", col.names=c("activity_id"))
train <- read.table("train/X_train.txt", col.names=features)

# Uses descriptive activity names to name the activities in the data set.
# Data.frame "activity_labels" contains descriptive activity names.
# Variable "activity" contains the actual descriptive activity names.
# Merge/Join data.frames "activity" and "activity_labels" to obtain descriptive activity names. 
merged_activity <- merge(activity, activity_labels, by.x="activity_id", by.y="activity_id")
activity_names <- select(merged_activity, activity)

# Extracts only the measurements on the mean and standard deviation for each measurement. 
train <- select(train, contains(c(".mean", ".std")))

# Combine all training data horizontally
subject_activity <- cbind(subject, activity_names)
train <- cbind(subject_activity, train)


# Read in all testing related data
subject <- read.table("test/subject_test.txt", col.names=c("subject"))
activity <- read.table("test/y_test.txt", col.names=c("activity_id"))
test <- read.table("test/X_test.txt", col.names=features)

# Uses descriptive activity names to name the activities in the data set.
# Data.frame "activity_labels" contains descriptive activity names.
# Variable "activity" contains the actual descriptive activity names.
# Merge/Join data.frames "activity" and "activity_labels" to obtain descriptive activity names. 
merged_activity <- merge(activity, activity_labels, by.x="activity_id", by.y="activity_id")
activity_names <- select(merged_activity, activity)

# Extracts only the measurements on the mean and standard deviation for each measurement. 
test <- select(test, contains(c(".mean", ".std")))

# Combine all testing data horizontally
subject_activity <- cbind(subject, activity_names)
test <- cbind(subject_activity, test)


# Merges (vertically) the training and the test sets to create one data set.
data_set <- rbind(train, test)



# Creates a second, independent tidy data set with the average of each variable for each 
# activity and each subject.
average_data_set <- data_set %>%
  gather(feature, value, -(subject:activity)) %>%
  group_by(subject, activity, feature) %>%
  mutate(average = mean(value)) %>%
  subset(select = -(value)) %>%
  unique() %>%
  arrange(subject, activity)


# Write out the average_data_set to a file.
write.table(average_data_set, file="average_data_set.txt", row.name=FALSE)



# Print out the wbole average_data_set.
#head(average_data_set, n=nrow(average_data_set)) %>% 
#  print(n=nrow(average_data_set))





