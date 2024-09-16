# load required packages ------------------------------------------------------
library(tidyverse) # data manipulation
library(progress)  # progress bars 

# source custom functions 
source('./R/functions/process_spectra.R')
source('./R/functions/calculate_FTIR_ratio.R')
# process each spectra --------------------------------------------------------
# set up a progress bar
pb <- progress_bar$new(total = length(list.files(path = './data/new_spectra/')))

# get a list of the files and process
spectra <- list.files(path = './data/new_spectra/',
                      full.names = TRUE) |>
  map(process_spectra) |>
  reduce(rbind) |>
  write_csv(file = './results/processed_new_spectra.csv')

# add catalog numbers to each file
spectra <- read_csv(file  = './results/processed_new_spectra.csv') |> 
  mutate(catalog_number = as.character(catalog_number))

# read in the metadata
metadata <- read_csv(file = './data/metadata/new_metadata.csv') |> 
  mutate(catalog_number = as.character(catalog_number))

# calculate FTIR ratio's
ratio <- spectra %>% 
  group_by(file_name) %>% 
  do(calculate_FTIR_ratio(.)) %>% 
  ungroup() |> 
  full_join(metadata) |>
  write_csv(file = './results/new_ftir_ratios.csv')

