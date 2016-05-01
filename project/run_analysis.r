clean_data <- function() {
        url = "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        if(!file.exists("./data")){
                dir.create("./data")
        }
        download.file(url, "./data/dataset.zip", method = "curl")
        unzip("./data/dataset.zip")
        
        train <- merge_data("./UCI HAR Dataset", "train")
        test <- merge_data("./UCI HAR Dataset", "test")
        data <- rbind(train, test)

        features.name = read.table("./UCI HAR Dataset/features.txt")
        head(features.name)
        index_extarted = grep("mean|std", features.name$V2)
        index_del = grep("meanFreq", features.name$V2[index_extarted])
        data_1 = data[c(1,2)]
        index_extarted = 2 + index_extarted
        data_2 = data[index_extarted][-index_del]
        data = cbind(data_1, data_2)
        
        colnames(data) <- get_colnames()
        data$ACTIVITIES <- as.character(data$ACTIVITIES)
        data$ACTIVITIES[data$ACTIVITIES == 1] <- "WALKING"
        data$ACTIVITIES[data$ACTIVITIES == 2] <- "WALKING_UPSTAIRS"
        data$ACTIVITIES[data$ACTIVITIES == 3] <- "WALKING_DOWNSTAIRS"
        data$ACTIVITIES[data$ACTIVITIES == 4] <- "SITTING"
        data$ACTIVITIES[data$ACTIVITIES == 5] <- "STANDING"
        data$ACTIVITIES[data$ACTIVITIES == 6] <- "LAYING"

}

merge_data <- function(directory, dataset) {
        subjects <- read.table(file.path(directory, dataset,
                                         paste("subject_", dataset, ".txt", sep="")))
        activities <- read.table(file.path(directory, dataset,
                                           paste("y_", dataset, ".txt", sep="")))
        features <- read.table(file.path(directory, dataset,
                                         paste("x_", dataset, ".txt", sep="")))
        cbind(subjects, activities, features)
}

write_avg_tidy_dataset <- function(data) {

        result <- matrix(ncol=ncol(data))
        for (subject in c(1:30)){
                for (activity in c("WALKING",
                                   "WALKING_UPSTAIRS",
                                   "WALKING_DOWNSTAIRS",
                                   "SITTING",
                                   "STANDING",
                                   "LAYING")) {
                        ## print(sprintf("Subject: %d, Activity: %s", subject, activity))
                        sub <- subset(data, data$SUBJECTS == subject &
                                              data$ACTIVITIES == activity)
                        v <- c(subject, activity, t(colMeans(sub[3:ncol(data)])))
                        result <- rbind(result, v[1:ncol(data)])
                }
        }
        result <- result[-1,]
        colnames(result) <- get_colnames()

        f <- "avg_tidy_dataset.txt"
        write.table(result, file=f, row.names=FALSE)
}


get_colnames <- function() {
        # Return a vector of names to be used with the data frame and the create
        # tidy data set.
        #
        # Return:
        # a vector with the names
        
        c("SUBJECTS",
          "ACTIVITIES",
          "BodyAccX_Mean",
          "BodyAccY_Mean",
          "BodyAccZ_Mean",
          "BodyAccX_Std",
          "BodyAccY_Std",
          "BodyAccZ_Std",
          "GravityAccX_Mean",
          "GravityAccY_Mean",
          "GravityAccZ_Mean",
          "GravityAccX_Std",
          "GravityAccY_Std",
          "GravityAccZ_Std",
          "BodyAccJerkX_Mean",
          "BodyAccJerkY_Mean",
          "BodyAccJerkZ_Mean",
          "BodyAccJerkX_Std",
          "BodyAccJerkY_Std",
          "BodyAccJerkZ_Std",
          "BodyGyroX_Mean",
          "BodyGyroY_Mean",
          "BodyGyroZ_Mean",
          "BodyGyroX_Std",
          "BodyGyroY_Std",
          "BodyGyroZ_Std",
          "BodyGyroJerkX_Mean",
          "BodyGyroJerkY_Mean",
          "BodyGyroJerkZ_Mean",
          "BodyGyroJerkX_Std",
          "BodyGyroJerkY_Std",
          "BodyGyroJerkZ_Std",
          "BodyAccMag_Mean",
          "BodyAccMag_Std",
          "GravityAccMag_Mean",
          "GravityAccMag_Std",
          "BodyAccJerkMag_Mean",
          "BodyAccJerkMag_Std",
          "BodyGyroMag_Mean",
          "BodyGyroMag_Std",
          "BodyGyroJerkMag_Mean",
          "BodyGyroJerkMag_Std",
          "BodyAccX_Mean",
          "BodyAccY_Mean",
          "BodyAccZ_Mean",
          "BodyAccX_Std",
          "BodyAccY_Std",
          "BodyAccZ_Std",
          "BodyAccJerkX_Mean",
          "BodyAccJerkY_Mean",
          "BodyAccJerkZ_Mean",
          "BodyAccJerkX_Std",
          "BodyAccJerkY_Std",
          "BodyAccJerkZ_Std",
          "BodyGyroX_Mean",
          "BodyGyroY_Mean",
          "BodyGyroZ_Mean",
          "BodyGyroX_Std",
          "BodyGyroY_Std",
          "BodyGyroZ_Std",
          "BodyAccMag_Mean",
          "BodyAccMag_Std",
          "BodyAccJerkMag_Mean",
          "BodyAccJerkMag_Std",
          "BodyGyroMag_Mean",
          "BodyGyroMag_Std",
          "BodyGyroJerkMag_Mean",
          "BodyGyroJerkMag_Std")
}