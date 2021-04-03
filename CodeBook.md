The output of the script is a text file named "average_data_set". It contains the independent 
tidy data set with the average of each variable for each activity and each subject. There are
four variables in this file:
1. subject
	- The subject number
2. activity
	- The activity name, e.g. WALKING
3. feature
	- The feature name, e.g. Time.BodyAcceleration.mean.X
4. average
	- The average of each feature


The original feature names (in file features.txt) are transformed into descriptive feature names.
The transformations are described below:
* Prefix t is transformed to "Time."
* Prefix f is transformed to "Freq."
* The string "Acc" is transformed to "Acceleration"
* The string "Gyro" is transformed to "Gyration"
* The string "Mag" is transformed to "Magnitude"
* The string "-" is transformed to "."
* The string "()" is transformed to ""
Example:
	- "tBodyAcc-mean()-X" is converted to "Time.BodyAcceleration.mean.X"
	- "tGravityAccMag-mean()" is converted to "Time.GravityAccelerationMagnitude.mean"

There are a total of 3160 separate features contained in the file "average_data_set".
Each feature has its own average (per activity and per subject).