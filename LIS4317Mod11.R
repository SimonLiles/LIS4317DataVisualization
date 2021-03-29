#Simon Liles
#3/28/2021
#LIS4317 Mod 11

#Load data
my_cars <- mtcars

#Load neccessary packages
library(ggplot2)
library(ggExtra)
library(ggthemes)

#Make plot
#Marginal Histogram Scatterplot
p <- ggplot(my_cars, aes(hp, mpg)) + 
  geom_point(position = "jitter") + 
  theme_tufte(ticks = FALSE)
ggMarginal(p, type = "density")

