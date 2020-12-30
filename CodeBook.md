## Variable definitions
In the final data sets, variable are named as follows:

### Global data set (data)
- activity - indicates the kind of activity (descriptive).
- subjects - subject id enrolled on a specific activity.
- All measurements in original data set
- The data data frame/data table is the result of the following
    - read the tables from .text files (X_train and X_test)
    - labling columns by features.txt file
    - column binding with data from files y_ and subject_
    - coercion of activity based on activity_labels.txt file as vector

### Mean, standard deviation data set

- Columns names were extracted from names(data) whose name contained mean() or sd(), signifying that the presented values were average of each time period.
    - Variables activity and subjects were also kept for later use.
    - Rename the columns using the "gsub" function based on "std" or "mean" words.
- A new data table was created with the above columns

### Subject- and activity-averaged data (avg_data)

- Data was grouped by subjects and activity
- It was calculated the mean of the variables based on the variables mentioned above.
The resulting data table shows 180 observations, which is compatible with 6 values (one for each activity type) for each of the 30 subjects.

### Variables
### new_data.all
- Column 1:66 contain means and standard deviations for all variables measured from sensors.
- activity: factor (6 levels) indicating the type of activity
- subjects: subject ID (a total of 30 were enrolled)
- Every row in the dataset records the mean/SD values of all measurements taken on every subject during each activity period.

###  tidy_data table
Column 1:66 contain means and standard deviations for all variables contained in meansd_data; values have been grouped by subjects and then by activity type
activity: same as meansd_data variable
subjects: same as meansd_data variable
activity is a character vector and subjects integer vector
