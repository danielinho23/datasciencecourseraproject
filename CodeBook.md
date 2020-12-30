# datasciencecourseraproject

### DOWNLOADING AND OPENING THE DATA

```ruby
library(data.table) 
fileurl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if (!file.exists('./UCI HAR Dataset.zip')){
  download.file(fileurl,'./UCI HAR Dataset.zip', mode = 'wb')
  unzip("UCI HAR Dataset.zip", exdir = getwd())
}
```

#### Opening the files

```ruby
features <- read.csv('./UCI HAR Dataset/features.txt', header = FALSE, sep = ' ') ### open and store the table "feature.txt" in a variable called "feature" without taking the header and the spaces as a parameter to read the table
features <- as.character(features[,2]) ### the column two from the features tables is converte to a character and it is stored in a variable called "feature"


x_train <- read.table('./UCI HAR Dataset/train/X_train.txt') ### open and store the table "X_train.txt" in a variable called "x_train" without taking the header and the spaces as a parameter to read the table
y_train <- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ') ### open and store the table "y_train.txt" in a variable called "y_train" without taking the header and the spaces as a parameter to read the table
subject_train <- read.csv('./UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ') ### open and store the table "subject_train.txt" in a variable called "subject_train" without taking the header and the spaces as a parameter to read the table

merge_train <-  data.frame(subject_train, y_train, x_train) ### create a data frame with the x_train, y_train and subject_train tables. This is stored in a variable called merge_traing
names(merge_train) <- c(c('subject', 'activity'), features) ### asigning the name of the colums of the merge_train data frame. For the first two and the other with the previous leaded table "features"


#### We are applying the same procedure to the test table. It was loaded the X_test.txt, y_test.txt and subject_test.txt and stored in the variables shown below.
#### It was ommited the headers but the spaces were evaluated to read the tables involved.
x_test <- read.table('./UCI HAR Dataset/test/X_test.txt')
y_test <- read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
subject_test <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')

#### It these two lines of code we create the merge_test data frame including the three loaded files and assing the names of the columns.
merge_test <-  data.frame(subject_test, y_test, x_test)
names(merge.test) <- c(c('subject', 'activity'), features)
```

### 1. MERGES BOTH TABLES INTO 1 CALLED (data.all)

```ruby
data.all <- rbind(merge_train, merge_test) """MErging the merge_train and merge_test data frames into a new one called "data.all"
```

### 2. Extracts only the measurements on the mean and standard deviation for each measurement
```ruby
mean_std_filter <- grep('mean|std', features) ###looking for the word "mean" or "std" in the features one and assigning it to a variable called mean_std_filter.
new_data.all <- data.all[,c(1,2,mean_std_filter + 2)] ### create a new table called "new_data.all" with the columns filtered in the previous code line.
```

### 3. Uses descriptive activity names to name the activities in the data set
```ruby
activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE) ### open and store the table "activity_labels.txt" in a variable called "activity_labels" without taking the header and the spaces as a parameter to read the table
activity_labels <- as.character(activity.labels[,2]) """ selecting the second column of the table and converting it into a character one. It is stored in a variable called activity_labels
new_data.all$activity <- activity_labels[new_data.all$activity]  ###asigning to the column "activity of the new_data.all the description of the activities.
```

### 4.Appropriately labels the data set with descriptive variable names.
```ruby
name.new <- names(new_data.all) ### assigning to the variable name.new the names of the columns of the table "new_data.all".
name.new <- gsub("[(][)]", "", name.new)  ### replacing every parenthesis for nothing
name.new <- gsub("^t", "TimeDomain_", name.new) ### replacing every word that starts by "t" for "TimeDomain_"
name.new <- gsub("^f", "FrequencyDomain_", name.new) ### replacing every word that starts by "f" for "FrequencyDomain_"
name.new <- gsub("Acc", "Accelerometer", name.new) ### replacing every "Acc" for "Accelerometer"
name.new <- gsub("Gyro", "Gyroscope", name.new) ### replacing every "Gyro" for "Gyoscope"
name.new <- gsub("Mag", "Magnitude", name.new) ### replacing every "Mag" for "Magnitude"
name.new <- gsub("-mean-", "_Mean_", name.new)### replacing every "-mean-" for "_Mean_"
name.new <- gsub("-std-", "_StandardDeviation_", name.new)### replacing every "-std-" for "_StandardDeviation_"
name.new <- gsub("-", "_", name.new) ### replacing every "-" for "_"
names(new_data.all) <- name.new ### assigning these changes to the column names of the data frame "new_data.all
```

### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
```ruby
new_tidy_table <- aggregate(new_data.all[,3:81], by = list(activity = new.data.all$activity, subject = new_data.all$subject),FUN = mean)
```

#### group the information based on two criterias (activity and Subject). Getting the mean for each group. At the end this data frame was assigned to a variable called "new_tidy_table"

