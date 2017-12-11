# Lesson ???: Combining multiple files

# Introduction -------------------------------------------------------
# Data from a single experiment is often stored in multiple files. For example,
# you might have one file containing the data from an instrument, identified by
# position in the plate. In another file, you might have the key that shows 
# which wells were treatment and which were control. Here we will learn how to
# combine those files together. 

# Example data
# The data come from an RNA microarray experiment. The amount of RNA present was
# determined for thousands of probes (1-2 probes per gene). The difference 
# between treated and control samples was determined for each probe. The data is
# stored in "Lesson-???/data/expression.csv". 

# Load the data. We will also use dplyr and ggplot2, so load those too: 




# Look at the data to get an idea of its structure: 




# Each probe is identified with a number, but that number doesn't easily tell
# us what gene was measured. The identity of the probes is stored in a separate
# file, "Lesson-???/data/genes.csv". Load and look at that file: 




# Combining multiple files is called "joining" or merging". It works like this:

combined <- inner_join(data, genes)
# inner_join(<data1>, <data2>, by = NULL)
#     <data1> is the first data set
#     <data2> is the second data set
#     <by> specifies which columns to match
#           We left it out, so it matches all of the columns with the same names
#           You can specify which columns to match by if you only want to do
#              specific columns. See ?inner_join

# Look at the combined data. What columns does it have? How many rows does it 
# have? How does that compare to the two parent data frames?




# In a join, the two sets of data can be viewed as circles in a venn diagram and
# the type of join determines which of the overlaps is in the result: 

# inner_join: rows in BOTH data1 and data2
# left_join : rows in data1
# right_join: rows in data2
# full_join : rows in EITHER data1 or data2
# see: http://r4ds.had.co.nz/diagrams/join-venn.png

# Perform all four types of join on our data. How many rows do you get as a 
# result of each type? What happens when a row doesn't have a match in the other
# data frame? 




# TODO ~!@$~!@$~!@$~!@$~!@$~!@$~!@$~!@$~!@$~!@$~!@$~!@$~!@$~!@$~!@$~!@$

# need examples of more complicated merges (e.g. specifying by)
# note that the first example could be done with a spread instead





# Reading: http://r4ds.had.co.nz/relational-data.html
