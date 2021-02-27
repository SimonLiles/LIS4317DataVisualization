#Load in Libraries
library(ggplot2)
library(tidyr)
library(dplyr)

my_iris <- iris

#Width by Length for Petal and Sepal, Seperated by Species
#Mutate data set for 4 columns, Length, Width, Species, Petal or Sepal
new_iris <- pivot_longer(my_iris, c(Sepal.Length, Petal.Length, Sepal.Width, Petal.Width),
                         names_to = c("Type", ".value", ".value"), 
                         names_pattern = "(.....)(.*)(.*)")

#Make the plot
ggplot(new_iris, aes(.Length, .Width, color = Species)) +
  geom_point(position = "jitter") +
  facet_grid(Type ~ Species) + 
  theme(legend.position = "none") + 
  xlab("Length in cm") + 
  ylab("Width in cm")

#Same plots, except all have different scales
ggplot(new_iris, aes(.Length, .Width, color = Species)) +
  geom_point(position = "jitter") +
  facet_wrap(Type ~ Species, scales = "free") + 
  theme(legend.position = "none") + 
  xlab("Length in cm") + 
  ylab("Width in cm")
