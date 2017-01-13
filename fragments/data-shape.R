# Lesson 7: Data shape

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
# Wide: Sometimes easier to look at with your eyeballs, but side scrolling sucks and we don't have a way to refer to "cell type" if we want to do some kind of operation on data related to each possible value (T, macro, neutro...) of a certain variable (cell type).
# Long: Not easy easy to look at with eyeballs,  but there are lots of ways, probably better than just looking, to get summary information about the data. For example, to know all the possible values (cell types) you could say levels(Cell.Type), or do a summary by cell type, or filter by Cell.Type == "whatever".
# Foreshadowing for ggplot: It is nice to be able to tell a plot function: vary the color/shape/facetting by "cell type", instead of saying "make T cells blue, Macros red, Neutros pink, etc.
# 
# OMG my data is in the wrong shape, curses be upon you flowjo!! What do I do?
# This is usually when it is wide and you want long. In this case you can melt it into the right shape using the melt() function in the reshape2 package
# Do you remember how to install/load a package? Do it.
# Let's look at ?melt  Obrudder, click on the version for data frames
# 
# This is a good tutorial: http://seananderson.ca/2013/10/19/reshape.html
# Or maybe this one: http://www.cookbook-r.com/Manipulating_data/Converting_data_between_wide_and_long_format/
# There are a lot.
# Once you figure it out, write notes for yourself in a way that makes sense for you. Here is what I wrote for myself:
# 
# melt:
# 
# id.vars= is non-measured sample information like brush#, method, sample name
# 
# variable.name = the name of the column holding the different things you measured, like cell type. Before melting there is one column for each.
# 
# value.names = the thing you measured, like count
# 
# measure.vars = the values that you measured. Don't really need to use this if you have numbers for the values. use it if the values that you want to melt are strings. 
# 
# the arguments need to be in quotes!!
# 
# EXAMPLE
# melted<-melt(summaryOnly,
# id.vars=c("Probe.ID","TargetID","ENTREZ_GENE_ID"),
# variable.name="day.dose",value.name="UpDownFalse")
# 
# EXAMPLE using measure.vars
# 
# 
# original df: "female"
# 
# Female Female.1 Female.2
# 1     Mary     Lisa Jennifer
# 2    Linda     Mary      Amy
# 3 Patricia    Susan  Melissa
# 4    Susan    Karen Michelle
# 5  Deborah Kimberly Kimberly
# 6  Barbara Patricia     Lisa
# 
# want all the names in one column
# 
# meltFemale<-melt(female, measure.vars=c("Female","Female.1","Female.2")
# 
# variable    value
# 1   Female     Mary
# 2   Female    Linda
# 3   Female Patricia
# 4   Female    Susan
# 5   Female  Deborah
# 6   Female  Barbara
# 
# further down "variable" is Female.1 or Female.2




# Homework --------------------------------------------------------------------

# 1. Read this article: http://vita.had.co.nz/papers/tidy-data.pdf

