# gettingandcleaningdata

This is a script that explains how the data obtained was cleaned in several steps.
the main is done in the main function called.
It then calls functions that carry out various steps of the assignment.

 ##  1. Merging the Data
 
	This is done by reading both the training set and the tests sets.
	These are contained in their respective folders.
	the Following commands merged the data.
 
	###  1.b: Read the Test and train files and join them
    trainData <- mergeTrainData()
    testData <- mergeTestData()
    
    ###  1.c: Now merge the two data sets together
    allData <- rbind(trainData, testData)
    
# 	2. Getting the columns with mean and standard deviation.
	This was accomplished by getting columns with containing the words 'mean' or 'std' in them.

	##2.a: now get the indices of the columns that are either mean or standard dev
    allColumns <- headers()
    neededColumnsIndices <- meanColumns(allColumns)
    meanData <- allData[, neededColumnsIndices]
    
    ##  2.b: now apply the current columns names from features
    neededColumns <- allColumns[ neededColumnsIndices,]
    names(meanData)  <- neededColumns[, 2]
    
#  3. We now needed to add descriptive activity labels to the data set.
		This was accomplished by the merge command.
		
		a: Merge the activity names
    activityNames <- read.table("activity_labels.txt")
    names(activityNames) <- c("index", "ActivityDesc")
    
    ## 3.b: Now merge the data
    activityData <- merge(meanData, activityNames, by.y  = "index", by.x= "activity")
    
    ## 4.a
    
# 	5. The last part involved tidying the data. moving it from the wide format to the long format.
		the dplyr package and the tidy package proved pretty useful here.
    ## now tidy the data by using the dplyr package
    ## and the tidyr package as well