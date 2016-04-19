# Lesson 3: Doing more than one thing at a time and summarizing data
library(dplyr)

# We're going to use the Zika virus data again
# Load the data and store it in a variable called "zika": 



# Doing more than one thing at a time with %>% ---------------------------------
# Often you want to do more than one thing at a time. 

# For example, you might want to select only the SampleSource and 
# DaySinceInfection columns and then filter to the rows that contain samples of 
# Blood plasma or urine.
zikaSelected <- select(zika, DaySinceInfection, SampleSource)
filter(zikaSelected, SampleSource %in% c("Blood plasma", "Urine"))

# written another way: 
filter(select(zika, DaySinceInfection, SampleSource), SampleSource %in% c("Blood plasma", "Urine"))

# Both ways are pretty annoying and hard to read. Here's a better way: 
select(zika, DaySinceInfection, SampleSource) %>% 
   filter(., SampleSource %in% c("Blood plasma", "Urine"))

# What the %>% says is "take the thing to my left and use it in the thing to my
# right". The "." in filter says "use the thing from %>% here".

# You can do very simple things like
zika %>% head(.)
1:5 %>% mean(.)

# If you leave the "." out, it's implied to be the first thing in the function,
# so writing the following is equivalent, even though the "." is missing
1:5 %>% mean()

# or 
select(zika, DaySinceInfection, SampleSource) %>% 
   filter(SampleSource %in% c("Blood plasma", "Urine"))

# Try filtering for days above 21 and then select the Date and AnimalId columns:




# You can use as many %>% in a row as you want: 
select(zika, -Method) %>% 
   filter(SampleSource == "Urine") %>% 
   select(-SampleSource) %>% 
   filter(DaySinceInfection > 0) %>% 
   View()

# Try getting all the columns except for Method and Units and all the rows where 
# viral load is non-zero and then look at the head: 




# Summarizing data -------------------------------------------------------------
# The next function we'll learn is called summarize. It works like this: 
#        summarize(<data frame>, <NewColumnName> = <function of columns>)

# For example: 
summarize(zika, MeanViralLoad = mean(ViralLoad))

summarize(zika, NumberOfRows = n())

summarize(zika, WeirdData = sum(ViralLoad * DaySinceInfection))

summarize(zika, ViralLoadAbove0 = sum(ViralLoad > 0))

# How many rows have a viral load of 0? 




# The function you use always has to produce a single result, so this doesn't 
# work: 
summarize(zika, WeirdData = ViralLoad * DaySinceInfection)

# Summarizing with groups ------------------------------------------------------
# Summarizing isn't that useful when it can only operate over the whole data
# frame like the examples above. What would be cool is separate summaries for
# different subgroups of the data. For that we use group_by()
#     group_by(<data frame>, <column(s) to group by>)

# For example, what is the number of samples in each sample type? 
zika %>% 
   group_by(SampleSource) %>% 
   summarize(NumberOfSamples = n())
 
# How many of those had non-zero viral loads?
zika %>% 
   group_by(SampleSource) %>% 
   summarize(NumberOfSamples = n(), NonZeroViralLoad = sum(ViralLoad > 0))

# A trick to get fraction/percent
zika %>% 
   group_by(SampleSource) %>% 
   summarize(NumberOfSamples = n(), 
      NonZeroViralLoad = sum(ViralLoad > 0), 
      FractionNonZero = mean(ViralLoad > 0),
      PercentNonZero = mean(ViralLoad > 0) * 100)

# Max viral load per animal
zika %>% 
   group_by(AnimalId) %>% 
   summarize(MaxViralLoad = max(ViralLoad))

# Now you try: mean viral load per animal?






# Mean viral load by day, just for blood
zika %>% 
   filter(SampleSource == "Blood plasma") %>% 
   group_by(DaySinceInfection) %>% 
   summarize(MeanViralLoad = mean(ViralLoad))

# Also take in to account animal
zika %>% 
   filter(SampleSource == "Blood plasma") %>% 
   group_by(AnimalId, DaySinceInfection) %>% 
   summarize(MeanViralLoad = mean(ViralLoad)) %>% 
   View()

# Homework --------------------------------------------------------------------
# Use %>%, summarize, and group_by to answer these questions. Remember to run 
library(dplyr)
# before you start

# 1. How many nonzero viral loads were measured per animal? 



# 2. What was the mean urine viral load per animal? 



# Now a few questions from a new data set from http://datadryad.org/resource/doi:10.5061/dryad.06g12
# The data concern paramyxovirus infection in bats. Open this file: 
# Lesson-003/data/bat-viruses.csv

# Look at the data using the tools from lesson 1 and then answer the following
# questions.

# Helpful hint: Viral infection is encoded with "+" or "-" in this data set. To
# get the fraction of a group infected with the virus, use mean(Infected == "+")
# inside of a call to summarize.
 
# 3. What fraction of each sex is infected? 



# 4. Which bat family is most often infected? 



# 5. Which province has the highest level of infection? 



# 6. What species was most often collected? 



# 7. Are species within the same family infected at similar rates?


