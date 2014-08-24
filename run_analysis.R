run_analysis <- function() {
 
        library(reshape2)

        testsubject <- read.table("C:/Users/Maria Jannelli/Desktop/RProgramming/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
        testx <- read.table("C:/Users/Maria Jannelli/Desktop/RProgramming/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
        testy <- read.table("C:/Users/Maria Jannelli/Desktop/RProgramming/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
        
        trainsubject <- read.table("C:/Users/Maria Jannelli/Desktop/RProgramming/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
        trainx <- read.table("C:/Users/Maria Jannelli/Desktop/RProgramming/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
        trainy <- read.table("C:/Users/Maria Jannelli/Desktop/RProgramming/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
        
        features <- read.table("C:/Users/Maria Jannelli/Desktop/RProgramming/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")
        activitylabels <- read.table("C:/Users/Maria Jannelli/Desktop/RProgramming/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
     
        subject <- rbind(testsubject, trainsubject)
        colnames(subject) <- "subject"
    
        label <- rbind(testy, trainy)
        label <- merge(label, activitylabels, by=1)[,2]
        
        data <- rbind(testx, trainx)
        colnames(data) <- features[, 2]
        
        data <- cbind(subject, label, data)
        
        search <- grep("-mean|-std", colnames(data))
        data.mean.std <- data[,c(1,2,search)]
             
        melted = melt(data.mean.std, id.var = c("subject", "label"))
        means = dcast(melted , subject + label ~ variable, mean)
        
        write.table(means, file="C:/Users/Maria Jannelli/Desktop/RProgramming/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/tidy_data.txt")
        
        return(means)
  
}

