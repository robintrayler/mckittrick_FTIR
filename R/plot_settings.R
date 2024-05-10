# plot settings
library(tidyverse)
theme_custom <- theme_minimal() + 
  theme(axis.title = element_text(size = 10, 
                                  color = 'black'),
        axis.text = element_text(size = 10, 
                                 color = 'black'),
        panel.border = element_rect(fill = NA, 
                                    color = 'black',
                                    size = 1),
        axis.ticks = element_line(lineend = "round", 
                                  color = 'black'),
        panel.grid.minor = element_blank(), 
        panel.grid.major = element_blank()) 

theme_set(theme_custom)
