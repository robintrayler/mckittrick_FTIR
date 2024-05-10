# load required packages ------------------------------------------------------
library(tidyverse) # data manipulation

# source functions 
source('./R/functions/calculate_FTIR_ratio.R')

# load the data ---------------------------------------------------------------
spectra <- read_csv(file  = './data/processed_spectra.csv') |> 
  mutate(catalog_number = as.character(catalog_number))


metadata <- read_csv(file = './data/metadata.csv') |> 
  mutate(catalog_number = as.character(catalog_number))

# calculate FTIR ratios' ------------------------------------------------------
ratio <- spectra %>% 
  group_by(file_name) %>% 
  do(calculate_FTIR_ratio(.)) %>% 
  ungroup() |> 
  full_join(metadata) |>
  write_csv(file = './data/ftir_ratios.csv')