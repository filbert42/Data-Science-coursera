setwd("D:/Учеба/R/workingDirectory/")
library(dplyr)
# read features labels and create vector with only needed features
features <- read.table("UCI HAR Dataset/features.txt", header = F, stringsAsFactors = F)[,2]
selected_features <- c(features[grep(x=features,"mean()", fixed = T)], features[grep(x=features,"std()", fixed = T)])
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt",header=F)[,2]

## read and subset training data
trdata <- read.table("UCI HAR Dataset/train/X_train.txt", header = F)
names(trdata) <- features
trdata <- trdata[, selected_features]

## add subject and activities columns to the training data
trsubj <- as.factor(read.table("UCI HAR Dataset/train/subject_train.txt", header = F)[,1])
tractiv <- as.factor(read.table("UCI HAR Dataset/train/y_train.txt", header = F)[,1])
levels(tractiv) <- activity_labels
trdata <- cbind(trdata, "subject" = trsubj, "activities" = tractiv)

## read and subset test data
tstdata <- read.table("UCI HAR Dataset/test/X_test.txt", header = F)
names(tstdata) <- features
tstdata <- tstdata[, selected_features]

## add subject and activities columns to the test data
tstsubj <- as.factor(read.table("UCI HAR Dataset/test/subject_test.txt", header = F)[,1])
tstactiv <- as.factor(read.table("UCI HAR Dataset/test/y_test.txt", header = F)[,1])
levels(tstactiv) <- activity_labels
tstdata <- cbind(tstdata, "subject" = tstsubj, "activities" = tstactiv)

## combine trdata with tstdata
data <- rbind(trdata, tstdata)

## From the data set in step 4, creates a second, independent tidy data set
## with the average of each variable for each activity and each subject.

final_data <- group_by(data, subject, activities) %>% summarise_each(funs(mean))

write.table(final_data,"tidy_data.txt", row.names=FALSE)