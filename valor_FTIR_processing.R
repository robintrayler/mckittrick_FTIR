# load required packages ------------------------------------------------------
library(tidyverse) # data manipulation
library(progress)  # progress bars 

# source custom functions 
source('./R/functions/process_spectra.R')
source('./R/functions/calculate_FTIR_ratio.R')
# process each spectra --------------------------------------------------------
# set up a progress bar
pb <- progress_bar$new(total = length(list.files(path = './data/valor_spectra/')))

# get a list of the files and process
spectra <- list.files(path = './data/valor_spectra/',
                      full.names = TRUE) |>
  map(process_spectra) |>
  reduce(rbind) |>
  write_csv(file = './results/processed_valor_spectra.csv')

# calculate FTIR ratio's
ratio <- spectra %>% 
  group_by(file_name) %>% 
  do(calculate_FTIR_ratio(.)) %>% 
  ungroup() |> 
  write_csv(file = './results/valor_ftir_ratios.csv')
