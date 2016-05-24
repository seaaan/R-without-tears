# Lesson X: Making graphs

# We're going to use a package called ggplot2, so we need to install it: 
install.packages("ggplot2")

# and load it (along with dplyr): 
library(ggplot2)
library(dplyr)

# To start exploring R's flexible and board graph-making facilities, we'll use 
# the zika dataset again. Load the Lesson-001/data/zika.csv file and store it 
# in a variable called "zika":



# There's one minor issue with this data set. The animals are identified with
# numbers: 912116, 393422, and 826226. Our plots will sometimes do things we 
# don't want, so we need to tell R to view the AnimalId column as text, rather
# than as numbers, which is what this next line does: 
zika <- mutate(zika, AnimalId = as.character(AnimalId))

# Setting up a graph -----------------------------------------------------------
# ggplot2 is named for the book the "Grammar of Graphics" which explains the 
# funny name. All plots start with the same command: 
#        ggplot(<data frame>, aes(x = <ColumnName>, y = <ColumnName>, ...))

# For example, run this: 
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad))

# This command tells ggplot what data you're using and what you want on the x 
# and y axes. As you can see, it sets up the plot but doesn't actually show data

# The aes() function is used to map columns in your data to aesthetics on a 
# plot. The x and y-axes are examples of aesthetics, as are color, size, and 
# shape (of symbols or lines as we'll see below). Mapping data to an aesthetic
# means that the appearance or position of the aesthetic is determined by the 
# data. In this case, the scales of the x and y axes are determined by the range
# of values in the data.

# Actually showing the data ----------------------------------------------------
# ggplot2 is built around the idea of adding layers to the plot. So far, we have
# the base layer, but no data showing. To show the data, we need to add a layer.
# In this case, we'll add a "geom", which is a representation of data. Layers 
# are added with the "+" function. 

# Try this: 
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad)) +
   geom_point()

# Now all the data are shown. Clearly, there are a few very high values that 
# make it hard to see the rest of the data, so we'll add a log transform: 
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad)) +
   geom_point() +
   scale_y_log10()

# Now the data are easier to see. (The half-visible ones are all 0, which you 
# can't display on a log scale.) Still, you can't tell what data is what, so 
# it's pretty meaningless. We'll solve that with more aesthetics. 

# First, let's add a mapping from the type of sample to color, so that the 
# points will be colored by sample type.
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad, 
      color = SampleSource)) +
   geom_point() +
   scale_y_log10()

# Now the data are much more clear: viral load peaks highest and 
# earliest in the blood, with later, lower peaks in the urine and mouth

# You still can't tell which animal is which, so try adding a mapping 
# from AnimalId to shape. (Replace the "..." below.)
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad, 
      color = SampleSource, ...)) +
   geom_point() +
   scale_y_log10()

# x, y, color, and shape are probably the most common aesthetics. But there
# are others, such as size, which is illustrated below in what is probably
# an unwise choice.
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad, 
      color = SampleSource, size = AnimalId)) +
   geom_point() +
   scale_y_log10()

# Another way to enhance this graph would be to add lines connecting the points, 
# which we do with a geom_line() layer.
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad, 
      color = SampleSource, shape = AnimalId)) +
   geom_point() +
   geom_line() +
   scale_y_log10()

# Making subplots --------------------------------------------------------------
# ggplot2 really shines when it comes to separating your data out into subplots,
# which is called "facetting". 

# See, for example, this: 
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad,
      color = SampleSource, shape = AnimalId)) +
   geom_point() +
   geom_line() +
   scale_y_log10() + 
   facet_wrap(~ SampleSource)

# Now there is a separate graph for each type of sample, so we don't need to use
# color to tell them apart anymore. We can use color for animal and drop the 
# shapes. 
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad,
      color = AnimalId)) +
   geom_point() +
   geom_line() +
   scale_y_log10() + 
   facet_wrap(~ SampleSource)

# But perhaps we want to see separate graphs for each animal instead and
# have all the samples on the same graph. Copy the above code and modify it to
# make separate graphs for each animal, not each sample type.






# Sometimes different subgraphs have values of quite different sizes. In this
# case, it can be nice to have different scales for each graph. You can do that
# by including an extra bit of code when you add the facet_wrap layer, as below:
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad,
      color = AnimalId)) +
   geom_point() +
   geom_line() +
   scale_y_log10() + 
   facet_wrap(~ SampleSource, scales = "free_y")

# You can also specify "free" or "free_x" if you want the scales to be able to
# vary freely for both axes or the x-axis. 


# Sometimes it can be interesting to play around with facetting by different 
# variables to see what you can learn. For example: 
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad, 
      color = SampleSource, shape = AnimalId)) +
   geom_point() +
   scale_y_log10() + 
   facet_wrap(~ DaySinceInfection)

# This is a little silly, but if you change the x-axis to AnimalId, you can 
# easily compare the disease course of each animal on each day. 
ggplot(zika, aes(x = AnimalId, y = ViralLoad, 
      color = SampleSource, shape = AnimalId)) +
   geom_point() +
   scale_y_log10() + 
   facet_wrap(~ DaySinceInfection)

# Facetting can also be done by more than one variable by adding additional 
# columns with "+". Here we make separate graphs for each sample and animal.
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad, 
     color = SampleSource, shape = AnimalId)) +
   geom_point() +
   scale_y_log10() + 
   facet_wrap(~ SampleSource + AnimalId)

# facet_wrap will always only make the graphs that have data and display them as
# densely as possible. Sometimes you can make a nicer looking graph by using 
# facet_grid instead, which always lays the graphs out in a grid and will 
# include blank graphs if data is missing for a combination of variables. Here,
# it makes a very nice version of the previous graph.
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad, 
      color = SampleSource, shape = AnimalId)) +
   geom_point() +
   scale_y_log10() + 
   facet_grid(SampleSource ~ AnimalId) 

# Note the syntax differences: 
# facet_grid(ColumnName ~ ColumnName)
# facet_wrap(~ ColumnName + ColumnName)

# In fact, now you don't even need the colors and shapes.
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad)) +
   geom_point() +
   scale_y_log10() + 
   facet_grid(SampleSource ~ AnimalId)

# But adding a line doesn't hurt.
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad)) +
   geom_point() +
   geom_line() +
   scale_y_log10() + 
   facet_grid(SampleSource ~ AnimalId)

# Swapping the order is also interesting: 
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad)) +
   geom_point() +
   geom_line() +
   scale_y_log10() + 
   facet_grid(AnimalId ~ SampleSource)

# Homework ---------------------------------------------------------------------
# We'll use a new data set for the homework. They studied the effect of 
# cigarette smoke on immune cell (macrophage) function. http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0155791
# In the subset of the data we'll look at, they studied caspase-3 activity in
# the cells over time. The file is "Lesson-005/data/cigarettes.csv"

# 1. Make a plot of symbols with caspase activity on the y-axis and hour on the
#    x-axis. 



# 2. Change the plot to map treatment to an aesthetic (color, shape, etc.).




# 3. Change the plot to map sample to an aesthetic as well. 




# 4. Change the plot to make separate subplots for each sample.




# 5. Now we will change the data set. Use group_by and summarize to
#    average the replicates at each time point, treatment, and sample,
#    so for each sample, you have one measurement per time point and
#    treatment. Save the summarized data in a new variable called 
#    "summarized". The make the same graph as in #4 with summarized.




# 6. Now add lines (connecting the same treatment) to the graph from #5. 




# 7. Finally, try making subplots for the combination of sample and treatment.
#    (So there will be six subplots: two for each sample, one per treatment.)


