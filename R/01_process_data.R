# load required packages ------------------------------------------------------
library(tidyverse) # data manipulation
library(progress)  # progress bars 

# source custom functions 
source('./R/functions/process_spectra.R')

# process each spectra --------------------------------------------------------
# set up a progress bar
pb <- progress_bar$new(
  total = length(list.files(path = './data/spectra/')))

# get a list of the files and process
spectra <- list.files(path = './data/spectra/',
           full.names = TRUE) |>
  map(process_spectra) |>
  reduce(rbind) |>
  write_csv(file = './data/processed_spectra.csv')

# cleanup
rm(list = ls())

pb <- progress_bar$new(
  total = length(list.files(path = './data/tar_spectra/')))

# get a list of the files and process
spectra <- list.files(path = './data/tar_spectra/',
                      full.names = TRUE) |>
  map(process_spectra) |>
  reduce(rbind) |>
  write_csv(file = './data/processed_tar.csv')

# cleanup
rm(list = ls())