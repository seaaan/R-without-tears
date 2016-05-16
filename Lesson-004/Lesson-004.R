# Lesson 4: Changing existing columns and creating new ones with mutate
library(dplyr)

# We're going to use a new data set this time (source http://dx.doi.org/10.1371/journal.pone.0085675)
# Load the file Lesson-004/data/cervix.csv and store it in a variable called 
# "cervix": 

cervix<-read.csv("Lesson-004/data/cervix.csv")

# The data consists of the number different types of immune cells isolated from
# the cervix when using two different sampling tools. 

# Changing columns with mutate -------------------------------------------------
# Sometimes your data set doesn't have the information in the form you want, or 
# you want to add more information to the data frame.
# You can use the mutate function to mutate your data in a couple of ways
#     1) to change the data in an existing column
#     2) to add new column to the existing data frame

#        mutate(<data frame>, <ColumnName> = <function of columns>)

# Changing existing data:
# The data are provided as counts of immune cells, but perhaps you're interested
# in the percent of immune cells that are B cells
cervix %>% 
   mutate(BCells = BCells / ImmuneCells * 100) %>% 
   View()

# Try it yourself: calculate the percent of immune cells that are macrophages





# As another example, maybe you notice that the data are skewed by the presence
# of some samples with very high numbers of cells and instead you want to 
# analyze the data after log-10 transformation. 
cervix %>% 
   mutate(ImmuneCells = log10(ImmuneCells)) %>% 
   View()

# Try it yourself: transform the Macrophages column to log10




# Creating new columns with mutate ---------------------------------------------
# Using the same function, you can create a new column rather than changing an 
# existing column. It's just like changing a column, but you get to make up a 
# name for the new column that you're adding. Let's calculate the total number 
# of T cells and call the new column TotalTCells. 
cervix %>% 
   mutate(TotalTCells = CD4TCells + CD8TCells) %>% 
   View() # scroll all the way to the right 

# Try it yourself: create a new column called SummedImmuneCells that is the
# sum of all the columns except the ImmuneCells column. 




# Try it some more: copy your previous work and create another new column, this
# time called MysteryPopulation that is the difference between the ImmuneCells
# columns and the SummedImmuneCells column. These cells represent the immune 
# cells that didn't fit into any of the populations listed. 





# New columns can contain any kind of data. For example, you could create a 
# column that indicates whether a sample has more T cells or macrophages
cervix %>% 
   mutate(MoreMacrophagesThanTCells = Macrophages > (CD4TCells + CD8TCells)) %>% 
   View()

# If you summarize with that column, you learn that cytobrushes give more 
# macrophages and biopsies give more T cells
cervix %>% 
   mutate(MoreMacrophagesThanTCells = Macrophages > (CD4TCells + CD8TCells)) %>% 
   group_by(Sample, Site) %>% 
   summarize(PercentWithMoreMacrophages = 100 * mean(MoreMacrophagesThanTCells)) 

# Homework --------------------------------------------------------------------
# Use mutate (as well as what you've learned in previous lessons!) to answer 
# these questions. Remember to run 
library(dplyr)
# before you start

# 1. For each Nairobi cytobrush sample, what percent of T cells are CD4+ T cells? 


# 2. For Chicago biopsy samples, what is the average percent of the ImmuneCells that are macrophages?


# 3. In which Seattle samples are there more CD4 T cells than CD8 T cells?