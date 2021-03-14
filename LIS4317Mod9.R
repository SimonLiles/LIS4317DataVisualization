# Simon Liles
# 3/13/2021
# LIS4317 Data Visualization
# Module 9

#Load libraries
library(ggplot2)
library(tidyverse)
library(dplyr)

#Load in data set
my_iris <- iris

#Width by Length for Petal and Sepal, Seperated by Species
#Mutate data set for 4 columns, Length, Width, Species, Petal or Sepal
new_iris <- pivot_longer(my_iris, c(Sepal.Length, Petal.Length, Sepal.Width, 
                                    Petal.Width),
                         names_to = c("Type", ".value", ".value"), 
                         names_pattern = "(.....)(.*)(.*)")
#Combine length and width measurements into one column
new_iris <- pivot_longer(new_iris, c(.Length, .Width))
#Combine the variable identification columns
new_iris <- unite(new_iris, col = "Name", Type, name, sep = "")

#Plot data using ggplot
ggplot(my_iris, aes(Sepal.Length, Sepal.Width, 
                    color = Petal.Length, size = Petal.Width)) +
  geom_point() + 
  facet_wrap(~ Species)

#Make a violin/box plot
ggplot(new_iris, aes(x = Name, y = value, fill = Name)) + 
  geom_boxplot(width = 0.15) + 
  geom_violin(alpha = 0.5, scale = "width") + 
  facet_wrap(~ Species) + 
  theme(legend.position = "none", 
        axis.text.x = element_text(angle = 90))


