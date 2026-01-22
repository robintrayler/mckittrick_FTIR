# load required libraries -----------------------------------------------------
library(tidyverse) 
library(caret)
library(broom)

# load the data ---------------------------------------------------------------
data <- read_csv(file = './results/ftir_ratios.csv') |> 
  mutate(catalog_number = as.character(catalog_number))

# split into training and testing data sets -----------------------------------
training <- data |> 
  filter(data_type == 'training') |> 
  # convert to 0 or 1 probabilities for logistic regression
  mutate(collagen_present = as.numeric(collagen_present))

testing <- data |> 
  filter(data_type != 'training')

# fit logistic regression models to different variables -----------------------
predictors <- c('WAMPI', 
                'PCI', 
                'LPI', 
                'weathering_score')

# loop through all the predictors ---------------------------------------------
fit <- list() # preallocate a list
for(i in seq_along(predictors)) {
  fit[[i]] <- training |> 
    glm(as.formula(paste("collagen_present ~", paste(predictors[i]))), 
        family = 'binomial', data = _)
}
# name the entries
names(fit) = predictors

# calculate prediction threshold (odds-ratio of 1) ----------------------------
# simple function to calculate thresholds for given odds ratio
calc_threshold <- function(fit, odds_ratio){
  co <- coef(fit)
  a = co[1]
  B = co[2]
  threshold <- ((log(odds_ratio) - a) / B)
  return(threshold)
}

# put it all in a data frame
threshold <- lapply(X = fit, 
                    FUN = calc_threshold, 
                    odds_ratio = 1) |> 
  reduce(rbind) |> 
  as_tibble() |> 
  select(threshold = `(Intercept)`) |> 
  add_column(name = predictors)

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
# calculates sensitivity, specificity
threshold <- threshold |> 
  add_column(sensitivity = NA,
             specificity = NA,
             alpha = NA,
             beta = NA,
             p_value = NA)

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
  threshold$alpha[threshold$name == predictors[i]]= coef(fit[[predictors[i]]])[1]
  threshold$beta[threshold$name == predictors[i]] = coef(fit[[predictors[i]]])[2]
  threshold$p_value[threshold$name == predictors[i]] = tidy(fit[[predictors[i]]])$p.value[2]
  rm(tmp, SS)
}

# predict the testing data ----------------------------------------------------
# WAMPI is the most predictive, lets just use that 
testing <- testing |> 
  mutate(WAMPI_probability = predict(fit$WAMPI, 
                               type = 'response', 
                               newdata = testing)) |> 
  mutate(WAMPI_classification = case_when(
    WAMPI_probability > 0.5 ~ 1, 
    WAMPI_probability < 0.5 ~ 0)
  ) |> 
  mutate(PCI_probability = predict(fit$PCI, 
                                     type = 'response', 
                                     newdata = testing)) |> 
  mutate(PCI_classification = case_when(
    PCI_probability > 0.5 ~ 1, 
    PCI_probability < 0.5 ~ 0)
  )

# save everything -------------------------------------------------------------
training |> 
  select(file_name,
         museum,
         catalog_number,
         UCIAMS_number,
         locality,
         taxon,
         genus,
         species,
         collagen_present,
         weathering_score,
         WAMPI,
         PCI,
         LPI,
         WAMPI_classification,
         data_type,
         publication) |> 
  write_csv(file = './results/initial_training_classification.csv')

testing |> 
  select(file_name,
         museum,
         catalog_number,
         UCIAMS_number,
         locality,
         taxon,
         genus,
         species,
         collagen_present,
         weathering_score,
         WAMPI,
         PCI,
         LPI,
         WAMPI_classification,
         data_type,
         publication) |> 
  write_csv(file = './results/initial_testing_classification.csv')

threshold |> 
  write_csv(file = './results/initial_logistic_threshold.csv')

rm(list = ls())