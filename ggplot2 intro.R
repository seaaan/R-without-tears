library(ggplot2)
library(dplyr)
zika <- read.csv("Lesson-001/data/zika.csv")

# geom_point, geom_line
# aes: shape, size, color, x, y
# facet_wrap, facet_grid

zika <- mutate(zika, AnimalId = as.character(AnimalId))

ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad))

# geom_point, color, shape, size
ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad)) +
   geom_point()

ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad)) +
   geom_point() +
   scale_y_log10()

ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad, 
      color = SampleSource)) +
   geom_point() +
   scale_y_log10()

ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad, 
      color = SampleSource, shape = AnimalId)) +
   geom_point() +
   scale_y_log10()

ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad, 
      color = SampleSource, size = AnimalId)) +
   geom_point() +
   scale_y_log10()

# geom_line

ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad, 
      color = SampleSource, shape = AnimalId)) +
   geom_point() +
   geom_line() +
   scale_y_log10()

# facetting

ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad,
      color = SampleSource, shape = AnimalId)) +
   geom_point() +
   geom_line() +
   scale_y_log10() + 
   facet_wrap(~ SampleSource)

ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad,
      color = AnimalId)) +
   geom_point() +
   geom_line() +
   scale_y_log10() + 
   facet_wrap(~ SampleSource)

ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad,
      color = AnimalId)) +
   geom_point() +
   geom_line() +
   scale_y_log10() + 
   facet_wrap(~ SampleSource, scales = "free_y")

ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad,
      color = SampleSource)) +
   geom_point() +
   geom_line() +
   scale_y_log10() + 
   facet_wrap(~ AnimalId)

ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad, 
      color = SampleSource, shape = AnimalId)) +
   geom_point() +
   scale_y_log10() + 
   facet_wrap(~ DaySinceInfection)

ggplot(zika, aes(x = AnimalId, y = ViralLoad, 
      color = SampleSource, shape = AnimalId)) +
   geom_point() +
   scale_y_log10() + 
   facet_wrap(~ DaySinceInfection)

ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad, 
     color = SampleSource, shape = AnimalId)) +
   geom_point() +
   scale_y_log10() + 
   facet_wrap(~ SampleSource + AnimalId)

ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad, 
      color = SampleSource, shape = AnimalId)) +
   geom_point() +
   scale_y_log10() + 
   facet_grid(SampleSource ~ AnimalId)

ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad)) +
   geom_point() +
   scale_y_log10() + 
   facet_grid(SampleSource ~ AnimalId)

ggplot(zika, aes(x = DaySinceInfection, y = ViralLoad)) +
   geom_point() +
   geom_line() +
   scale_y_log10() + 
   facet_grid(SampleSource ~ AnimalId)
