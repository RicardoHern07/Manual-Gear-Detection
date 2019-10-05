# Detecting manual gear positions using HOG Features and SVM Classification
Final Course Project for Spring 2019 CSCI 4301 Digital Image Processing

## Setup for gathering data
![Image of Setup]
(https://drive.google.com/uc?export=view&id=10ZfWgBnVrfX4IZPSTwxUuQbBkaBKqCLX)

## Instructions to run code

Files Provided: ground data video, test data video,demo output
Files Not Provided:  parsed ground/test video images, ground_gear_ranges, test_gear_ranges, trained svm models


1. Run, AddPath in Command Window (required)

2. Open outer/PreProc.m
	a. Run both sample calls situated above function, ParseVideo2Images
		This will populate the data/ground_gears/ and data/test_gears/ folders with 
		images parsed from the ground and test videos

	b. Categorize parsed images into respective folders in data/ground_gear_ranges/ and data/test_gear_ranges/
		To increase accuracy, include as many images from data/ground_gears/ as possible
		To test accuracy, include a few images from data/test_gears/	(Not required to produce final output)
	
	c. Once categorized, run both sample calls situated above function, ConstuctMat (Second sample call not required to produce final output)

3. Open outer/Prior.m
	a. Run the sample call situated above function, TrainSVM

	b. To test svm accuracy on the produced test gear mats,
		run either line 13 or 14, decision between linear or rbf
		run either line 15 or 16, decision between linear or rbf	(Part b. Not required to produce final output)

4. Open outer/Form.m
	a. To produce the final output,
		Either run lines 11 and 13 for linear or run lines 12 and 14 for rbf
		allow for video to produce, once busy on bottom left has dissapeared
		or once time elapsed has been printed.
		
		Note: a copy of original produced output will be provided but can be overwritten
			 by following this step.
