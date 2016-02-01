# Getting-and-Cleaning-Data-Project
Final project for Coursera course involving the obtaining and cleaning of activity tracker raw data.

##The script is commented to explain what is happening, but the overall flow is as follows:

  1.  The data set is downloaded from the internet if it is not already unzipped in the current working directory.
  2.  The file is unzipped to the current directory.
  3.  The relevant data files are brought into R and appropriate column headers are attached.
  3.  The test and train data sets are merged together, along with their corresponding activity and subject.
  4.  The Mean and Standard Deviation columns are selected for all the variables.
  5.  The activity information is joined together with the variable data and the activity is decoded to display the activity being performed.
  6.  The final data table is grouped by the activity and subject and then means of all variables are calculated.
  7.  The resulting data table is exported to a text file for others to use.

##Code Book Information

More information on units associated with this data as well as how the data was collected can be found on the website where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
