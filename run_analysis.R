##this script will take the data and then

mainFunction <- function(){
    ##  1.a: Read the training files
    trainData <- mergeTrainData()
    
    ##  1.b: Read the Test files and join them
    testData <- mergeTestData()
    
    ##  1.c: Now merge the two data sets together
    allData <- rbind(trainData, testData)
    
    ## 2.a: now get the indices of the columns that are either mean or standard dev
    allColumns <- headers()
    neededColumnsIndices <- meanColumns(allColumns)
    meanData <- allData[, neededColumnsIndices]
    
    ##  2.b: now apply the current columns names from features
    neededColumns <- allColumns[ neededColumnsIndices,]
    names(meanData)  <- neededColumns[, 2]
    
    ##  3.a: Merge the activity names
    activityNames <- read.table("activity_labels.txt")
    names(activityNames) <- c("index", "ActivityDesc")
    
    ## 3.b: Now merge the data
    activityData <- merge(meanData, activityNames, by.y  = "index", by.x= "activity")
}

headers <- function() {
  h1 <- read.table("features.txt", header= FALSE)
  h2 <- data.frame( -1 ,"volunteer")
  names(h2) <- c("V1", "V2")
  h3 <- data.frame( 0 ,"activity")
  names(h3) <- c("V1", "V2")
  head1 <- rbind(h2,h3, h1)
}

mergeTestData <- function() {
  volunteers_test <- read.table("test/subject_test.txt", header= FALSE)
  activity_test <- read.table("test/y_test.txt", header = FALSE)
  measurements_test <- read.table("test/X_test.txt", header = FALSE)
  
  testData = cbind(volunteers_test, activity_test, measurements_test)
}

mergeTrainData <- function() {
  volunteers_train <- read.table("train/subject_train.txt", header= FALSE)
  activity_train <- read.table("train/y_train.txt", header = FALSE)
  measurements_train <- read.table("train/X_train.txt", header = FALSE)
  
  trainData = cbind(volunteers_train, activity_train, measurements_train)
}



meanColumns <- function(features){
    ## this function returns a vector with the indices of all columns that have 
    ## either the mean or standard deviation
  
  grep("mean|std|volunteer|activity", features$V2, ignore.case = TRUE)
}

