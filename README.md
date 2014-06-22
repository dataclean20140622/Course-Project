Course-Project
==============

Getting and Cleaning Data  Course Project

Hi, I'm glad to meet you on Coursera. This is my description of how my code works:

If you open my run_analysis.R in the url:https://github.com/dataclean20140622/Course-Project/blob/master/run_analysis.R,you'll see that there are several functions first, but I'll talk about them when using them, they are just for convenient.

step 1: The first thing is read the test and train data in R. After that, I use rbind to bind them together. Note that raw data here is of nouse, I only read X_test.txt, X_train.txt, y_test.txt and y_train.txt. Also, features.txt, subject.txt and activity_label.txt are useful too.

step2: Now I have bind data in X_test.txt and X_train.txt as well as y_test.txt and y_train.txt, I use regular expressions to extracts only the measurements on the mean and standard deviation for each measurement, that is: grepl("mean|std", ...) in my code.Using the grepl function and some simple operations, now I remove other columns(neither mean or std) by a function called 'removeUselessColumn(X)'.

step3: As I had read features in R, now I filter these feature names by a function called 'createfeaturevector(data)' to get the column names needed. Then, follow instruction 4, I just appropriately labeled the data set with descriptive variable names.

step4: Here I add two columns naming 'subject' and 'activity_label' to bind these data into my current data set, that is the data.frame named 'tidy'. Certainly, I use labe description  to follow instruction 3--use descriptive activity names to name the activities in the data set. Note that in order to produce the average data, I also create a data.frame called tidyMean to compute mean value.

step5: Now I've got two tidy data set named 'tidy' and 'tidyMean', and I use write function to export them. I use csv format to present them in a good look. But as Coursera does not accept csv file, I submit them in txt format. That's why my work is txt file and my code use csv.

Other: I add activity_name and subject as the two last columns in data set 'tidy'. And I list first 6 activity and then 30 subject as row names in data set 'tidyMean'.

Thanks for reading.
