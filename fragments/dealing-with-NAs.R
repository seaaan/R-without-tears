# Dealing with missing values --------------------------------------------------
# Missing values are represented with "NA". The siv data has many NA values. NA
# values are helpful, because they let you indicate what data are missing, but 
# they can be very inconvenient. For example: 
1 / NA
NA > 0
2 + NA

siv %>% 
   summarize(AvgDay3 = mean(Day3)) 

# To get around NAs, sometimes you can ignore them
siv %>% 
   summarize(AvgDay3 = mean(Day3, na.rm = TRUE)) 

# Other times you need to take a different approach. Here, we'll replace the 
# NAs with a sensible value, using mutate and a new function, ifelse. 

# First, calculate the replacement value. As an example, we'll replace all of 
# the NA viral loads on Day3 with the mean of non-missing viral loads.  

# What's the average non-missing viral load on Day3 and what is na.rm doing?
siv %>% 
   summarize(AvgDay3 = mean(Day3, na.rm = TRUE)) 

# Store that in a variable
average_day_three <- 1.860461

# Find out which rows are NA. The "is.na()" function gives TRUE if the value is
# NA and FALSE otherwise. 
siv %>% 
   mutate(IsDayThreeNA = is.na(Day3)) %>% 
   View()

# Now what we want to do is replace the value for Day3 with average_day_three
# for the ones where the value is NA, and leave alone the ones where the value 
# is not missing. We'll use ifelse() for that. 

# Digression on ifelse() ----------------------------------------------------
# ifelse(<conditional>, <result if true>, <result if false>)
# In English: "If this statement is true, give this result, otherwise, give this other result."

ifelse(1 > 2, "one is greater than two", "one is less than two")

ifelse("a" == "a", "they're the same!", "they're different")

# You try it: write an ifelse function comparing 3 and 4 and giving the 
# result 17 if true, or 85 if false



# Examples with NA
ifelse(is.na(NA), average_day_three, "original result")

ifelse(is.na(3.21), average_day_three, "original result")

# Now that you have an idea how ifelse works, let's continue: 
siv %>% 
   mutate(IsDayThreeNA = is.na(Day3)) %>%
   mutate(FixedDay3 = ifelse(IsDayThreeNA, average_day_three, Day3)) %>% 
   View()

# While using mutate twice and creating new columns makes it's clearer, it's 
# not really necessary. You can just do: 
siv %>% 
   mutate(Day3 = ifelse(is.na(Day3), average_day_three, Day3)) %>% 
   View()

# You try it: Change all of the missing values in the Day224 column to 1000







# Summary ---------------------------------------------------------------------
# mutate(): create a new column or replace an existing column
# ifelse(): gives one result if true, another result if false
# NA: representation of missing data, sometimes a pain in the neck

# Homework --------------------------------------------------------------------
# Use mutate, ifelse, and whatever else you need to answer these questions. 
# Remember to run 
library(dplyr)
# before you start to load the dplyr package, which contains most of the functions we've learned
# including mutate.

# 1. Create a new column called "SuperDay3" that consists of the values in Day3
#    multipled by 10. Don't worry about NAs. 



# 2. Repeat problem 1, but then go back and change the values in SuperDay3 to be
#    themselves divided by 5. 



# 3. Create a new column called NobelPrizeWinner that contains your special 
#    algorithm for predicting SIV outcome: the viral load on Day21 times 2, 
#    minus the viral load on Day14, divided by the viral load on Day0. 



# 4. Write an ifelse statement comparing 1000 and 100 in some way and returning
#    pi (just write pi, no quotes) if the comparison is false and 1E6 if true.



# 5. Create a new column (named whatever you want) dividing the animals into 
#    groups based on their day 21 viral loads. The group should be "high" if 
#    the viral load is greater than six and "medium" otherwise. That is, the
#    new column should contain "high" if the day 21 viral load is above six, and
#    "medium" otherwise. 



# 6. Update the Day3 column so all the NA values are replaced by "ugh".  



