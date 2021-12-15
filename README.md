# Getting-and-Cleaning-Data-Project

## Part 1 code
The first section of code downloads the required documents from the url. An if 
statement is included so that files do not get redownloaded if they are already
present. The Train dataset is with the 571 feature vector is combined with the
participant ID and the physical activity identifier. This dataframe is organized
with participant ID in the first column, the physical activity identifier in the
second column, and the feature vector in the subsequent columns. The same was
done for the Test dataset. These were then combined using rbind to make one large
dataset with data from all the participants.

## Part 2 code
The next section reads in the features.txt file which has all of the variable
names for the gyroscope and accelerometer data. Using the grepl function, a logical
vector of names that contain either mean or std is created. Using this, the 
combined data from the previous step is filtered to only contain features in 
accordance with the logical vector. This trimmed data is then joined with the 
participant ID column and physical activity column

## Part 3 code
The activity_labels.txt file is read in and is used to replace the numeric 
representations for physical activities with strings. Underscores were removed 
from the strings to eliminate an downstream errors caused by including non 
alphanumeric characters.

## Part 4 code
This part used the feature labels selected from part 2. First a vector of characters
to be removed was created. Then a loop was used in conjunction with the gsub 
function to remove these characters. Following this, t and f were replaced with
time and freq, using gsub, to make it more explicit that these variables corresponded
to the time and frequency decompositions.

## Part 5 code
Using the dplyr package, the mean of the columns is calculated very easily. The
groupby function selects how the data is to be combined for the calculation in 
the subsequent summariseall step. In this case the data is to be averaged across
participant ID and physical activity. The summariseall step then calculates the
mean values for all of the columns. Finally arrange organizes the resulting 
data in ascending order based on participant ID followed by physical activity.
The result from this is stored in the Avg_Data variable which is then written to
a text document called Tidy_data.txt
participant ID and physical activity.
