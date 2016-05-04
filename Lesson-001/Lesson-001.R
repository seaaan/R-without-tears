# Lesson 1: Getting started

# Running code ----------------------------------------------------------------
# Lines that start with "#" are called "comments" and don't do anything. You can
# take notes right in this file by using comments.

# Here is some code: 
1 + 2
2 * 5
3 > 4
4 == 4

# There are several ways to run code: 
#  1. Click on the line you want to run. Click "Run" in the top right corner.
#  2. Click on the line you want to run. Type CTRL+Enter (Cmd+Enter on Mac).
#  3. Copy and paste the line you want to run into the Console and press enter.

# You try it:  

#  1. What is 9348 * 482? 
#  2. What is 8593928 / 1452?
#  3. Is 8374 * 9302 bigger than 77894948 / 10?

# Put your code here: 




# Opening data ----------------------------------------------------------------
# Opening your data in R is the first step to any analysis. There are some 
# example files in the Lesson-001/data/ folder. 

# Run this code: 
myData <- read.csv("Lesson-001/data/example-data.csv")

# Sooo... nothing happens?
# Actually, this line does several invisible things: 
   
#  1. "read.csv()" opens the file in R and turns the file into a "data frame", 
#     which is like an Excel worksheet.

#  2. "<-" stores the data frame in a variable called "myData" (but you could name
#     it whatever you want). It is best to avoid naming your data "data" since "data" is used as an argument in many functions so
#     it can lead to confusion for you and R. Use names that will make sense to you and other humans when you look at it in 6 months.

#  3. "<-" makes "myData" available in the global environment, which is the place 
#     where all the open files and objects you have live. 

# Main point: the file is open and ready for use. 

# Looking at your data --------------------------------------------------------
# There are many ways to view data in R. Run the code below and answer the 
# questions

myData
# What does this line do? 



View(myData)
# What does this line do? 



summary(myData)
# What does this line do? 



str(myData)
# What does this line do? 



# What happens when you click on the table icon next to the entry for "myData" in
# the Environment pane? 



myData$Viability
# What does this line do? 



head(myData)
# What does this line do? 



tail(myData)
# What does this line do? 




# Homework --------------------------------------------------------------------
# We'll use some data from an experiment with Zika virus infection of non-human
# primates (Source https://zika.labkey.com/project/home/begin.view)

# Load the "Lesson-001/data/zika.csv" file into R. You can store it in a 
# variable named "data" like before, or you can name it something new. 

# Use the different methods of viewing data in R to answer these questions.
# 1. What are the names of the columns of the data? 



# 2. How many different types of samples did they use? 



# 3. What are the units for oral swabs? What are the units for urine? 



# 4. What was the highest viral load measured in the study? 


