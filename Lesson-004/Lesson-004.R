# Lesson 4: Changing existing columns and creating new ones with mutate
library(dplyr)

# We're going to use an SIV data set this time (source http://datadryad.org/resource/doi:10.5061/dryad.qn8n3)
# Load the file Lesson-004/data/siv.csv and store it in a variable called "siv": 



# This file contains the log10 viral loads of animals infected with SIV over 
# time. Viral loads are missing for many animals at many timepoints. 

# Changing columns with mutate -------------------------------------------------
# Sometimes your data set doesn't have the information in the form you want, or you want to add more information to the data frame.
#You can use the mutate function to mutate your data in a couple of ways
# 1) to change the data in an existing column
# 2) to add new column to the existing data frame

#        mutate(<data frame>, <ColumnName> = <function of columns>)

# Changing existing data:
# The data are provided as log10 of the viral loads, but it might
# be easier to interpret untransformed values.  
siv %>% 
   mutate(Day0 = 10^Day0) %>% 
   View()

# Try it yourself: calculate the untransformed value for Day21





# As another example, maybe you want to subtract the day 0 viral load 
# ("background") from the viral load on day 21
siv %>% 
   mutate(Day21 = Day21 - Day0) %>% 
   View()

# Try it yourself: calculate the untransformed values for both columns and then
# subtract the background




# Creating new columns with mutate ---------------------------------------------
# Using the same function, you can create a new column rather than changing an 
# existing column. It's just like changing a column, but you get to make up a name for
# the new column that you're adding. Let's call the new column "Day0Untransformed". 
siv %>% 
   mutate(Day0Untransformed = 10^Day0) %>% 
   View() # scroll all the way to the right 

# Try it yourself: calculate the untransformed value for Day21 and store it in
# a new column




