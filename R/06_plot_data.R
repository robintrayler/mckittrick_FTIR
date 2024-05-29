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

all_data <- 
  rbind(training, testing)

validation <- all_data |> 
  filter(data_type == 'validation')

combined <- all_data |> 
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

combined <- combined |> 
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

shapes  = c('True Positive' = 21, 
           'True Negative' = 22,
           'False Negative' = 21,
           'False Positive' = 22)

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
plts <- list()
for(i in seq_along(predictors)) {
   plts[[i]] <- training_long |> 
    filter(name == predictors[i]) |> 
    ggplot(mapping = aes(x = value,
                         y = probability)) + 
    geom_jitter(aes(color = factor(probability),
                    fill  = factor(probability),
                    shape = factor(probability)),
                height = 0.01,
                size = 2,
                stroke = 1,
                show.legend = FALSE,
                alpha = 0.75) + 
    geom_smooth(method = "glm", 
                aes(group = 1),
                method.args = list(family = "binomial"), 
                se = FALSE,
                color = 'black',
                show.legend = FALSE) + 
    geom_vline(data = threshold |> filter(name == predictors[i]),
               mapping = aes(xintercept = threshold),
               linetype = 'dashed',
               color = 'grey30',
               linewidth = 1,
               lineend = 'round') + 
    xlab(names[i]) + 
    scale_color_manual(values = c("#FCA636FF", "#0D0887FF")) + 
    scale_fill_manual(values =alpha(c("#FCA636FF", "#0D0887FF"), 0.25)) + 
     scale_shape_manual(values = c(22, 21)) + 
     theme(aspect.ratio = 1) + 
     scale_y_continuous(breaks = c(0, 0.5, 1))
}

training_logistic <- plot_grid(plotlist = plts,
          nrow = 1,
          labels = c('A', 'B', 'C', 'D'),
          label_x = c(0.25, 0.25, 0.35, 0.25),
          label_y = c(0.65, 0.65, 0.65, 0.65))

training_plot <- training |> 
  mutate(preservation = case_when(collagen_present == 1 ~ 'collagen preserved',
                                  collagen_present == 0 ~ 'no collagen')) |> 
  ggplot(mapping = aes(x = PCI, 
                       y = WAMPI,
                       fill = preservation,
                       color = preservation,
                       shape = preservation)) + 
  geom_point(size = 2,
             stroke = 1) +
  scale_shape_manual(values = c(21, 22)) + 
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
                       fill = legend,
                       shape = legend)) + 
  geom_point(size = 2,
             stroke = 1) + 
  geom_point(size = 2,
             stroke = 1) +
  scale_shape_manual(values = shapes) +
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


labels <- data.frame (WAMPI = c(0.525, 0.605, 0.805),
                      collagen_present = c(0.39, 0.6, 0.8),
                      label = c('50%', '75%', '95%'))
combined_logistic <- combined |>
  mutate(collagen_present = as.numeric(collagen_present)) |> 
  ggplot(mapping = aes(x = WAMPI, 
                       y = collagen_present,
                       color = factor(collagen_present),
                       fill  = factor(collagen_present),
                       shape = factor(collagen_present))) + 
  geom_jitter(aes(color = factor(collagen_present),
                  fill  = factor(collagen_present)),
              height = 0.01,
              size = 2,
              stroke = 1,
              show.legend = FALSE,
              alpha = 0.75) + 
  geom_smooth(method = "glm", 
              aes(group = 1),
              method.args = list(family = "binomial"), 
              se = FALSE,
              color = 'black',
              show.legend = FALSE) + 
  geom_vline(xintercept = c(0.5, 0.58, 0.78),
             linetype = 'dashed',
             color = c('grey1', 'grey31', 'grey53'),
             linewidth = 1,
             lineend = 'round') + 
  scale_color_manual(values = c("#FCA636FF", "#0D0887FF")) + 
  scale_fill_manual(values =alpha(c("#FCA636FF", "#0D0887FF"), 0.25)) +
  scale_shape_manual(values = c(22, 21)) +
  theme(plot.background = element_rect(color = 'white'),
        panel.spacing = unit(1, "lines"),
        aspect.ratio = 1) + 
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

combined_plot <- combined |> 
  mutate(preservation = case_when(collagen_present == 1 ~ 'collagen preserved',
                                  collagen_present == 0 ~ 'no collagen')) |> 
  ggplot(mapping = aes(x = PCI,
                       y = WAMPI,
                       color = preservation,
                       fill = preservation,
                       shape = preservation)) + 
  geom_point(size = 2,
             stroke = 1) + 
  stat_ellipse(
               show.legend = FALSE,
               linewidth = 1,
               alpha = 0.75) + 
  theme(legend.position = c(0.75, 0.85),
        legend.title = element_blank(),
        plot.background = element_rect(color = 'white'),
        aspect.ratio = 1) + 
  xlim(2.5, 4.5) + 
  ylim(0, 1.25) + 
  geom_hline(yintercept = c(0.52, 0.60, 0.8),
             linetype = 'dashed',
             color = c('grey1', 'grey31', 'grey53'),
             linewidth = 1,
             lineend = 'round') + 
  scale_color_manual(values = c( "#0D0887FF", "#FCA636FF")) + 
  scale_fill_manual(values =alpha(c( "#0D0887FF","#FCA636FF"), 0.5)) + 
  scale_shape_manual(values = c(21, 22)) +
  geom_text(data = labels,
            mapping = aes(y = WAMPI + 0.03,
                          x = 4.35, 
                          label = label),
            inherit.aes = FALSE,
            size = 10 / ggplot2::.pt)


pdf(file  = './figures/logistic.pdf',
    width = 7.5,
    height = 2.15)
training_logistic
dev.off()

pdf('./figures/training.pdf',
    width = 7.5, 
    height = 3.5)
cowplot::plot_grid(training_plot, validation_plot, nrow  = 1,
                   labels = c('A', 'B'),
                   label_x = c(0.175, 0.175),
                   label_y = c(0.98,0.98))
dev.off()

pdf('./figures/combined_logistic.pdf',
    width = 7.5, 
    height = 3.5)
cowplot::plot_grid(combined_plot ,combined_logistic, nrow = 1, 
                   labels = c('A', 'B'),
                   label_x = c(0.175, 0.175),
                   label_y = c(0.98,0.98))
dev.off()

