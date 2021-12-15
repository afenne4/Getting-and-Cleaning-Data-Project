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
Combdata<-rbind(Train,Test)

#### Part 2 extract mean and SD for each measurement ####
feature<-read.table("UCI HAR Dataset/features.txt")
match<-feature[grepl("mean",feature[,2]) | grepl("std",feature[,2]),1]
## Need to add 2 to the match vector since 2 columns were added to the dataset
Trim_data<-Combdata[,c(1,2,(match+2))]

#### Part 3 Use descriptive activity names to name the activites in the data set
act<-read.table("UCI HAR Dataset/activity_labels.txt")
Trim_data[,2]<-act[Trim_data[,2],2]
Trim_data[,2]<-gsub("_","",Trim_data[,2])

#### Part 4 label data set with descriptive variable names ####
varname<-feature[match,2]
remove<-c("\\(","\\)","-")
for (i in remove){
    varname<-gsub(i,"",as.character(varname))
}
varname<-gsub("^t","time",varname)
varname<-gsub("^f","freq",varname)
varname<-c("subjnum","activity",varname)
colnames(Trim_data)<-varname

#### Part 5 calculating average of data ####
library(dplyr)
Avg_data<-Trim_data %>%
    group_by(subjnum,activity) %>%
    summarise_all(mean) %>%
    arrange(subjnum,activity)

write.table(Avg_data,"Tidy_Data.txt",row.names=FALSE)
