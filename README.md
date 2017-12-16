
# Getting-and-Cleaning-Data-Course-Project
The is the repo for the Peer Graded Assignment for John Hopkins University "Getting and Cleaning Data" Week 4 Course Project in Coursera

In the repo you'll find : 

a) The script run_analysis.R. 
b) The Codebook file for mean.txt ( i.e. output data frame created by run_analysis.R)
c) This Readme.md

To use run_analysis.R, open it in RStudio and source the content. Run the function run_analysis(). This function will output a data frame and write the data frame to mean.txt. 

A summary of what run_analysis.R does is as follows :

STEP ONE, load all testing ( X feature vectors, Y activity,subject ID), training ( X feature vectors, Y activity,subject ID) and feature names

STEP TWO, row bind testing and training data; testing data above and training data below. Do this for all 3 data frames X, Y and subject ID

STEP THREE, Assign proper names to the features of the 3 data frames in step two

STEP FOUR, column bind the 3 data frames in step three to form a single complete data frame

STEP FIVE, extract only the mean and standard deviation features. We make use of the grep() function and Regular Expression to filter out the column that we want

STEP SIX, give the elements of "Activity" feature vector descriptive names (i.e. WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS etc. )

STEP SEVEN, Create a new data frame containing the mean of each variable by activity, by subject.

STEP EIGHT, write the data frame into a .txt file
