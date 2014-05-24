## Load File into Working Directory
if (!file.exists("UCI HAR Dataset")) {
  if (!file.exists("Proj_Data.zip")) {
    stop("was expecting HAR Dataset folder or zip file")
  } else {
    unzip("Proj_Data.zip")
  }
}
## Load relevant txt files into R
features <- read.table("./UCI HAR Dataset/features.txt")  
actlabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
subjtest <- read.table("./UCI HAR Dataset/test/subject_test.txt") 
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt") 
Y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt") 
subjtrain <- read.table("./UCI HAR Dataset/train/subject_train.txt") 
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt") 
Y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt") 
## Rename some of the variables to something more intuitive 
names(subjtest) <- "Subject"
names(subjtrain) <- "Subject"
names(Y_test) <- "Activity"
names(Y_train) <- "Activity"
##1) Merge the data into one awesome and big dataset
training = cbind(subjtest, Y_test, X_test )
test = cbind(subjtrain,Y_train, X_train )
bigset = rbind(training, test) ## This is the one big data set
## 2) Extract only measurements of means and standard deviations 
aves <- grep("mean", features$V2) ## Identifies measurements of means 
standard_dev <- grep("std", features$V2) ## Identifies measurements of standard deviataions
newbig <- bigset[,c(aves, standard_dev)] ## subset that big data set on just the variables that are measurements of means and standard deviataions
##3-4) Use descriptive activity names - This generates a new variable that uses the activity labels
attach(newbig)
newbig$Activity_Name[Activity == 1] <- "Walking"
newbig$Activity_Name[Activity == 2] <- "Walking Upstairs"
newbig$Activity_Name[Activity == 3] <- "Walking Downstairs"
newbig$Activity_Name[Activity == 4] <- "Sitting"
newbig$Activity_Name[Activity == 5] <- "Standing"
newbig$Activity_Name[Activity == 6] <- "Laying"
detach(newbig)
##5) Creates a tidy data set
# rehape the data to get a row for each mean/std measure for each subject/activity
reshaped <- melt(newbig, id = c("Subject", "Activity", "Activity_Name"))
# get the averages for each subject of each variable for each activity
tidy <- dcast(reshaped, Subject + Activity + Activity_Name ~variable, fun.aggregate = mean)
#save the table
write.table(tidy, file = "tidy.txt", sep = "\t")
## END
