fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("watchdata.zip")){
    download.file(fileurl,"watchdata.zip",method="curl")
    unzip("watchdata.zip")}
X_test<-read.table("UCI HAR Dataset/test/X_test.txt")
Y_test<-read.table("UCI HAR Dataset/test/y_test.txt")
S_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
X_train<-read.table("UCI HAR Dataset/train/X_train.txt")
Y_train<-read.table("UCI HAR Dataset/train/y_train.txt")
S_train<-read.table("UCI HAR Dataset/train/subject_train.txt")

#### Part 1 Merge the training and test sets ####
Train<-cbind(S_train,Y_train,X_train)
Test<-cbind(S_test,Y_test,X_test)



#### Part 2 extract mean and SD for each measurement ####
feature<-read.table("UCI HAR Dataset/features.txt")

match<-feature[grepl("mean",feature[,2]) | grepl("std",feature[,2]),1]
Trim_train<-Train[,c(1,2,(match+2))]
Trim_test<-Test[,c(1,2,(match+2))]
