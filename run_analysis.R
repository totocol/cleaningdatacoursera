#head(read.table('test/body_acc_x_test.txt'))

#First we need to read the tables we want to use which 
#include the training and test sets with their respective labels

testData <- read.table('test/X_test.txt') #read test data
testLabels <- read.table('test/y_test.txt') #read test labels
trainingData <- read.table('train/X_train.txt') #read training data
trainingLabels <-read.table('train/y_train.txt') #read training labels
testSubjects <- read.table('test/subject_test.txt')
trainingSubjects <- read.table('train/subject_train.txt')


#let's bind the test and training data 

allData <- rbind(testData,trainingData)

#and let's do the same with the labels 

allLabels <- rbind(testLabels,trainingLabels)

#and finally with the subjects 

allSubjects <- rbind(testSubjects,trainingSubjects)

#And now we can add the names to the columns


variablesNames <- read.table('features.txt') #read data
newVariables <- subset(variablesNames, select="V2") #get only the column we are interested in
newVector <- as.vector(newVariables$V2) #transform the data.frame in to a vector we can use for the names
colnames(allData) <- newVector #let's now add the names to the columns


#We now want to extract only the columns with stdDev 

stdColumns <- allData[,grepl("std",names(allData),ignore.case = FALSE)]
meanColumns <- allData[,grepl(".mean...",names(allData))]

columnsNeeded <- data.frame(meanColumns, stdColumns)

#And now add the labels and the subjects 

datawithSubjects <- data.frame(allSubjects, columnsNeeded)
datawithLabels <- data.frame(allLabels,datawithSubjects)

#Now we need to give the activities meaninful values

datawithLabels$V1[datawithLabels$V1=="1"] <- "walking" 
datawithLabels$V1[datawithLabels$V1=="2"] <- "walking.upstairs" 
datawithLabels$V1[datawithLabels$V1=="3"] <- "walking.downstairs" 
datawithLabels$V1[datawithLabels$V1=="4"] <- "sitting" 
datawithLabels$V1[datawithLabels$V1=="5"] <- "standing" 
datawithLabels$V1[datawithLabels$V1=="6"] <- "laying" 

#Now we need to rename the variables 

names(datawithLabels) <- tolower(names(datawithLabels)) #First let's change all names to lowercase
colnames(datawithLabels)[1] <- "activities" #rename first column
colnames(datawithLabels)[2] <- "subjects" #rename second column

#Let's remove all situations where there are too many dots

colnames(datawithLabels) <- gsub("mean...", "mean.",colnames(datawithLabels)) 
colnames(datawithLabels) <- gsub("mean.q...", "mean.q.",colnames(datawithLabels))
colnames(datawithLabels) <- gsub("std...", "std.",colnames(datawithLabels))

#let's now take only the gravity and body acceleration across the 3 axis

selectedData <- subset(datawithLabels, select = c(1:8))

#Now we need to calculate the averages 

#let's sort the table by subject and then by activity

orderSelected <- selectedData[order(selectedData[,2], selectedData$activities, na.last=NA),]

#Initialise data frame

dataAverages <- data.frame("tbodyacc.mean.x"=as.numeric(), "tbodyacc.mean.y"=as.numeric(), 
                           "tbodyacc.mean.x"=as.numeric(),"tgravityacc.mean.x"=as.numeric(),
                           "tgravityacc.mean.y"=as.numeric(),"tgravityacc.mean.z"=as.numeric())

#And now lets calculate the average for each subject on each activity

#For laying
for (i in seq_along(1:30)) {
  layingSubset <- subset(orderSelected, orderSelected$activities=="laying")
  layingColumns <- subset(layingSubset, subjects == i, select = tbodyacc.mean.x:tgravityacc.mean.z)  
  dataAverages <- rbind(dataAverages, colMeans(layingColumns[,1:6]))
}

#For sitting

for (i in seq_along(1:30)) {
  sittingSubset <- subset(orderSelected, orderSelected$activities=="sitting")
  sittingColumns <- subset(layingSubset, subjects == i, select = tbodyacc.mean.x:tgravityacc.mean.z)  
  dataAverages <- rbind(dataAverages, colMeans(sittingColumns[,1:6]))
}


#For standing 

for (i in seq_along(1:30)) {
  standingSubset <- subset(orderSelected, orderSelected$activities=="standing")
  standingColumns <- subset(layingSubset, subjects == i, select = tbodyacc.mean.x:tgravityacc.mean.z)  
  dataAverages <- rbind(dataAverages, colMeans(standingColumns[,1:6]))
}

#For walking 
for (i in seq_along(1:30)) {
  walkingSubset <- subset(orderSelected, orderSelected$activities=="walking")
  walkingColumns <- subset(layingSubset, subjects == i, select = tbodyacc.mean.x:tgravityacc.mean.z)  
  dataAverages <- rbind(dataAverages, colMeans(walkingColumns[,1:6]))
}

colnames(dataAverages) <- c("tbodyacc.mean.x", "tbodyacc.mean.y", 
                            "tbodyacc.mean.x","tgravityacc.mean.x",
                            "tgravityacc.mean.y","tgravityacc.mean.z")

#For walking downstairs
for (i in seq_along(1:30)) {
  walking.downstairsSubset <- subset(orderSelected, orderSelected$activities=="walking.downstairs")
  walking.downstairsColumns <- subset(layingSubset, subjects == i, select = tbodyacc.mean.x:tgravityacc.mean.z)  
  dataAverages <- rbind(dataAverages, colMeans(walking.downstairsColumns[,1:6]))
}

#For walking upstaris
for (i in seq_along(1:30)) {
  walking.upstairsSubset <- subset(orderSelected, orderSelected$activities=="walking.upstairs")
  walking.upstairsColumns <- subset(layingSubset, subjects == i, select = tbodyacc.mean.x:tgravityacc.mean.z)  
  dataAverages <- rbind(dataAverages, colMeans(walking.upstairsColumns[,1:6]))
}

#And the final result



#recreate activity names
finalLaying <- as.data.frame(rep("laying", 30))
colnames(finalLaying) = "activities"
finalSitting <- as.data.frame(rep("sitting", 30))
colnames(finalSitting) = "activities"
finalStanding <- as.data.frame(rep("standing", 30))
colnames(finalStanding) = "activities"
finalWalking <- as.data.frame(rep("walking", 30))
colnames(finalWalking) = "activities"
finalDonwstairs <- as.data.frame(rep("walking.donwstairs", 30))
colnames(finalDonwstairs) = "activities"
finalUpstairs <- as.data.frame(rep("walking.upstairs", 30))
colnames(finalUpstairs) = "activities"

finalActivities <- rbind(finalLaying,finalSitting,finalStanding,finalWalking,finalDonwstairs,finalUpstairs)

#Create the colmn for subject nmbers 
finalSubjects <- as.data.frame(paste("subject", 1:30, sep = "."))
subjectAll <- rbind(finalSubjects, finalSubjects, finalSubjects, finalSubjects, finalSubjects, finalSubjects)
colnames(subjectAll) <- "subject.number"

#Get the final dataset together
finalDataset <- data.frame(finalActivities, subjectAll, dataAverages)

#Export the data in a txt file

write.table(finalDataset, file="cleanaveragescoursera.txt", sep = " ", row.names=FALSE)