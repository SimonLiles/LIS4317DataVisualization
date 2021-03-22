#Simon Liles
#3/21/2021
#LIS 4317
#Mod 10

#Load necessary libraries
library(ggplot2)
library(ggfortify)

#Load the data
jj_earning <- JohnsonJohnson

#Plot the data
autoplot(jj_earning)

autoplot(jj_earning, ts.geom = "ribbon", fill = "darkblue")

autoplot(stl(jj_earning, s.window = "periodic"), ts.geom = "ribbon", fill = "darkblue")

#Decompose the time series
jj_earning_decomp <- decompose(jj_earning)

autoplot(jj_earning_decomp$seasonal, ts.geom = "ribbon", fill = "darkblue")

autoplot(jj_earning_decomp$trend, ts.geom = "ribbon", fill = "darkblue")

autoplot(jj_earning_decomp$random, ts.geom = "ribbon", fill = "darkblue")




