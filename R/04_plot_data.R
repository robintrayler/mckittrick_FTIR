# load required libraries -----------------------------------------------------
library(tidyverse) 
library(RColorBrewer)
library(ggExtra)
library(viridis)
source('./R/plot_settings.R')

# load the data ---------------------------------------------------------------
training   <- read_csv(file = './results/initial_training_classification.csv')
testing    <- read_csv(file = './results/initial_testing_classification.csv')
threshold  <- read_csv(file = './results/initial_logistic_threshold.csv') 
combined_threshold <- read_csv(file = './results/combined_threshold.csv')

validation <- testing |> 
  filter(data_type == 'validation')

combined <- testing |> 
  filter(data_type %in% c('validation', 'training'))

# what variables are in use ---------------------------------------------------
predictors <- c('WAMPI', 
                'PCI', 
                'LPI', 
                'weathering_score')



# add columns for legend generation -------------------------------------------
validation <- validation |> 
  mutate(legend = case_when(collagen_present == 1 & WAMPI_classification == 1 ~ 
                              'True Positive',
                            collagen_present == 0 & WAMPI_classification == 0 ~ 
                              'True Negative',
                            collagen_present == 0 & WAMPI_classification == 1 ~ 
                              'False Positive',
                            collagen_present == 1 & WAMPI_classification == 0 ~ 
                              'False Negative'))

training <- training |> 
  mutate(legend = case_when(collagen_present == 1 ~ 'True Positive',
                            collagen_present == 0 ~ 'True Negative'))
# define colors & names -------------------------------------------------------
colors = c('True Positive' = "#0D0887FF",
           'True Negative' = "#FCA636FF",
           'False Negative' = "#FCA636FF",
           'False Positive' = "#0D0887FF")
fills  = c('True Positive' = "#0D0887FF", 
           'True Negative' = "#FCA636FF",
           'False Negative' = "#0D0887FF",
           'False Positive' = "#FCA636FF")

names <- c(
  `WAMPI` = "WAMPI",
  `PCI` = "PCI",
  `LPI` = "LPI",
  `weathering_score` = "Weathering Stage")

# pivot longer for plotting ---------------------------------------------------
# training data
training_long <- training |> 
  select(probability = collagen_present,
         all_of(predictors)) |> 
  pivot_longer(all_of(predictors)) |> 
  mutate(probability = as.numeric(probability)) |> 
  mutate(name = factor(name, 
                       levels = (predictors)))

# combined training & validation
combined_long <- combined |> 
  select(probability = collagen_present,
         all_of(predictors)) |> 
  pivot_longer(all_of(predictors)) |> 
  mutate(probability = as.numeric(probability)) |> 
  mutate(name = factor(name, 
                       levels = (predictors)))

# create factors
threshold <- threshold |> 
  mutate(name = factor(name, levels = (predictors)))

# Figure 3 --------------------------------------------------------------------
# pdf(file  = './figures/logistic.pdf', 
#     width = 7.5,
#     height = 2.15)
training_logistic <- training_long |> 
  ggplot(mapping = aes(x = value, 
                       y = probability,
                       color = factor(probability),
                       fill  = factor(probability))) + 
  geom_jitter(aes(color = factor(probability),
                  fill  = factor(probability)),
              height = 0.01,
              size = 2,
              stroke = 1,
              show.legend = FALSE,
              alpha = 0.75,
              shape = 21) + 
  facet_wrap(~name,
             scale = 'free',
             strip.position = 'bottom',
             labeller = as_labeller(names),
             nrow = 1) + 
  geom_smooth(method = "glm", 
              aes(group = 1),
              method.args = list(family = "binomial"), 
              se = FALSE,
              color = 'black',
              show.legend = FALSE) + 
  geom_vline(data = threshold,
             mapping = aes(xintercept = threshold),
             linetype = 'dashed',
             color = 'grey30',
             linewidth = 1,
             lineend = 'round') + 
  scale_color_manual(values = c("#FCA636FF", "#0D0887FF")) + 
  scale_fill_manual(values =alpha(c("#FCA636FF", "#0D0887FF"), 0.25)) +
  theme(strip.placement = 'outside',
        axis.title.x = element_blank(),
        strip.text   = element_text(size = 10,
                                    color = 'black'),
        plot.background = element_rect(color = 'white'),
        panel.spacing = unit(1, "lines")) + 
  scale_y_continuous(breaks = c(0, 0.5, 1))

# pdf(file  = './figures/training.pdf', 
#     width = 3.5,
#     height = 3.5)


training_plot <- training |> 
  mutate(preservation = case_when(collagen_present == 1 ~ 'collagen preserved',
                                  collagen_present == 0 ~ 'no collagen')) |> 
  ggplot(mapping = aes(x = PCI, 
                       y = WAMPI,
                       fill = preservation,
                       color = preservation)) + 
  geom_point(shape = 21,
             # show.legend = FALSE,
             size = 2,
             stroke = 1) +
  stat_ellipse(aes(color = preservation),
               show.legend = FALSE,
               linewidth = 1,
               alpha = 0.75) +
  scale_colour_manual(values = c('no collagen' = "#FCA636FF",'collagen preserved' = "#0D0887FF"))+
  scale_fill_manual(values =alpha(c('no collagen' = "#FCA636FF",'collagen preserved' = "#0D0887FF"), 0.5)) +
  theme(aspect.ratio = 1,
        legend.position = c(0.7,0.85),
        legend.title = element_blank(),
        plot.background = element_rect(color = 'white')) + 
  xlim(2.5, 4.5) + 
  ylim(0, 1.25) + 
  geom_hline(yintercept = 0.43,
             linetype = 'dashed',
             color = 'grey30',
             linewidth = 1,
             lineend = 'round')

validation_plot <- validation |> 
  ggplot(mapping = aes(x = PCI,
                       y = WAMPI,
                       color = legend,
                       fill = legend)) + 
  geom_point(size = 2,
             shape = 21,
             stroke = 1) + 
  scale_color_manual(values = colors) + 
  scale_fill_manual(values = alpha(fills, 0.5)) + 
  stat_ellipse(data = training,
               mapping = aes(x = PCI, 
                             y = WAMPI,
                             color = legend),
               show.legend = FALSE,
               linewidth = 1,
               alpha = 0.75) + 
  theme(legend.position = c(0.75, 0.8),
        legend.title = element_blank(),
        plot.background = element_rect(color = 'white'),
        aspect.ratio = 1) + 
  xlim(2.5, 4.5) + 
  ylim(0, 1.25) + 
  geom_hline(yintercept = 0.43,
             linetype = 'dashed',
             color = 'grey30',
             linewidth = 1,
             lineend = 'round')


labels <- data.frame (WAMPI = c(0.52, 0.60, 0.8),
                      collagen_present = c(0.39, 0.6, 0.8),
                      label = c('50%', '75%', '95%'))
combined_logistic <- combined |>
  mutate(collagen_present = as.numeric(collagen_present)) |> 
  ggplot(mapping = aes(x = WAMPI, 
                       y = collagen_present,
                       color = factor(collagen_present),
                       fill  = factor(collagen_present))) + 
  geom_jitter(aes(color = factor(collagen_present),
                  fill  = factor(collagen_present)),
              height = 0.01,
              size = 2,
              stroke = 1,
              show.legend = FALSE,
              alpha = 0.75,
              shape = 21) + 
  geom_smooth(method = "glm", 
              aes(group = 1),
              method.args = list(family = "binomial"), 
              se = FALSE,
              color = 'black',
              show.legend = FALSE) + 
  geom_vline(xintercept = c(0.5, 0.58, 0.78),
             linetype = 'dashed',
             color = c('grey1', 'grey20', 'grey50'),
             linewidth = 1,
             lineend = 'round') + 
  scale_color_manual(values = c("#FCA636FF", "#0D0887FF")) + 
  scale_fill_manual(values =alpha(c("#FCA636FF", "#0D0887FF"), 0.25)) +
  theme(plot.background = element_rect(color = 'white'),
        panel.spacing = unit(1, "lines")) + 
  scale_y_continuous(breaks = c(0, 0.5, 1)) + 
  geom_text(data = labels,
            mapping = aes(x = WAMPI,
                          y = collagen_present, 
                          label = label),
            inherit.aes = FALSE,
            size = 10 / ggplot2::.pt,
            angle = -90) + 
  xlab('WAMPI') + 
  ylab('probability')


pdf(file  = './figures/logistic.pdf',
    width = 7.5,
    height = 2.15)
training_logistic
dev.off()

pdf('./figures/training.pdf',
    width = 3.5, 
    height = 3.5)
training_plot
dev.off()

pdf('./figures/validation.pdf',
    width = 3.5, 
    height = 3.5)
validation_plot
dev.off()

pdf('./figures/combined_logistic.pdf',
    width = 3.5, 
    height = 3.5)
combined_logistic
dev.off()

