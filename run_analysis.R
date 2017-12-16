run_analysis <- function(){
library(dplyr) ## the following function makes use of the dplyr library

##STEP ONE,
## Load is all the testing and training data, 
##ENSURE THAT "THE UCI HAR Dataset" FOLDER IS EXTRACTED TO YOUR WORKING DIRECTORY,
## XTEST/ XTRAIN being the feature vector (561 features) calculated from raw readings from the accelerometers and gyro 
## YTEST / YTRAIN being the 6 target activities
## SUBJECTTEST/SUBJECTTRAIN being the ID for the 30 test subjects
## FEATURES being the name of the 561 features or variables

XTEST <- read.table("UCI HAR Dataset/test/X_test.txt")
XTRAIN <- read.table("UCI HAR Dataset/train/X_train.txt")
YTEST <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE, stringsAsFactors = FALSE)
YTRAIN <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE, stringsAsFactors = FALSE)
SUBJECTTEST <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE, stringsAsFactors = FALSE)
SUBJECTTRAIN <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE, stringsAsFactors = FALSE)
FEATURES <- read.table("UCI HAR Dataset/features.txt", sep = " ",header = FALSE, stringsAsFactors = FALSE)

##STEP TWO,  
##we row bind all testing and training data; testing data above and training data below, 
##sequence must be consistent!
XMERGED<- rbind(XTEST,XTRAIN)
YMERGED <- rbind(YTEST,YTRAIN)
SUBJECTMERGED<- rbind(SUBJECTTEST,SUBJECTTRAIN)

##STEP THREE, we give proper names to the merged data frames
col.from<- names(XMERGED) ## assign the variable names to a vector of characters 
col.to <- FEATURES$V2 ## same as above
NAMEDXMERGED<- XMERGED %>% rename_at(vars(col.from), ~col.to) # rename the columns of XMERGED to the names given in features.txt
NAMEDYMERGED <- rename(YMERGED, Activity = V1) #rename the column in YMERGE to "Activity"
NAMEDSUBJECTMERGED <- rename(SUBJECTMERGED, SubjectID = V1 ) #rename the column in SUBJECTMERGED to "SubjectID

##STEP FOUR, we column bind all three data frame to form our full data frame, 
##properly named and includes both testing and training data
COMPLETE <- cbind(NAMEDSUBJECTMERGED,NAMEDYMERGED,NAMEDXMERGED)

#STEP FIVE, extract only the mean and standard deviation features. We make use of the grep() function and Regular Expression to filter out the column that we want
M<- grep("[Mm]ean+",names(COMPLETE)) ## create a vector of index corresponding to columns with names that contain the word "mean", include capital M
S<- grep("[Ss]td()+", names(COMPLETE)) ## create a vector of index corresponding to columns with names that contain the word "std()", include capital S       
MEANORSTDDEV <- COMPLETE[,c(1,2,M,S)] ## subset the SubjectID (column 1), Activity (column 2) and all columns corresponding to mean and standard deviation data from COMPLETE.


#STEP SIX, give the activities descriptive names 
for (i in 1: nrow(MEANORSTDDEV)){
      if (MEANORSTDDEV$Activity[i] == 1) {
            MEANORSTDDEV$Activity[i] <- "WALKING"
      } else if(MEANORSTDDEV$Activity[i] == 2){
            MEANORSTDDEV$Activity[i] <- "WALKING_UPSTAIRS"
      } else if(MEANORSTDDEV$Activity[i] == 3){
            MEANORSTDDEV$Activity[i] <- "WALKING_DOWNSTAIRS"
      } else if(MEANORSTDDEV$Activity[i] == 4){
            MEANORSTDDEV$Activity[i] <- "SITTING"
      } else if(MEANORSTDDEV$Activity[i] == 5){
            MEANORSTDDEV$Activity[i] <- "STANDING"
      } else if(MEANORSTDDEV$Activity[i] == 6){
            MEANORSTDDEV$Activity[i] <- "LAYING"
      }
}
                                   
#STEP SEVEN, Create the data frame of the mean of each variable by activity, by subject. 
MEAN <- aggregate(MEANORSTDDEV[,3:88], by = list(MEANORSTDDEV$SubjectID, MEANORSTDDEV$Activity), mean)

MEAN <- MEAN %>% rename(SubjectID = Group.1, Activity = Group.2) %>% arrange(MEAN$Group.1)

#STEP EIGHT, write the data frame into a .txt file with row.names = FALSE for submission
write.table(MEAN,"UCI HAR Dataset/mean.txt", row.names = FALSE)
return(MEAN)
}