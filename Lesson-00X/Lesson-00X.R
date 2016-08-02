# Lesson X: Bar graphs

# ggplot2 has a variety of functionality for creating bar graphs, but
# it doesn't always work like you might expect. 

# data ------------------------------------------------------------------
# For this lesson, we'll use data from http://dx.doi.org/10.5061/dryad.11vs5
# From the paper's abstract: 
#     Recent studies suggest that facial attractiveness indicates immune 
#     responsiveness in men and that this relationship is moderated by 
#     stress hormones [...] However, studies testing [the same thing in women] 
#     are lacking. Here, we photographed young Latvian women, vaccinated 
#     them against hepatitis B and measured the amount of specific antibodies
#     produced, cortisol levels and percentage body fat. Latvian men rated 
#     the attractiveness of the women's faces.
library(ggplot2)
library(dplyr)

data <- read.csv("Lesson-006/data/attractiveness.csv")

# Take a look at the data using some of the functions you've learned to get
# an idea of what it looks like. 




# Bar graphs for counts/histograms ---------------------------------------
# By default, geom_bar() plots number of observations
ggplot(data, aes(x = Age)) + geom_bar()

# This works well above because the age is given in integer units, so it's 
# pre-binned, but it doesn't work so well for continuous data.
ggplot(data, aes(x = Attractiveness)) + geom_bar()

# As an alternative, try geom_histogram()
ggplot(data, aes(x = Attractiveness)) + geom_histogram()

# It's good to take the advice of the message that appears.
ggplot(data, aes(x = Attractiveness)) + geom_histogram(binwidth = 1)

# Binwidth is specified in terms of the width of bin on the x-axis. You
# can also use bins = which just divides the range of the x-axis: 
ggplot(data, aes(x = Attractiveness)) + geom_histogram(bins = 6)

# Use geom_histogram to explore the data for the columns below. Try 
# specifying the size of the bins using either binwidth or bins
# AntiHBS = Hepatitis B antigen titer
# Fat = Percentage body fat
# Cortisol = level of cortisol in the blood






# Bar graphs for non-counts --------------------------------------------
# Bar graphs are commonly also used to display summaries of data other 
# than the number of observations. For example, the mean of each condition.

# First, create a new data frame containing the statistics of interest
summary <- data %>% 
   group_by(Age) %>% 
   summarize(Attractiveness = mean(Attractiveness),
      AntiHBS = mean(AntiHBS),
      Fat = mean(Fat),
      Cortisol = mean(Cortisol))

# Now, try to graph it: 
ggplot(summary, aes(x = AntiHBS)) + geom_bar()

# Pretty sure that's not what you want. How about? 
ggplot(summary, aes(x = Age, y = AntiHBS)) + geom_bar()

# Still not right. The problem is, by default geom_plot counts the number
# of observations. You need to tell it to use the values in the y column
# instead: 
ggplot(summary, aes(x = Age, y = AntiHBS)) + 
   geom_bar(stat = "identity")

# Try making graphs of the means of the other columns. 





# So this works, and you can add error bars, but it's not the easiest
# in that you have to pre-calculate the statistics. Consider this a 
# nudge in favor of more informative plot types, like box and whisker plots
ggplot(data, aes(x = Age, y = Attractiveness)) +
   geom_boxplot(aes(group = Age))

# Make your own: 




# ... or even just points
ggplot(data, aes(x = Age, y = Cortisol)) +
   geom_point()

# Homework ----------------------------------------------------------
# 1. Make a histogram of the Cortisol column. What bins or binwidth
#    argument do you like best? 


# 2. Calculate the median value of the AntiHBS, Cortisol, Fat, and 
#    Attractiveness columns, grouped by age. Make bar graphs for 
#    each. Then make box and whisker plots of each (you'll need to 
#    use the data frame from before you calculated the medians). 
#    Which do you like better? 


# 3. The goal of their study was to predict facial attractiveness
#    from immune parameters. Make some scatter plots (i.e. 
#    Attractiveness on the y-axis, one of the other variables on the
#    x-axis, and the data shown with points). Do any of the variables
#    seem to correlate with attractiveness?

