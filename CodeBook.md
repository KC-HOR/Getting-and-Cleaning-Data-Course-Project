
# Codebook for  mean.txt

Column 1 - SubjectID 
This is the identifying number for the 30 volunteers that undertook the tests. 

Column 2 - Activity
This is the label of the 6 activities performed by the volunteers

Column 3 to 88 - "tBodyAcc-mean()-X"....."fBodyBodyGyroJerkMag-std()"
These are the 86 means and standard deviations of the gyroscope and accelerometer readings that we subset from original testing and training data. The description of each of these features is explained in the codebook of the original dataset.

These features were treated further by taking the average for each activity and each subject. As we only took the average of these readings, the units are preserved, which are standard gravity units 'g' for all acceleration readings ("...acc...") and radians/second for all gyroscope readings ("...gyro...").  
