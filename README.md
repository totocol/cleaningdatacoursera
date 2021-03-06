##Getting and Cleaning Data coursera MOOC


###Final Assignment

This repo is intending to look at some transformations I am going to be doing to a dataset in order to demonstrate my abilities to get and clean data for further analysis.

This repo contains the following files

* README.md - this file describing what the other files do
* CodeBook.md - describing the dataset, variables and transformations done to the data
* run_analysis.R - Script that does all the transformations described on CodeBook.md


###Instructions for script to work well

Please remember to keep your data in the same folders structure that the structure provided:

* All test data inside a folder called "test"
* All training data inside a folder clued "train"
* Other data in the root folder (e.g. features.txt)

For easiness of work, all the work has been included in only one script. In this way you will not need to work across more than one script 


###What does the script do? 

These are the steps followed by the script

* First the data needed is read using the read.table() function
* Test data and training data are then joined using the rbind() function
* Labels are then added using colnames() function
* Columns with StdDev and Mean are taken out using grepl()
* Column with the different subjects is also added
* Meaningful names are given to the activities using regular expressions
* Column names with the variables are cleaned up using gsub()
* Variables desired are separated using subset()
* Columns are sorted to facilitate calculating the averages. order() is used for this
* A for loop is used to calculate the averages for each subject across each of the different activities
* Data is exported to a txt file using write.table()

###Files Included

This repo includes the following files

* README.md
* CodeBook.md = It contains the description of the different variables used and explanations behind it selection
* run_analysis.R = It contains the script to transform the initial data into the small tidy dataset with the averages of the variables selected for each subject and for each activity



###License


This is an assignment for on online course. Please use the code here to learn but do not copy it to submit your own assignment as it ail violate the honour code at Coursera. 

Data used comes from [1]

[1] [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
 

