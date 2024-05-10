# load required libraries -----------------------------------------------------
library(tidyverse) 
library(caret)
library(broom)
library(RColorBrewer)

# load ggplot theme
source('./R/plot_settings.R')

# load the data ---------------------------------------------------------------
ftir <- read_csv(file = './data/ftir_ratios.csv') |> 
  mutate(catalog_number = as.character(catalog_number))

# load taphonomy data for the known specimens
taphonomy <- read.csv(file = './data/training_taphonomy.csv') |> 
  mutate(catalog_number = as.character(catalog_number)) |> 
  select(catalog_number, weathering_score)

# join the taphonomy to the FTIR data
data <- ftir |> 
  full_join(taphonomy,
            by = 'catalog_number') |> 
  filter(!is.na(file_name))
rm(ftir, 
   taphonomy)

# split into training and testing data sets -----------------------------------
training <- data |> 
  filter(is.finite(collagen_present)) |> 
  # filter(locality == 'McKittrick') |> 
  # convert to 0 or 1 probabilities for logistic regression
  mutate(collagen_present = as.numeric(collagen_present))

testing <- data |> 
  filter(is.na(collagen_present))

# fit logistic regression models to different variables -----------------------
predictors <- c('WAMPI', 
                'PCI', 
                'LPI', 
                'weathering_score')

# loop through all the predictors ---------------------------------------------
fit <- list()

for(i in seq_along(predictors)) {
  fit[[i]] <- training |> 
    glm(as.formula(paste("collagen_present ~", paste(predictors[i]))), 
        family = 'binomial', data = _)
}
# name the entries
names(fit) = predictors

# calculate probability over an even grid for each predictor ------------------
# preallocate some storage 
grid <- matrix(nrow = 1000, 
               ncol = length(predictors)) |> 
  as.data.frame()
names(grid) <- predictors

# make an evenly spaced grid 
for(i in seq_along(predictors)) {
  rng <- range(data[[predictors[i]]], na.rm = TRUE)
  grid[[predictors[i]]] <- seq(rng[1], 
                               rng[2], 
                               length = 1000)
}

# calculate probabilities ----------------------------------------------------
# preallocate storage 
probability <- matrix(nrow = 1000, 
                      ncol = length(predictors)) |> 
  as.data.frame()
# name the columns 
names(probability) <- predictors

# predict each probability
for(i in seq_along(predictors)) {
  probability[[predictors[i]]] <- predict(fit[[i]], 
                                          newdata = grid,
                                          type = 'response')
}

# pivot to longer and join with probabilities
grid <- grid |> 
  pivot_longer(cols = all_of(predictors))

probability <- probability |> 
  pivot_longer(cols = all_of(predictors),
               values_to = 'probability') |> 
  select(probability)

logistic <- cbind(grid, 
                  probability)
rm(grid, probability)

# calculate prediction threshold (odds-ratio of 1) ----------------------------
threshold <- logistic |> 
  mutate(threshold = abs(probability - 0.5)) |> 
  group_by(name) |> 
  slice(which.min(threshold)) |> 
  select(name, value, probability)

# classify the training data --------------------------------------------------
# predict the probability of the training data 
classification <- list()
for(i in seq_along(predictors)) {
  classification[[i]] <- predict(fit[[i]],
                                 newdata = training,
                                 type = 'response') |> 
    as.vector()
}
# name the columns
names(classification) <- paste0(predictors, '_prob')

# add file name column for identifying
classification <- as_tibble(classification) |> 
  add_column(file_name = training$file_name)

# join to the training data
training <- classification |> 
  full_join(training, by = 'file_name')

# calculate classifications using the odds ratio of 1 
training <- training |> 
  mutate(WAMPI_classification = case_when(
    WAMPI_prob > 0.5 ~ 1, 
    WAMPI_prob < 0.5 ~ 0)
  ) |> 
  mutate(
    PCI_classification = case_when(
      PCI_prob > 0.5 ~ 1, 
      PCI_prob < 0.5 ~ 0
    )
  ) |> 
  mutate(
    LPI_classification = case_when(
      LPI_prob > 0.5 ~ 1, 
      LPI_prob < 0.5 ~ 0
    )
  ) |> 
  mutate(
    weathering_score_classification = case_when(
      weathering_score_prob > 0.5 ~ 1, 
      weathering_score_prob < 0.5 ~ 0
    )
  )

# calculate confusion matrices ------------------------------------------------
threshold <- threshold |> 
  add_column(sensitivity = NA,
             specificity = NA)

for(i in seq_along(predictors)) {
  tmp <- training |> 
    select(!!paste0(predictors[i], '_classification'),
           collagen_present) |> 
    mutate_if(is.numeric, as.factor)
  
  # extract sensitivity and specificity
  SS <- caret::confusionMatrix(data = tmp[[1]],
                               reference = tmp[[2]],
                               positive = '1')
  
  # store it in the data.frame with the threshold values
  threshold$sensitivity[threshold$name == predictors[i]] = SS$byClass[[1]]
  threshold$specificity[threshold$name == predictors[i]] = SS$byClass[[2]]
  threshold$pos_predict[threshold$name == predictors[i]] = SS$byClass[[3]]
  threshold$neg_predict[threshold$name == predictors[i]] = SS$byClass[[4]]
  threshold$p_value[threshold$name == predictors[i]] = SS$overall[[7]]
  threshold$alpha[threshold$name == predictors[i]]= coef(fit[[predictors[i]]])[1]
  threshold$beta[threshold$name == predictors[i]] = coef(fit[[predictors[i]]])[2]
  threshold$p_value[threshold$name == predictors[i]] = tidy(fit[[predictors[i]]])$p.value[2]
  rm(tmp, SS)
}

# predict the testing data ----------------------------------------------------
# WAMPI is the most predictive
testing <- testing |> 
  mutate(probability = predict(fit$WAMPI, 
                               type = 'response', 
                               newdata = testing)) |> 
  mutate(classification = case_when(
    probability > 0.5 ~ 1, 
    probability < 0.5 ~ 0))

# save everything -------------------------------------------------------------
logistic |> 
  write_csv(file = './results/logistic_fit.csv')

training |> 
  write_csv(file = './results/training_data.csv')

testing |> 
  write_csv(file = './results/testing_data.csv')

threshold |> 
  write_csv(file = './results/logistic_threshold.csv')