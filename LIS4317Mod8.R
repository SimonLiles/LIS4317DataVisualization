#Load in Libraries
library(ggplot2)
library(corrgram)
library(reshape2)
library(tidyr)
library(dplyr)

#Load stackloss data set
my_stack <- stackloss

#Using corrgram
corrgram(my_stack)
corrgram(my_stack, upper.panel = panel.cor, lower.panel = panel.pie)

#Using qplot
qplot(x = Var1, y = Var2, data = melt(cor(my_stack)), fill = value, geom = "tile")

#Same thing using ggplot
ggplot(melt(cor(my_stack)), aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() + 
  labs(title = "Correlation of Variables involved in Converting Ammonia to Nitric Acid",
       x = "", y = "")

#Plot the data with points, vary size and color
ggplot(my_stack, aes(x = Air.Flow, y = stack.loss, color = Acid.Conc., size = Water.Temp)) + 
  geom_point(position = "jitter")

##Mutate data set for 3 columns, stack.loss, name, value
new_stack <- pivot_longer(my_stack, c(Air.Flow, Water.Temp, Acid.Conc.))
#Plot the values by stack.loss in 3 seperate facets
ggplot(new_stack, aes(value, stack.loss, color = name)) +
  geom_point(position = "jitter") +
  stat_smooth(method = "lm", col = "red") + 
  facet_wrap(~ name, scales = "free") + 
  theme(legend.position = "none")


