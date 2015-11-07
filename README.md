Getting and Cleaning Data Course Project
====

This repository contains the files for Getting and Cleaning Data assignment.

'run_analysis.R' Is the R script file. It downloads the data if it is not present and processes it to produce the required output.
'tidy_average_data.txt' Output of aforementioned script
'CodeBook.md' Description of the dataset

Code Description
====

1. The script downloads the original data if it is not present.
2. The data from the dataset are read into tables

* 'x_train' - Training set
* 'x_test' - Test set
* 'y_train' - Training labels
* 'y_test' - Test labels
* 'features_labels' - List of all features
* 'activity_labels' - Links the class labels with their activity name
* 'subject_train' - Each row identifies the subject who performed the activity for each window sample
* 'subject_test' - Each row identifies the subject who performed the activity for each window sample

3. The data is then processed in following way:

* 'x_combined' - Combines the 'x_train' and 'x_test'. Columns are named using 'features_labels'.
* 'x_selected' - Only the mean and standard deviation columns are selected.
* 'y_combined' - Combines the 'y_train' and 'y_test'.
* 'subject_combined' - Combines the 'subject_train' and 'subject_test'.
* 'dataset' - Creates big dataset out of 'x_combined', 'y_combined', 'subject_combined'. Column names are adjusted for clarity.

4. Final dataset is created and written

