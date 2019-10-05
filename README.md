# Detecting manual gear positions using HOG Features and SVM Classification
Final Course Project for Spring 2019 CSCI 4301 Digital Image Processing  
Basic project that served as an introduction to Digital Image Processing, Machine Learning, and MATLAB  

## Setup for gathering data
![image](https://drive.google.com/uc?export=view&id=1RX4B1Ck_NyPaMHndea6wDjO2DYBjyfPU)


## Instructions to run code

Files Provided via GDrive Link: ground data video, test data video, demo output  
Files Not Provided:  parsed ground/test video images, ground_gear_ranges, test_gear_ranges, trained svm models  
https://drive.google.com/open?id=15csK7rZBYML2SpBF2gbmXVofz9BeyQsq  

Move Ground Data.wmv and Test Data.wmv into video_data/  

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
		run lines 13 and 15 for rbf
		or run lines 14 and 16 for linear	(Part b. Not required to produce final output)  

4. Open outer/Form.m
	a. To produce the final output,  
		run lines 11 and 13 for rbf  
		or run lines 12 and 14 for linear  
		allow for video to produce, once busy on bottom left has dissapeared  
		or once time elapsed has been printed on the console.  
