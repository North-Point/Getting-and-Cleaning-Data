clean_data:
	1. download and unzip the data
	2. merge each dataset using merge_data
	3. merge train and test dataset with rbind
	4. read features from features.txt
	5. extract the right features and subset the dataset
	6. revalue activities with their description

merge_data:
	1. read dataset: subject, label, features
	2. combine them using cbind

write_avg_tidy_dataset:
	1. for each subject and activity calculate the average value for each extracted feature
	2. rename the columns
	3. write into the output file

get_colnames()
	1. return a vector of more clear names for each column