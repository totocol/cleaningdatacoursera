##Code Book

This is the Code Book for the final project of the Getting and Cleaning Data MOOC at Coursera

###What does the initial data contain? 

The initial data contains information from experiments carried out with volunteers performing six different activities 

Measurements were then taken using the accelerometer and gyroscope of a Samsung Galaxy S II phone. 


###How was the initial data transformed?

* Data was separated in different files so files needed to be read and combined 
* Column names needed to be cleaned after the tables were read. This included removing excessive dots and transforming the variables names to lower case

###Variables selected

The variables selected were

* tbodyacc across 3 axis = Body acceleration signal 
* tgravityacc across 3 axis = Gravity acceleration signal

This variables that contain 6 measurements were considered as the most important ones to take into account because they can be used to calculate the other variables presented


###Final file

The final tidy data contains the following 8 columns:

* activities = it shows which of the 6 activities was being carried out (laying, sitting, standing, walking, walking.downstairs, walking.upstairs)  
* subject.number = Shows which subject the measurement refers to from 1 to 30 
* tbodyacc.mean.x = Mean of the body acceleration signal across the x axis for each subject across all 6 activities
* tbodyacc.mean.y = Mean of the body acceleration signal across the y axis for each subject across all 6 activities
* tbodyacc.mean.z =  Mean of the body acceleration signal across the z axis for each subject across all 6 activities
* tgravityacc.mean.x = Mean of the gravity acceleration signal across the x axis for each subject across all 6 activities
* tgravityacc.mean.y = Mean of the gravity acceleration signal across the y axis for each subject across all 6 activities
* tgravityacc.mean.z = Mean of the gravity acceleration signal across the z axis for each subject across all 6 activities

