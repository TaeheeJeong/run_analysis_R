# Assignment: Getting and Cleaning Data Course Project
# author: Taehee Jeong
# date: 05/13/2016

# read train data 
train  <- read.table("./train/X_train.txt",header = FALSE)
train_label  <- read.table("./train/y_train.txt",header = FALSE)

# read test data 
test  <- read.table("./test/X_test.txt",header = FALSE)
test_label  <- read.table("./test/y_test.txt",header = FALSE)

# merge the trainingand the test data
all_data<-rbind(train, test)

# extract mean for each measurement
mean_data=sapply(all_data,mean)

# extract standard deviation for each measurement
sd_data=sapply(all_data, sd)

# read feature for train and test data
feature <- read.table("features.txt",header = FALSE)

# Use 561-feature vectors to variable names
names(all_data)<-feature$v2

## add activity column
# make activity dictionary type
activity<-c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
names(activity)<-c(1,2,3,4,5,6)
# sapply using activity as function
desc_act<-function(x){activity[x]}
all_activity=sapply(all_label,desc_act)
# add activity column to all_data 
all_activity2<-data.frame(all_activity)
all_activity2<-rename(all_activity2,activity=V1)
all_data2<-cbind(all_data,all_activity2)

# create second, independent tidy data st with the average of each variable for each actvity
new_data<-aggregate(all_data2[, 1:561], list(all_data2$activity), mean)
new_data<-rename(new_data,activity=Group.1)

