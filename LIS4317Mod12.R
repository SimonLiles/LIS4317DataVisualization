#Simon Liles
#4/2/2021
#LIS 4317
#Mod 12

library(GGally)
library(network) 
library(sna) 
library(ggplot2)

#Build a matrix, 0 = no connection, higher count, stronger connection
my_net_matrix <- matrix(round(runif(676, min = 0, max = 0.53)), nrow = 26)

#Convert to Network
my_net <- network(my_net_matrix, directed = TRUE)

#Give names to nodes
network.vertex.names(my_net) = letters[1:26]

#Plot with ggnet2
ggnet2(my_net, label = TRUE)

