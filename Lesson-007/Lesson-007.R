# Lesson 7: Data shape

# Background information -------------------------------------------------------

# Data comes in different shapes: 
# - Flowjo output, where each column has information about a cell type
# - Plate reader output, where the data is shaped like a plate
# - Other instrument output, seemingly completely random and without reason

# Main data shapes: wide and long 
# As an example, we'll look at an experiment where we used several treatments on
# a bunch of samples and then measured the number of T cells, macrophages, and
# neutrophils in each sample. 
#
# There are two main shapes this data can take, wide and long:  
# - Wide: This is how FlowJo makes tables. There is one column indicating what 
#         the sample is, one for what the treatment is, and then one column of 
#         counts for each cell. There is one row per combination of sample and 
#         treatment.
#
#         Sample     Treatment      TCells   Macrophages Neutrophils
#         A          Ctrl           30029    94832       120942
#         A          Lightning      21       74          12
#         A          Incubator      30492    89023       105293
#         B          Ctrl           90284    150942      250742
#         ...
#
# - Long: Long data has a single column per variable. In our example, this means
#         that we have the same two columns for the sample and treatment. Then
#         we have a column called "CellType" and a column called "Counts". 
#         This means that there are multiple rows for each sample and treatment,
#         Specifically, one for each cell type. 
#
#         Sample     Treatment      CellType    Counts
#         A          Ctrl           TCells      30029
#         A          Ctrl           Macrophages 94832
#         A          Ctrl           Neutrophils 120942
#         A          Lightning      TCells      21
#         ...

# Comparison: 
# - Wide: Can be easier to look at and more convenient for data entry. It's 
#         harder to perform an operation on all of the count data (such as doing
#         a log10-transformation). Instead, we have to do it separately for each 
#         column. 

# - Long: Not as easy to look at, but much easier to perform operations on. For 
#         example, you can group_by(CellType) and then use summarise().

# Why you should prefer long ---------------------------------------------------
# ggplot2, dplyr, and other related packages (the "tidyverse") expect data to be
# in long ("tidy") form. For example, you tell ggplot2 to vary the color based 
# on the column CellType, rather than telling it to make the values in the 
# TCells column pink, the values in the Macrophages column blue, .... Being able
# to use these packages is the biggest reason to use long form data.
# 
# OMG my data is in the wrong shape, curses be upon you flowjo!! What do I do?

# Tidying your data (Wide to long) --------------------------------------------- 
# To convert your data from wide to long, you can use gather() from the tidyr
# package. 

# Do you remember how to install/load a package? Install and load tidyr.



# Let's look at ?gather. Oh brother. key? value???

#  key         value
# ----------------------------------
#  word        dictionary definition
#  name        number in phone book
#  CellType    Counts

# Examples: 

# Select the columns you want to be gathered
# gather(data, key = CellType, value = Count, TCells, Macrophages, Neutrophils)

# Select the columns you DON'T want to be gathered
# gather(data, key = CellType, value = Count, -Sample, -Treatment)

# New data set from http://datadryad.org/resource/doi:10.5061/dryad.g91p3
# Concentrations in pg/mL of 12 cytokines from people with tubercular 
# lymphadenitis (lymph node inflammation cause by TB infection), pulmonary
# tuberculosis, or no tuberculosis

# The file is in "Lesson-007/data/tb.csv"

# Read in the file and look at it. What shape is it in?




# Now reshape the data into tidy form by using "gather"




# Now practice your ggplotting by making a plot to get an overview of the data




# Try making a ggplot of the untidy data. What is easier and what is harder?





# Untidying your data -----------------------------------------------------
# Sometimes wide-shaped data is necessary. For example, if you want to determine
# the correlation of two different levels of one variable (number of T cells 
# vs number of neutrophils), you need a column for each. 

# To convert from long form to wide form, tidyr has the function spread(), which
# does the exact opposite of gather(). 

# Examples
# spread(data, key = CellType, value = Counts)

# Try to convert your tidied tb data back into its initial form





# Homework --------------------------------------------------------------------

# 1. Read this article: http://vita.had.co.nz/papers/tidy-data.pdf




# 2. The zika data is tidy. Load the data and convert it to wide form so that 
#    you have a column for each sample type containing its copies vRNA. 




# 3. Notice that many of the values are NA (missing). This happens when there 
#    isn't a value for all of the sample types at the same time. For example,
#    many more blood plasma measurements were taken than measurements of the
#    other sample types. In this case, it's also in part because there are two
#    different types of units: copies vRNA / ml and copies vRNA / sample, as 
#    shown in the Units column. Try removing that column from the tidy data
#    and then converting it to wide form again and see how it changes. 




# 4. Load some of your own data. Determine whether it is wide or long/tidy. Now
#    convert it to the other shape. Make some plots of the data in each form to
#    see what's easier and harder. 
#    If you're having trouble loading your data, do this: open the file in 
#    Excel, save as CSV, and put the CSV file in Lesson-007/data. Now you should
#    be able to do read.csv("Lesson-007/data/your-file-name.csv"). If that 
#    doesn't work, try running read.csv(file.choose()), which will pop up a 
#    window letting you choose the file to load. Or try File > Import dataset.



