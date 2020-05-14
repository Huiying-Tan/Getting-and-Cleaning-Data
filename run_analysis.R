#Download file
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile = "run_analysis_data.zip")
library(dplyr)
library(readtext)
?`readtext-package`
#DATA_DIR <- system.file(getwd(), package = "readtext")
unzip("run_analysis_data.zip")
# Read in all files from a folder
#textfiles<-readtext(paste0(DATA_DIR, "UCI HAR Dataset"))
#textfiles[5,1]
#main folder
activity_labels<-read.table( "UCI HAR Dataset/activity_labels.txt")
features<-read.table("UCI HAR Dataset/features.txt")


train_data<-read.table("UCI HAR Dataset/train/X_train.txt")
test_data<-read.table("UCI HAR Dataset/test/X_test.txt")
#1. combined data
combined_data<-rbind(train_data,test_data)

#2. extract only mean and sd of each measurement
variable_names<-read.table("UCI HAR Dataset/features.txt")
head(variable_names)

#specify col name
colnames(combined_data)=variable_names$V2

#selecting col with mean and std
combined_data<-combined_data[ , grepl( "mean|std" , names( combined_data ) ) ]

#training label
train_label<-read.table("UCI HAR Dataset/train/y_train.txt")

#test label
test_label<-read.table("UCI HAR Dataset/test/y_test.txt")

#combine training and test label

combined_label<-rbind(train_label,test_label)
#label activity label col
colnames(activity_labels)=c("activity_ID","activity")
#label combined_label col
colnames(combined_label)=c("activity_ID")
#train and test subject
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")


#combine train and test subject
subject<-rbind(subject_train, subject_test)

#bind combined_label with combined_data
data_label_subject<-cbind(combined_data,combined_label,subject)

#merge activity labels with combined label
data_label_subject<- data_label_subject %>%
            left_join(activity_labels, by = "activity_ID")




combined_mean<-data_label_subject%>%
 group_by(subject_ID,activity) %>%
summarise_all(funs(mean))


