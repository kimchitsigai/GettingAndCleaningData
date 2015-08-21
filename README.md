# GettingAndCleaningData

The working directory is supposed to contain the global data files and the train and test directories.

The function run_analysis() first loads plyr as it uses the mapvalues() function for Question 3.

For Question 1, X_train.txt and X_test.txt files are read then rbind()ed.

For Question 2. Mean and Std deviation fields end by "-mean()" and "-std()", this is in in features.txt.
The data frame from Question 1 is filtered to keep only the columns whose names contain "-mean()" or "-std()".

For Question 3. y_train.txt and y_test.txt files say to which activity each record corresponds.
The activity number (between 1 and 6) is replaced by its label and is appended to each row of the data frame computed in Question 2.

For Question 4. Labels for the columns can be found in the features data frame read from features.txt in Question 2.

For Question 5. subjects_train.txt and subjects_test.txt say to which subject an observation corresponds. 
The Subject column is appended to the data frame computed in Question 3.
Then, for each subject s, activity a, variable v, the mean is calculated.
A record containing the Suject, Activity, Variable Name and Average is appended to the finale data frame (the tidy dataset).
The tidy dataset contains 30(users) * 6 (activities) * 66 (mean and std variables)= 11880 records.

codebook.txt describes the features in the tidy dataset.
The original data description and datasets can be found here : 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

