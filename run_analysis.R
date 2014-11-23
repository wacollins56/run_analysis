#Set working directory to the location of the test and training data
# Merge the training and test data sets.

x_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")
subject_train <- read.table("subject_train.txt")

x_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")
subject_test <- read.table("subject_test.txt")

#Create a dataset of all the "X' data
x_data <- rbind(x_train, x_test)

#Create a dataset of all the "Y" data
y_data <- rbind(y_train, y_test)

#Creat a dataset of all the "subject" data
subject_data <- rbind(subject_train, subject_test)

#Extract the measurements for mean and standard deviation for each measurement
features <- read.table("features.txt")
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[ ,2])

#subset the data
x_data <- x_data[, mean_and_std_features]
names(x_data) <- features[mean_and_std_features, 2]

#Use the descriptive names and create a single data set
activities <- read.table("activity_labels.txt")
y_data[,1] <- activities[y_data[,1],2]
names(y_data) <- "activity"
names(subject_data) <- "subject"
complete_data <- cbind(x_data, y_data, subject_data)

#Create a tidy data set
averages <- ddply(complete_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(averages, "averages.txt", row.names=FALSE)
