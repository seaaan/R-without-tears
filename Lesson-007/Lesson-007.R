# Lesson 7: Data shape

# Background information -------------------------------------------------------

# Data comes in different shapes: 
# - Flowjo output, where each column has information about a cell type
# - Plate reader output, where the data is shaped like a plate
# - Other instrument output, seemingly completely random and without reason

# Why does it matter what shape your data is in? 
# As an example, we'll look at an experiment where we used several treatments on
# a bunch of samples and then measured the number of cells of a variety of types
# in each sample. 
# There are two main shapes this data can take, wide and long:  
# - Wide: This is how FlowJo makes tables. There is one column indicating what 
#         the sample is, one for what the treatment is, and then an individual 
#         column for each cell type containing the counts of that cell type. 
#         There will be one row per sample and treatment.
#
#         Sample     Treatment      TCells   Macrophages Neutrophils
#         A          Ctrl           30029    94832       120942
#         A          Lightning      21       74          12
#         A          Incubator      30492    89023       105293
#         B          Ctrl           90284    150942      250742
#         ...
#
# - Long: Long data has a single column per variable. In our example, this means
#         that we would have the same two columns for the sample and treatment.
#         Then we would have a column called "CellType" and a column called 
#         "Counts". This means that there will be multiple rows for each sample
#         and treatment, one for each cell type. 
#
#         Sample     Treatment      CellType    Counts
#         A          Ctrl           TCells      30029
#         A          Ctrl           Macrophages 94832
#         A          Ctrl           Neutrophils 120942
#         A          Lightning      TCells      21
#         ...

# Comparison: 
# - Wide: Sometimes easier to look at with your eyeballs, but side scrolling 
#         sucks and we don't have a way to refer to "cell type" if we want to 
#         do some kind of operation on each possible type (T, macro, neutro...).
#         Instead, we have to do it separately for each column. 

# - Long: Not easy easy to look at with eyeballs, but there are lots of ways, 
#         probably better than just looking, to get summary information about 
#         data. For example, to know all the possible values (cell types) you 
#         could group_by(CellType) and then use summarise() or you could 
#         filter(CellType == "whatever").

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



# Let's look at ?gather. Oh brother. 

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

# Read in the file and look at it. 




# Now reshape the data into tidy form by using "gather"




# Now practice your ggplotting by making a plot to get an overview of the data




# Try making a ggplot of the untidy data. What is easier and what is harder?





# Untidying your data -----------------------------------------------------
# Examples
# spread(data, key = CellType, value = Counts)

# Try to convert your tidied tb data back into its initial form





# Homework --------------------------------------------------------------------

# 1. Read this article: http://vita.had.co.nz/papers/tidy-data.pdf

