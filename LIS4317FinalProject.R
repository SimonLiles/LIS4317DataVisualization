#Simon Liles
#4/24/2021
#LIS 4317
#Final Project

#Install the latest version of protein8k
devtools::install_github("SimonLiles/protein8k", build_vignettes = TRUE)

#Load necessary libraries
library(protein8k)

#String representing location of data in relation to Working Directory
jsonListName <- "data_report.jsonl"

#Get all records from the .jsonl file
#May take a little while to read and parse all 40k records
report_df <- report_as_dataframe(fromJSONL(jsonListName))

#Load libraries
library(ggraph)
library(igraph)
library(tidyverse)


###Remove NA from data frame
report_clean_df <- report_df
report_clean_df$geo_Location <- gsub(":.*", "", report_df$geo_Location)
report_clean_df$isolate_source <- as.character(report_clean_df$isolate_source)
report_clean_df$world <- "world"

#Make list of nodes with frequencies for sizes
nodes <- report_clean_df %>%
  pivot_longer(cols = c(world, isolate_source, geo_Region, geo_Location), 
               values_to = "label") %>%
  count(label, name = "size") %>% 
  rowid_to_column("id")

#Make the edge list

#First create a list with an explicit hierarchy
hierarchy_list <- list()

for(record in 1:nrow(report_clean_df)) {
  branch <- c(report_clean_df$world[record],
              report_clean_df$isolate_source[record],
              report_clean_df$geo_Region[record], 
              report_clean_df$geo_Location[record])
  hierarchy_list[[record]] <- branch
}

# create edge list (from in first column / to in the second)
d <- do.call(rbind, hierarchy_list)
edges <- rbind(d[,1:2], d[,2:3], d[,3:4])

edges <- as.data.frame(edges)

edges <- edges %>%
  left_join(nodes, by = c("V1" = "label")) %>%
  rename(from = id)

edges <- edges %>%
  left_join(nodes, by = c("V2" = "label")) %>%
  rename(to = id)

#Clean up edges dataframe
edges <- select(edges, from, to)

edges <- group_by(edges, from, to) %>%
  count(name = "weights") %>%
  ungroup()

nodes$size[nodes$label == "world"] <- 1

nodes$size <- log10(nodes$size)

#Making the network
loc_graph <- graph_from_data_frame(edges, vertices = nodes, directed = TRUE)

#Make the plot
ggraph(loc_graph, 'partition', circular = TRUE) + 
  geom_node_arc_bar(aes(fill = size, color = depth), size = 0.25) +
  geom_node_text(aes(label = label), size = 2.5) + 
  theme_void() +
  theme(legend.position = "right") + 
  scale_color_continuous(guide = "none") + 
  scale_fill_viridis_c(direction = 1)

ggraph(loc_graph, layout = "circlepack", weight = size) + 
  geom_node_circle(aes(fill = depth)) +
  geom_node_text(aes(label = label, size = size)) + 
  theme_void() +
  theme(legend.position = "FALSE") + 
  scale_fill_distiller(palette = "RdPu")