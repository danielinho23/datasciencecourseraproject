###DOWNLOADING AND OPENING THE DATA
library(data.table)
fileurl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if (!file.exists('./UCI HAR Dataset.zip')){
  download.file(fileurl,'./UCI HAR Dataset.zip', mode = 'wb')
  unzip("UCI HAR Dataset.zip", exdir = getwd())
}


features <- read.csv('./UCI HAR Dataset/features.txt', header = FALSE, sep = ' ')
features <- as.character(features[,2])

x_train <- read.table('./UCI HAR Dataset/train/X_train.txt')
y_train <- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')
subject_train <- read.csv('./UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')

merge_train <-  data.frame(subject_train, y_train, x_train)
names(merge_train) <- c(c('subject', 'activity'), features)

x_test <- read.table('./UCI HAR Dataset/test/X_test.txt')
y_test <- read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
subject_test <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')

merge_test <-  data.frame(subject_test, y_test, x_test)
names(merge_test) <- c(c('subject', 'activity'), features)

### 1. MERGES BOTH TABLES INTO 1 CALLED (data.all)
data.all <- rbind(merge_train, merge_test)


### 2. Extracts only the measurements on the mean and standard deviation for each measurement
mean_std_filter <- grep('mean|std', features)
new_data.all <- data.all[,c(1,2,mean_std_filter + 2)]

### 3. 3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
activity_labels <- as.character(activity_labels[,2])
new_data.all$activity <- activity_labels[new_data.all$activity]

### 4.Appropriately labels the data set with descriptive variable names.
name.new <- names(new_data.all)
name.new <- gsub("[(][)]", "", name.new)
name.new <- gsub("^t", "TimeDomain_", name.new)
name.new <- gsub("^f", "FrequencyDomain_", name.new)
name.new <- gsub("Acc", "Accelerometer", name.new)
name.new <- gsub("Gyro", "Gyroscope", name.new)
name.new <- gsub("Mag", "Magnitude", name.new)
name.new <- gsub("-mean-", "_Mean_", name.new)
name.new <- gsub("-std-", "_StandardDeviation_", name.new)
name.new <- gsub("-", "_", name.new)
names(new_data.all) <- name.new

### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
new_tidy_table <- aggregate(new_data.all[,3:81], by = list(activity = new_data.all$activity, subject = new_data.all$subject),FUN = mean)
write.table(x = new_tidy_table, file = "data_tidy.txt", row.names = FALSE)
