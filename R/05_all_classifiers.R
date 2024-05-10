# load required libraries -----------------------------------------------------
library(tidyverse)
source('./R/plot_settings.R')

# load the data ---------------------------------------------------------------
taphonomy <- read.csv(file = './data/training_taphonomy.csv') |> 
  mutate(catalog_number = as.character(catalog_number)) 

ftir      <- read.csv(file = './data/ftir_ratios.csv') |> 
  filter(is.finite(collagen_present)) |> 
  mutate(catalog_number = as.character(catalog_number)) 

data <- taphonomy |> 
  select(catalog_number, 
         weathering_score, 
         tar_penetration, 
         matrix_present, 
         glue_present, 
         plaster_present, 
         prep_marks,
         interior_tar,
         breakage,
         age) |> 
  full_join(ftir, 
            by = c('catalog_number')) |> 
  select(collagen_present,
         WAMPI,
         PCI, 
         API, 
         BPI,
         LPI,
         weathering_score) |> 
  mutate(collagen_present = as.numeric(collagen_present)) %>%
  pivot_longer(cols = colnames(.)[-1],
               names_to = 'parameter') |> 
  mutate(parameter = factor(parameter,
                            levels = c('collagen_present',
                            'WAMPI',
                            'BPI',
                            'API',
                            'LPI',
                            'PCI', 
                            'weathering_score')))


weathering_fit <-  taphonomy |> 
  glm(as.numeric(collagen_present) ~  weathering_score, 
      family = 'binomial', data = _)

data |> 
  ggplot(mapping = aes(x = value,
                       y = collagen_present,
                       color = factor(collagen_present))) + 
  geom_jitter(show.legend = FALSE,
              height = 0.01,
              alpha = 0.75) + 
  facet_wrap(.~parameter,
             scales = 'free_x') + 
  stat_smooth(method="glm", 
              mapping = aes(group = 1), 
              color="darkgrey", 
              se=FALSE,
              method.args = list(family = binomial),
              lineend = "round",
              show.legend = FALSE) + 
  scale_color_brewer(palette = 'Set1')
  



taphonomy |> 
  ggplot(mapping = aes(x = weathering_score, 
                       y = as.numeric(collagen_present),
                       color = factor(collagen_present))) + 
  geom_jitter(height = 0.05,
              width = 0.01,
              show.legend = FALSE,
              size = 4,
              alpha = 0.75) + 
  scale_color_brewer(palette = 'Set1') + 
  stat_smooth(method="glm", 
              mapping = aes(group = 1), 
              color="darkgrey", 
              se=FALSE,
              method.args = list(family = binomial),
              lineend = "round",
              show.legend = FALSE) + 
  xlab('Weathering Score') + 
  ylab('Perservation \n Probability')




