# Lesson XXX: Translating different ways of doing the same thing
library(dplyr)

# We're going to use the Zika virus data again
# Load the data and store it in a variable called "zika": 


zika[row, column]

# filter -----------------------------------------------------------------------
filter(zika, SampleSource == "Blood plasma")
zika[zika$SampleSource == "Blood plasma" , ]

filter(zika, SampleSource == "Urine", ViralLoad > 0)
zika[zika$SampleSource == "Urine" & zika$ViralLoad > 0, ]

# practice: blood on day 1, blood or urine


# select -----------------------------------------------------------------------
select(zika, Date, DaySinceInfection)
zika[ , c("Date", "DaySinceInfection")]

select(zika, -Units)
zika[ , colnames(zika) != "Units"]

# practice: select other columns, unselect two columns


# mutate -----------------------------------------------------------------------
mutate(zika, LogViralLoad = log10(ViralLoad))
zika$LogViralLoad <- log10(zika$ViralLoad)



# group_by and summarize -------------------------------------------------------
zika %>% group_by(SampleSource) %>% summarise(mean = mean(ViralLoad))
by(data = zika$ViralLoad, INDICES = zika$SampleSource, FUN = mean)
aggregate(x = list(Mean = zika$ViralLoad), 
   by = list(SampleSource = zika$SampleSource), FUN = mean)

zika %>% group_by(SampleSource, AnimalId) %>% summarise(mean = mean(ViralLoad))
aggregate(x = list(Mean = zika$ViralLoad), 
   by = list(SampleSource = zika$SampleSource, Animal = zika$AnimalId), FUN = mean)
by(data = zika$ViralLoad, INDICES = paste(zika$SampleSource, zika$AnimalId), FUN = mean)

# practice: multiple functions, group by multiple columns


# Homework --------------------------------------------------------------------
