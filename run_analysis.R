# Cleaning and Getting Data - Project 
# Data was already downloaded and unziped into working directory for R Console
# 1 - Merges the training and the test sets to create one data set.
features = read.table('./features.txt',header=FALSE); 
act_Type = read.table('./activity_labels.txt',header=FALSE); 
subjectTrain = read.table('./train/subject_train.txt',header=FALSE); 
x_Train = read.table('./train/x_train.txt',header=FALSE); 
y_Train = read.table('./train/y_train.txt',header=FALSE); 
colnames(activityType)  = c('activityId','act_Type');
colnames(subjectTrain)  = "subjectId";
colnames(x_Train) = features[,2]; 
colnames(y_Train) = "activityId";
TRData = cbind(y_Train,subjectTrain,x_Train);

# Reading data and creating one data set..
subjectTest = read.table('./test/subject_test.txt',header=FALSE); 
xTest = read.table('./test/x_test.txt',header=FALSE); 
yTest = read.table('./test/y_test.txt',header=FALSE);
colnames(subjectTest) = "subjectId";
colnames(xTest) = features[,2]; 
colnames(yTest) = "activityId";
testData = cbind(yTest,subjectTest,xTest);
## f_Data is the Merged Data set
f_Data = rbind(trainingData,testData);
colNames  = colnames(f_Data); 

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
Measures = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));
f_Data = f_Data[Measures==TRUE];

# 3. Uses descriptive activity names to name the activities in the data set

f_Data = merge(f_Data,activityType,by='activityId',all.x=TRUE);
colNames  = colnames(f_Data); 

# 4. Appropriately label the data set with descriptive activity names. 
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

colnames(f_Data) = colNames;

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
finalDataNo  = f_Data[,names(f_Data) != 'activityType'];
tidyData = aggregate(finalDataNo[,names(finalData) != c('activityId','subjectId')],by=list(activityId=finalDataNo$activityId,subjectId = finalDataNo$subjectId),mean);
tidyData = merge(tidyData,activityType,by='activityId',all.x=TRUE);
write.table(tidyData, './tidyData.txt',row.names=TRUE,sep='\t');
