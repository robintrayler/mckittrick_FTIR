# load required packages ------------------------------------------------------
library(tidyverse) # data manipulation

# source functions 
source('./R/functions/calculate_FTIR_ratio.R')

# load the data ---------------------------------------------------------------
spectra <- read_csv(file  = './results/processed_spectra.csv') |> 
  mutate(catalog_number = as.character(catalog_number))

training <- read_csv(file = './data/metadata/training_metadata.csv') |> 
  mutate(catalog_number = as.character(catalog_number))

testing <- read_csv(file = './data/metadata/testing_metadata.csv') |> 
  mutate(catalog_number = as.character(catalog_number))

validation <- read_csv(file = './data/metadata/validation_metadata.csv') |> 
  mutate(catalog_number = as.character(catalog_number))

metadata <- rbind(training, testing, validation)

# calculate FTIR ratios' ------------------------------------------------------
ratio <- spectra %>% 
  group_by(file_name) %>% 
  do(calculate_FTIR_ratio(.)) %>% 
  ungroup() |> 
  full_join(metadata) |>
  write_csv(file = './results/ftir_ratios.csv')

