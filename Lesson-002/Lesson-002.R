# Lesson 1: Getting the rows and columns you want

# We are going to use some functions that don't come with R. They are part of a 
# "package" called "dplyr". You need to install the package: 
install.packages("dplyr")

# You only need to install it once. But you need to load it every session where
# you use it, with this command: 
library(dplyr)

# We'll use the Zika virus data from your homework to explore today's topic
# Load the data and store it in a variable called "zika": 




# Selecting columns ------------------------------------------------------------
# The first function we'll use is called select. It works like this: 
#        select(<data frame>, <column names separated by commas>)

# For example: 
select(zika, Date, DaySinceInfection, ViralLoad)

# You can store the result in a new variable and then use the functions from
# last time to view the results
datesAndViralLoads <- select(zika, Date, DaySinceInfection, ViralLoad)

# Try selecting just the columns ViralLoad and Method and storing the result in 
# a new variable: 




# That gets you the columns that you *do* want. Sometimes you just want to 
# exclude one or two columns. In that case, put a "-" in front of the columns
# you don't want. 
select(zika, -Method)

# What columns do you get if you run the following line? 
select(zika, -Date, -AnimalId)




# Filtering for rows -----------------------------------------------------------
# Now we'll learn how to get just the rows we're interested in by using a new 
# function called filter
#     filter(<data frame>, <criteria for rows of interest>)

 
filter(zika, ViralLoad > 100000)
# What does this line do? 



filter(zika, SampleSource == "Urine")
# What does this line do? 



filter(zika, ViralLoad != 0)
# What does this line do? 



filter(zika, ViralLoad != 0, DaySinceInfection == 1)







# Homework --------------------------------------------------------------------
# Use filter and select to answer these questions. Remember to run 
library(dplyr)
# before you start

# 1. How many samples had a viral load above 1000000? 100000? 10000?



# 2. How many samples were collected on day 28 after infection? 



# 3. How many samples had a non-zero viral load on day 3 after infection? 



# 4. How many day 11 blood plasma samples had a viral load of zero? 



