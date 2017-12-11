# Lesson ???: Normalization

# Introduction -------------------------------------------------------
# Normalization, such as background subtraction, fold change, and percent of 
# control is so common that it deserves its own lesson. 

# Example data
# The data comes from http://datadryad.org/resource/doi:10.5061/dryad.sk64k
# They tested how well (re)vaccination in protecting cows from challenge with
# a mycobacterial pathogen. This particular data set gives interferon-gamma
# production as measured by ELISA after stimulation with control or with 
# mycobacterial antigens ("ESAT").

# The file is called "Lesson-???/data/cows.csv"

# Load the data. We will also use dplyr and ggplot2, so load those too: 




# Look at the data to get an idea of its structure: 




# Change the "Date" column to be dates instead of character/factor data by 
# using the function as.Date(): 




# Normalization goal -----------------------------------------------------------
# Subtract the background levels of IFNg (the levels after vehicle stim) from 
# the levels after mycobacterial antigen (ESAT) stim. 

# Practically, this means have one column called IFNg and one column called 
# BackgroundIFNg, with the values match by date, group, and cow. 

# Approach: 
# 1. Split into two data sets
# 2. Rename the column in the control data set
# 3. Merge the two data sets back together
# 4. Do the background subtraction

# Create a new data set called "stimmed" with only the ESAT-stimmed samples: 



# Create a new data set called "controls" with only the vehicle-stimmed samples:



# From the controls data, copy the IFNg data into a new column called 
# BackgroundIFNg. Now remove the Stim and IFNg columns from the controls data:




# Merge the data sets: 
# Use an inner_join to combine the two files: 



# Now create a new column, BackgroundSubtractedIFNg, by subtracting the 
# appropriate columns in the combined data: 




# Now make a few plots to see what effect the different vaccinations have on the
# interferon-gamma response to stimulation: 








# Another example --------------------------------------------------------------
# It is kind of hard to see any difference between groups. Maybe it would be 
# clearer if we normalized the responses to the control (Non-vaccinated) group

# This time there isn't a pair of measurements for each cow at each time point,
# we'll instead need to normalize each cow to the average response in the 
# non-vaccinated group at each time point. 

# Approach: 
# 1. Split into two data sets
# 2. Calculate the average background-subtracted IFNg level for each time
#     point in the non-vaccinated group
# 3. Merge the two data sets back together
# 4. Calculate percent of non-vaccinated response

# Create a new data set called "vaccinated" by excluding the non-vaccinated cows
# (make sure to use the "combined" data set because you want the background-
# subtracted responses): 



# Create a new data set called "unvaccinated" with only the non-vaccinated cows:



# Average the background-subtracted interferon-gamma responses at each time
# point in the unvaccinated data set. You want to end up with two columns 
# (Date and a new column, UnvaccinatedResponse) and seven rows, one for each 
# date: 





# Merge the data sets: 





# Create a new column, PercentOfUnvaccinated, by dividing the background-
# subtracted responses by the unvaccinated responses and multiplying by 100:




# Now revisit your plots and see what you learn by looking at the percent
# of unvaccinated instead: 





# Homework --------------------------------------------------------------------

# 1. Go back to the example where you calculated percent of unvaccinated and
#     repeat the merge. Instead of merging the unvaccinated means into the 
#     vaccinated data set, merge it into the "combined" data set (i.e. the one
#     including both the vaccinated and unvaccinated cows). Now repeat the 
#     percent of unvaccinated and graphing. You should see that the non-
#     vaccinated cows have an average of 100%. Including the control data in the
#     final outcome like this can be useful for checking that your merging and
#     normalization are working like you expect them to. 
