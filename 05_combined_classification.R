# load required libraries -----------------------------------------------------
library(tidyverse) 
library(caret)
library(broom)
library(RColorBrewer)

# load ggplot theme
source('./R/plot_settings.R')

# load the data ---------------------------------------------------------------
data <- read_csv(file = './results/ftir_ratios.csv') |> 
  mutate(catalog_number = as.character(catalog_number))

# split into training and testing data sets -----------------------------------
combined <- data |> 
  filter(data_type %in% c('training','validation')) |> 
  # convert to 0 or 1 probabilities for logistic regression
  mutate(collagen_present = as.numeric(collagen_present))

# fit logistic regression models to different variables -----------------------
predictors <- c('WAMPI') # drop the two least predictive (weathering, LPI)

# loop through all the predictors ---------------------------------------------
fit <- combined |> 
  glm(collagen_present ~ WAMPI, 
      family = 'binomial', data = _)

# calculate prediction threshold (odds-ratio of 1) ----------------------------
# simple function to calculate thresholds for given odds ratio
calc_threshold <- function(fit, odds_ratio){
  co <- coef(fit)
  a = co[1]
  B = co[2]
  threshold <- ((log(odds_ratio) - a) / B)
  return(threshold)
}

threshold <- calc_threshold(fit, 1) |> 
  as_tibble() |> 
  select(threshold = value) |> 
  add_column(name = predictors)

# classify the data -----------------------------------------------------------
# predict the probability of the training data

combined <- combined |> 
  mutate(
    WAMPI_probability = predict(fit,
                                newdata = combined,
                                type = 'response')) |> 
  # calculate classifications using the odds ratio of 1 
  mutate(WAMPI_classification = case_when(
    WAMPI_probability > 0.5 ~ 1, 
    WAMPI_probability < 0.5 ~ 0)) 

# calculate confusion matrices ------------------------------------------------
# calculates sensitivity, specificity
  tmp <- combined |> 
    select(WAMPI_classification,
           collagen_present) |> 
    mutate_if(is.numeric, as.factor)
  
  # extract sensitivity and specificity
  SS <- caret::confusionMatrix(data = tmp[[1]],
                               reference = tmp[[2]],
                               positive = '1')
  # calculate final WAMPI threshold for classification ------------------------
  threshold <- threshold |> 
    add_column(sensitivity = SS$byClass[[1]],
               specificity = SS$byClass[[2]],
               alpha =  coef(fit)[1],
               beta = coef(fit)[2],
               p_value = tidy(fit)$p.value[2]) |> 
    write_csv(file = './results/combined_threshold.csv')
  