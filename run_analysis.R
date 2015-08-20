run_analysis <- function() {
  # Using plyr for mapvalues()
  library(plyr)

  # Question 1. Read train and test data, then rbind the 2
  train_df<-read.csv("train/X_train.txt", sep="", header=FALSE, stringsAsFactors=FALSE)
  test_df<-read.csv("test/X_test.txt", sep="", header=FALSE, stringsAsFactors=FALSE)
  merged_df <- rbind(train_df, test_df)
  
  ## Question 2. Mean and Std deviation fields end by "-mean()" and "-std()" in features.txt
  features_df <- read.csv("features.txt", sep="", header=FALSE, stringsAsFactors=FALSE)
  colnames(features_df) <- c("index","name")
  ## mean_std_indexes is a numeric vector containing the indexes of the mean and std features 
  mean_std_indexes <- c(grep("-mean\\(\\)", features_df$name),grep("-std\\(\\)", features_df$name))
  ## mean_std_df is the data frame containing only mean and std features
  mean_std_df <- merged_df[,mean_std_indexes]
  
  ## Question 3. activities_df says to which activity an observation corresponds
  activities_df <-rbind(read.csv("train/y_train.txt", sep="", stringsAsFactors=FALSE,header=FALSE), 
                        read.csv("test/y_test.txt", sep="", stringsAsFactors=FALSE, header=FALSE))
  labeled_activities_df <- mapvalues(activities_df[,1], c(1,2,3,4,5,6), c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS",
                                                                          "SITTING","STANDING","LAYING"))
  mean_std_activity_df <- cbind(mean_std_df, labeled_activities_df)
  
  ## Question 4. Labels for the columns can be found in features_df computed above  
  colnames(mean_std_activity_df) <- c(features_df[mean_std_indexes,]$name, "Activity")
  
  ## Question 5. subjects_df says to which subject an observation corresponds
  average_df = data.frame("Subject"=integer(0), "Activity"=character(0), "Variable"=character(0), "Average"=numeric(0), stringsAsFactors=FALSE)
  subjects_df <-rbind(read.csv("train/subject_train.txt", sep="", stringsAsFactors=FALSE, header=FALSE), 
                      read.csv("test/subject_test.txt", sep="", stringsAsFactors=FALSE, header=FALSE))
  colnames(subjects_df) <- "Subject"
  activity_subject_df <- cbind(mean_std_activity_df, subjects_df)
  ## For each subject s, activity a, variable v, calculate the mean
  for (s in 1:30) {
    filtered1_df <- subset(activity_subject_df ,  Subject == s)
    for(a in c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")) {
      filtered2_df <- filtered1_df[filtered1_df$Activity==a,]
      for (v in 1:(ncol(filtered2_df)-2)) {
        average <- mean(filtered2_df[,v],na.rm=TRUE)
        average_df[nrow(average_df)+1,] <- c(as.integer(s), as.character(a), as.character(colnames(x=filtered2_df)[v]), as.numeric(average))
      }
    }
  }
  colnames(average_df) = c("Subject", "Activity", "Variable", "Average")
  write.table(x=average_df, file="tidy_dataset.txt", row.name=FALSE)
  average_df
}