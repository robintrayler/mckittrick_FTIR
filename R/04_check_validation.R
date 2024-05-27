# load required libraries -----------------------------------------------------
library(tidyverse) 
library(caret)
library(broom)

# load the data ---------------------------------------------------------------
validation <- read_csv(file = './results/initial_testing_classification.csv') |> 
  filter(data_type == 'validation') |> 
  mutate(collagen_present = as.numeric(collagen_present))

# calculate confusion matrix for validation data set --------------------------

tmp <- validation |> 
  select(WAMPI_classification, 
         collagen_present) |> 
  mutate_if(is.numeric, as.factor)

SS <- caret::confusionMatrix(data = tmp[[1]],
                             reference = tmp[[2]],
                             positive = '1')

# Sensitivity is about the same but specificity is lower 
validation_stats <- 
  data.frame(
    sensitivity = SS$byClass[[1]],
    specificity = SS$byClass[[2]])


