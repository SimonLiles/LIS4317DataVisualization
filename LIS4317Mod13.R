#Simon Liles
#4/9/2021
#LIS 4317
#Mod 13

#Install protein8k
devtools::install_github("SimonLiles/protein8k", build_vignettes = TRUE)

#Load the library
library(protein8k)

#Use the p53_tetramerization dataset that comes with the package
summary(p53_tetramerization)
str(p53_tetramerization)

#Make a basic plot
plot3D(p53_tetramerization, type = "p", groups = residue_name, 
       screen = list(z = 30, x = -60, y = 0))

#Make an animated plot
plot3D(p53_tetramerization, type = "p", groups = residue_name, animated = TRUE)

#Save the plot to an R object
plot_animated <- plot3D(p53_tetramerization, type = "p", groups = residue_name, animated = TRUE)

#Save animated plot to a .gif
require(magick)
image_write(plot_animated, path = "LIS4317Mod13Animation.gif")
