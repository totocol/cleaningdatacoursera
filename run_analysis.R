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


head(datawithLabels)
