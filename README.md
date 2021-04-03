
The purpose of this project is to demonstrate the ability to collect, work with, and clean 
a data set. The goal is to prepare tidy data that can be used for later analysis. 

The analysis is actually carried out by the R script run_analysis.R. This script assumes the 
current working directory contains the data directory "UCI HAR Dataset". It will change 
the working directory to the data directory when it starts executing.

The R script can be executed via source("run_analysis.R"). The script is also dependent on
two R libraries: tidyr and dplyr. So make sure to install them before executing the script.

The output of the script is a text file named "average_data_set". The output file is stored
in the working directory. The content of this file is the independent tidy data set with 
the average of each variable for each activity and each subject.
