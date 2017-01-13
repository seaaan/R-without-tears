# Lesson 00X - Fine-tuning your plots

# In this lesson, we'll continue to explore ggplot. 
library(ggplot2)
library(dplyr)

# Zika again 
zika <- read.csv("Lesson-001/data/zika.csv")

# Data preliminaries
# Last time, we used scale_y_log10() to transform viral load to log10 and 
# make it easier to view. To keep from running that code all the time, we
# can just mutate the viral load data to be in log10. And, like last time, 
# we convert the animal IDs to text so ggplot doesn't think they're numbers.
zika <- mutate(zika, ViralLoad = log10(ViralLoad + 1), 
   AnimalId = as.character(AnimalId))

# All the geoms ----------------------------------------------------------------
# ggplot2 can make a huge number of different kinds of graphs.

# Histograms
ggplot(zika, aes(x = DaySinceInfection)) + geom_histogram()
ggplot(zika, aes(x = DaySinceInfection)) + geom_density()
ggplot(zika, aes(x = DaySinceInfection, color = SampleSource)) + geom_density()

# Categorical plots
# Most of the viral load measurements are at 0:
ggplot(zika, aes(x = ViralLoad)) + geom_histogram()

# To better show how these next geoms work, we'll remove all of the 0 viral 
# loads so the data won't be pulled down to the axis. 
non_zero <- zika %>% 
   filter(ViralLoad > 0)
ggplot(non_zero, aes(x = SampleSource, y = ViralLoad)) + geom_boxplot()
ggplot(non_zero, aes(x = SampleSource, y = ViralLoad)) + geom_violin()
ggplot(non_zero, aes(x = SampleSource, y = ViralLoad)) + 
   geom_jitter(width = 0.1)
ggplot(non_zero, aes(x = SampleSource, y = ViralLoad)) + geom_boxplot() + 
   geom_jitter(width = 0.1)

# Plots with two continuous axes
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad)) + geom_point() + 
   geom_smooth() 
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad)) + geom_point() + 
   geom_line() 
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad)) + geom_hex()
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad)) + geom_bin2d()
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad)) + geom_density2d()

# Heatmap
ggplot(zika, aes(y = SampleSource, x = DaySinceInfection, fill = ViralLoad)) + 
   geom_tile()

# Example: Make a histogram of viral load, but color the bars by sample type. 
# Note: use "fill" not "color" in this case.




# Example: Make a box-and-whisker plot showing the viral loads for each animal.
# I.e. three boxes-and-whiskers, one per animal. 




# Example: Make a heatmap showing days on one axis, animal IDs on the other 
# axis, and viral load with color (called "fill"). 



# Line graphs are the worst ----------------------------------------------------
# ggplot doesn't always "know" which points go together and should be
# connected when you add a line. For example, below, the data from all
# three animals get connected: 
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad)) + 
   geom_point() + 
   geom_line() + 
   facet_wrap(~ SampleSource)

# There are several ways to address this. You can map AnimalId to an
# aesthetic, like shape or color. 
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad, color = AnimalId)) + 
   geom_point() + 
   geom_line() + 
   facet_wrap(~ SampleSource)

# If you don't want to change the appearance of graph, you can map AnimalId
# to an aesthetic called "group"
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad, group = AnimalId)) + 
   geom_point() + 
   geom_line() + 
   facet_wrap(~ SampleSource)

# It's also possible to have multiple calls to the aes() function, with one
# in ggplot() and others in the geoms. For example, 
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad, color = SampleSource)) + 
   geom_point(aes(size = DaySinceInfection)) + 
   geom_line(aes(group = AnimalId)) + 
   facet_wrap(~ SampleSource)

# In this way, you can control the appearance of one type of geom separately
# from another. What you put in the aes() inside of ggplot() applies to the 
# whole graph. What you put in the aes inside of a certain geom() only applies
# to that specific geom. 

# Example: 
# Make a plot showing points and box-and-whisker plots with viral load on the 
# y-axis and sample type on the x-axis. Color the points by which animal it was
# but don't color the box plots. Make a subplot for each day. (What happens if
# you color both the points and the boxplots?)





# ------------------------------------------------------------------------------
# Fine-tuning and exporting plots
# ------------------------------------------------------------------------------
# Saving plots in variables ----------------------------------------------------
# Instead of immediately displaying a plot, it's possible to save it in a 
# variable and then make further modifications to it. Like creating any
# variable, you use the <- operator to do this.
p <- ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad, color = AnimalId)) + 
   geom_point() +  
   geom_line() + 
   facet_wrap(~ SampleSource) 
p

# Axis limits ------------------------------------------------------------------
# You can specify the axis limits you want by using ylim() and xlim()
p + xlim(c(0, 10))
p + ylim(c(3, 6))
p + ylim(c(-5, 15))

# Example: Show p with only days 1-5 and viral loads between 2 and 4 




# Axis labels, titles ----------------------------------------------------------
# By default, the axis labels are the names of the variables they represent. 
# Often you want to change them, which can be done with xlab() and ylab()
p + xlab("Days post infection")
p + ylab("Viral load (log10-transformed)")

# Titles are with ggtitle()
p + ggtitle("Zika viral loads by tissue")

# You can control multiple labels using the labs() function. 
p + labs(x = "", y = "", title = "", color = "Animal")

# Rename both axes, give the plot a title, and rename the color legend



# Customizing the appearance of your plots -------------------------------------
# ggplot2 comes with a bunch of different themes you can use to change the look
# of your plots. These are called theme_something(). 

p + theme_classic()
p + theme_minimal()
p + theme_bw()
p + theme_dark()
p + theme_light()
p + theme_linedraw()

# You can get more themes by installing the ggthemes package: 
# https://cran.r-project.org/web/packages/ggthemes/vignettes/ggthemes.html

# It's also possible to customize literally every aspect of a plot. 
# Reference: http://docs.ggplot2.org/current/theme.html
p 
p + theme(strip.background = element_rect(fill = "hotpink"))
p + theme(axis.text.y = element_text(size = 20))

# Example: Change the color of the words in the boxes labeling the sample types.
# Hint: the boxes are called "strips"



# Colors -----------------------------------------------------------------------
# Sometimes, you don't want to use the default colors. You can control 
# these with scale_color_xxx() functions. 

# http://colorbrewer2.org/

# Qualitative - for identifying unique treatments or other factors 
p + scale_color_brewer(type = "qual", palette = "Set1")

# Sequential - for showing data that goes in a single direction
ggplot(zika, aes(x = DaySinceInfection, y = AnimalId, fill = ViralLoad)) + 
   geom_tile() + facet_wrap(~ SampleSource) + 
   scale_fill_brewer(type = "seq", palette = "PuRd")

# Need to use scale_fill_distiller for continuous, rather than discrete,
# variables
ggplot(zika, aes(x = DaySinceInfection, y = AnimalId, fill = ViralLoad)) + 
   geom_tile() + facet_wrap(~ SampleSource) + 
   scale_fill_distiller(type = "seq", palette = "PuBu")

# Diverging - for showing data that goes above and below 0
new_zika <- zika %>% 
   mutate(RelativeToThree = ViralLoad - 3)

ggplot(new_zika, aes(x = DaySinceInfection, y = RelativeToThree, 
      color = RelativeToThree)) + 
   geom_point() + geom_line(aes(group = AnimalId)) + 
   facet_wrap(~ SampleSource) + 
   scale_color_distiller(type = "div", palette = "RdYlBu") + 
   # add horizontal line at 0
   geom_hline(yintercept = 0)

# Example: 
# Make a plot of jittered points with viral load on the y-axis and animal
# id on the x-axis. Color the points by sample type. Apply an appropriate 
# color brewer color palette. 





# There are many other scale_color/fill_xxx functions, including 
# scale_color_manual where you define each color to be used.

# Saving figures ---------------------------------------------------------------
# ggsave saves the last plot you made
ggsave(filename = "prettyplot.png", width = 4, height = 3, 
   units = "in", dpi = 600)

# How it works: 
# filename = "prettyplot.png" 
#     This specifies the file name and type of file. The files can be:
#        .png, .tiff, .jpeg = image
#        .pdf = pdf (duh)
#        .eps = Illustrator file
#
# width = 4, height = 3, units = "in"
#     This specifies how big to make the image and in what units. Width and
#     height are always numbers, while units can be "in", "cm" or "mm"
# 
# dpi = 600
#     This specifies the resolution of the image, the number of dots per inch.
#     Higher values look nicer, but cause bigger file sizes. 

# Example: Create a pdf of your last plot on normal letter size paper.




# Homework ---------------------------------------------------------------------

# 1. Read http://r4ds.had.co.nz/data-visualisation.html

# 2. Make a histogram of the number of measurements at each level of 
#    viral load, with sub-plots for each animal. 




# 3. Make boxplots of viral load, with a different box for each animal. 





# 4. Now add jittered points on top of the box plots and color the points
#    differently for each type of sample. 





# 5. Now add a descriptive title and label the x- and y-axes better.





# 6. Now change the theme of the graph to something else and set the colors
#    using a color brewer palette. 




# 7. Finally, save a png of your graph. Play around with different sizes
#    until you get one that looks good.



