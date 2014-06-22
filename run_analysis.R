
getMeanVector<-function(data, colname, labels) {
  meanVector<-data.frame()
  init = FALSE
  for(label in labels) {
    data_activity<-data[data[colname] == label,]
    data_mean<-sapply(data_activity[,1:79], mean)
    if(init == FALSE) {
       meanVector<-data_mean
       init = TRUE
    } else {
      meanVector<-rbind(meanVector, data_mean)
    }
  }
  meanVector
}

removeUselessColumn<-function(data) {
  tidy<-data.frame(a=data[,1])
  colnames(tidy)[1]<-as.character(features[1,2])
  for(i in 2:561) {
    if(columnFilter[i] == TRUE) {
      #print(i)
      tidy<-cbind(tidy, data[,i])
      #colnames(tidy)["new"]<-as.character(features[i,2])
    }
  }
  tidy
}

createfeaturevector<-function(features) {
  result<-c()
  fe<-sapply(features, as.character)
  for(i in 1:561) {
    if(columnFilter[i] == TRUE) {
      result<-c(result, fe[i])
    }
  }
  result
}

activitiesConvert<-function(y,activityLabels) {
  activityLabels[y]
}

options(digits =8)
X_test<-read.table(".\\test\\X_test.txt",sep="")
X_train<-read.table(".\\train\\X_train.txt",sep="")
X<-rbind(X_test, X_train)
remove(X_test,X_train)

y_test<-read.table(".\\test\\y_test.txt",sep="")
y_train<-read.table(".\\train\\y_train.txt",sep="")
Y<-rbind(y_test, y_train)
remove(y_test,y_train)

subject_test<-read.table(".\\test\\subject_test.txt",sep="")
subject_train<-read.table(".\\train\\subject_train.txt",sep="")
subject<-rbind(subject_test, subject_train)
remove(subject_test,subject_train)

activityLabels<-read.table(".\\activity_labels.txt",sep="")
activityLabels<-activityLabels[,2]
activityLabels<-sapply(activityLabels, as.character)

#Uses descriptive activity names to name the activities in the data set
yactivity<-sapply(Y[,1], activitiesConvert, activityLabels)

features<-read.table("features.txt",sep="")
columnFilter<-grepl("mean|std", features[,2])
myfeature<-grep("mean|std", features[,2])

#remove column
tidy<-removeUselessColumn(X)
tidyMean<-X

remove(X)
remove(Y)

colnames<-createfeaturevector(features[,2])

colnames(tidy)<-colnames

tidy$activity_name<-yactivity
tidy$subject<-subject[,1]

write.csv(tidy, file="tidy.csv", quote=FALSE,  row.names=FALSE, fileEncoding="UTF-8")

#mean of activities
meanVector_activities<-getMeanVector(tidy, "activity_name", activityLabels)
#mean of subjects
meanVector_subjects<-getMeanVector(tidy, "subject", c(1:30))
#independent tidy data set with the average of 
#each variable for each activity and each subject
mean<-rbind(meanVector_activities, meanVector_subjects)
clabels<-sapply(c(1:30), flabel<-function(x) { paste("subject_",as.character(x)) })
meanRowlabels<-c(activityLabels, clabels)
rownames(mean)<-meanRowlabels

write.csv(mean, file="tidyMean.csv", quote=FALSE,  row.names=TRUE, fileEncoding="UTF-8")

