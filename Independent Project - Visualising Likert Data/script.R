# Inspired by McCall Pitcher's teaching materials at:
# https://github.com/mccallpitcher/ggplot2-for-survey-data/tree/main

# load packages
library(tidyverse) 
library(scales)  

# define function to generate graph
generate_graph <- function(results, one_label, five_label, file_name, pic_height) {
  # counts and percentages
  counts_perc <- results |> 
    count(statement, response_num) |> 
    group_by(statement) |> 
    mutate(total = sum(n), 
           percent = n / total) 
  
  # medians
  medians <- results |>    
    group_by(statement) |>    
    summarize(med = median(response_num)) # calculate median by statement
  
  # order medians data frame
  medians <- medians |> 
    mutate(statement = fct_reorder(statement, med))
  
  # order results data frame to match
  results <- results |> 
    mutate(statement = factor(statement, 
                              levels = levels(medians$statement)))
  
  # Get the unique values of x and y variables 
  x_values <- 1:5 
  y_values <- unique(results$statement)  
  
  # Create a complete grid with all possible combinations 
  full_grid <- expand.grid(   
    response_num = x_values,   
    statement = y_values 
  )
  
  ggplot() +  
    geom_tile(full_grid,
              mapping = aes(x = response_num, 
                            y = statement),
              fill = NA,                                    
              color = "#dddddd",                              
              height = .8, 
              linewidth = .5) +
    geom_jitter(results, 
                mapping = aes(x = response_num, 
                              y = statement,
                              fill = "One respondent"),
                size = 2,
                height = .25,
                width = .25, 
                alpha = .5, 
                color = "#84B6E4") + 
    geom_point(medians,
               mapping = aes(x = med, 
                             y = statement,
                             color = "Median response"),
               shape = 108, 
               size = 11.5) +
    guides(color = guide_legend(override.aes = list(size = 6))) +
    labs(x = NULL, y = NULL, color = NULL, fill = NULL) +
    scale_color_manual(values = "#3e6488") +
    scale_x_continuous(expand = c(0,0), 
                       breaks = 1:5,                      
                       labels = c(paste("1\n", one_label, sep = ""),
                                  "2",
                                  "3",
                                  "4",
                                  paste("5\n", five_label, sep=""))) + 
    theme_minimal() +   
    theme(panel.grid = element_blank(),
          axis.text.x = element_text(size = 10, lineheight = 1.1),
          axis.text.y = element_blank(), 
          legend.text = element_text(size = 10),
          legend.spacing.y = unit(0.15, "cm"))

  # save plot to file 
  ggsave(file_name, 
         width = 8, height = pic_height,
         dpi = 500, bg = "white")
}

# import data and generate graph(s)
generate_graph(read_csv("likert_responses.csv"), "", "", "graph.png", 4)
