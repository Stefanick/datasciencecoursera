CodeBook for Getting and Cleaning Data Project 
========================================================

Data was already downloaded and unziped into working directory for R Console
# 1 - Merges the training and the test sets to create one data set.
Features.txt where read into "features" via read.table as was activity type, subjectTrain Data and Activity ID.  
Columnames where created and columns where bound with cBind into a Data set called TRDATA
the final data set "f_Data" was then created with the rBind function

Variables used are Features.txt assigned to "features"
activity_labels.txt to act_Type
subject_train.txt to subjectTrain
x_train.txt to x_Train
y_train.txt to y_train
activityID is used for activityType

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
Measures where created with the grepl function and assigned to the "f_Data" set

# 3. Uses descriptive activity names to name the activities in the data set
Merge function was used to merge f_Data,activityType,by activityId

# 4. Appropriately label the data set with descriptive activity names. 
Column names where assigned with the "gsub" function 

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

A tidyData.txt data set was created using the aggregate and merge functions.  Final data set is stored back in the working directory as "tidyData.txt"
