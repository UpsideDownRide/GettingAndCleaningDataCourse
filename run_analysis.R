## Getting and cleaning the data course project by Radomir Nowacki

library(dplyr)

## 1) Download the data

tmpf<-tempfile()
tmpu<-'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(tmpu,tmpf)
unzip(tmpf)
filelist<-unzip(tmpf,list=TRUE)[,1]

## 2) Read in the data

## Grep the filenames of files of interest

x_train_file<-grep('/X_train',filelist,value=TRUE)
y_train_file<-grep('/y_train',filelist,value=TRUE)
x_test_file<-grep('/X_test',filelist,value=TRUE)
y_test_file<-grep('/y_test',filelist,value=TRUE)
features_labels_file<-grep('features.txt',filelist,value=TRUE)
activity_labels_file<-grep('activity_labels.txt',filelist,value=TRUE)
subject_test_file<-grep('subject_test',filelist,value=TRUE)
subject_train_file<-grep('subject_train',filelist,value=TRUE)

## Read the files

x_train<-read.table(x_train_file)
x_test<-read.table(x_test_file)
y_train<-read.table(y_train_file)
y_test<-read.table(y_test_file)
features_labels<-read.table(features_labels_file)
activity_labels<-read.table(activity_labels_file)
subject_train<-read.table(subject_train_file)
subject_test<-read.table(subject_test_file)


## 3) Data tidying

## combine test and train data + name columns

x_combined<-rbind(x_train,x_test)
colnames(x_combined)<-make.names(names=features_labels$V2, 
                                 unique=TRUE, allow_ = TRUE)
meanstd_columns<-grep('-mean\\(\\)|-std\\(\\)',features_labels$V2)
x_selected<-select(x_combined,meanstd_columns)

y_combined<-rbind(y_train,y_test)
y_combined$V1<-factor(y_combined$V1,levels = activity_labels$V1,
                      labels = activity_labels$V2)

colnames(y_combined)<-'activity'

subject_combined<-rbind(subject_train,subject_test)
colnames(subject_combined)<-'subject'

## combine the columns

dataset<-cbind(subject_combined,y_combined,x_selected)

## Final touchup of column names

colnames(dataset)<-gsub('\\.(.)(.*)\\.\\.','\\U\\1\\L\\2',
                        colnames(dataset),perl=TRUE)

colnames(dataset)<-gsub('^(t)','time',colnames(dataset),perl=TRUE)
colnames(dataset)<-gsub('^(f)','frequency',colnames(dataset),perl=TRUE)

## 4) Create average dataset 

average_data<-aggregate(.~subject+activity,mean,data=dataset)

## 5) Write processed average dataset

write.csv(average_data,file='tidy_average_data.txt',row.names = FALSE)




