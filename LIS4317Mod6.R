#Simon Liles
#2/19/2021
#LIS 4317

# Load necessary libraries
library(ggplot2)

#Save data set
myCars <- mtcars

#Explore the data set
str(myCars)

#Plot 1: wt vs hp vs cyl vs qsec
ggplot(myCars, aes(x = hp/wt, y = qsec, color = as.factor(cyl), size = mpg)) +
  geom_point()
