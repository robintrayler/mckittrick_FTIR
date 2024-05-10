# load required libraries -----------------------------------------------------
library(tidyverse) 
library(RColorBrewer)
library(ggExtra)
library(viridis)
source('./R/plot_settings.R')

# load the data ---------------------------------------------------------------
training   <- read_csv(file = './results/training_data.csv')
testing    <- read_csv(file = './results/testing_data.csv')
threshold  <- read_csv(file = './results/logistic_threshold.csv')
logistic   <- read_csv(file = './results/logistic_fit.csv')
validation <- read_csv(file = './results/validation_results.csv')

validation <- testing |> 
  select(catalog_number, 
         WAMPI, 
         PCI, 
         weathering_score, 
         LPI,
         probability,
         classification) |> 
  right_join(validation,
             by = 'catalog_number') |> 
  mutate(collagen_present = as.numeric(collagen_present)) |> 
  filter(!is.na(WAMPI))

# what variables are in use ------------------------------
predictors <- c('WAMPI', 
                'PCI', 
                'LPI', 
                'weathering_score')

# pivot longer for plotting -------------------------------
training_long <- training |> 
  select(probability = collagen_present,
         all_of(predictors)) |> 
  pivot_longer(all_of(predictors)) |> 
  mutate(probability = as.numeric(probability)) |> 
  mutate(name = factor(name, levels = (predictors)))

logistic <- logistic |> 
  mutate(name = factor(name, levels = (predictors)))

threshold <- threshold |> 
  mutate(name = factor(name, levels = (predictors)))
# define names for plotting
names <- c(
  `WAMPI` = "WAMPI",
  `PCI` = "PCI",
  `LPI` = "LPI",
  `weathering_score` = "Weathering Stage"
)
pdf(file  = './figures/logistic.pdf', 
    width = 7.5,
    height = 2.25)
logistic |> 
  ggplot(mapping = aes(x = value, 
                       y = probability)) + 
  geom_line(linewidth = 1,
            lineend = 'round') + 
  facet_wrap(~name,
             scale = 'free',
             strip.position = 'bottom',
             labeller = as_labeller(names),
             nrow = 1) + 
  geom_jitter(data = training_long,
              mapping = aes(x = value, 
                            y = probability, 
                            fill = factor(probability),
                            color = factor(probability)),
              height = 0.01,
              size = 2,
              stroke = 1,
              show.legend = FALSE,
              alpha = 0.75,
              shape = 21) + 
  geom_vline(data = threshold,
             mapping = aes(xintercept = value),
             linetype = 'dashed',
             color = 'grey30',
             linewidth = 1,
             lineend = 'round') + 
  scale_color_manual(values = c("#FCA636FF", "#0D0887FF")) + 
  scale_fill_manual(values =alpha(c("#FCA636FF", "#0D0887FF"), 0.5)) +
  theme(strip.placement = 'outside',
        axis.title.x = element_blank(),
        strip.text   = element_text(size = 10,
                                    color = 'black'),
        # aspect.ratio = 1,
        panel.spacing = unit(1, "lines")) + 
  scale_y_continuous(breaks = c(0, 0.5, 1))

dev.off()

pdf(file  = './figures/training.pdf', 
    width = 3.5,
    height = 3.5)
training |> 
  ggplot(mapping = aes(x = PCI, 
                       y = WAMPI,
                       fill = factor(collagen_present),
                       color = factor(collagen_present))) + 
  geom_point(shape = 21,
             # show.legend = FALSE,
             size = 2,
             stroke = 1) +
  stat_ellipse(aes(color = factor(collagen_present)),
               show.legend = FALSE,
               linewidth = 1,
               alpha = 0.25) +
  scale_colour_manual(values = c("#FCA636FF", "#0D0887FF"),
                      labels = c('no', 'yes'),
                      name = "Collagen \n Present")+
  scale_fill_manual(values =alpha(c("#FCA636FF", "#0D0887FF"), 0.5),
                    labels = c('no', 'yes'),
                    name = "Collagen \n Present") +
  theme(aspect.ratio = 1,
        legend.position = c(0.75,0.8),
        legend.title.align = 0.0) + 
  xlim(2.5, 4.5) + 
  ylim(0, 1.25) + 
  geom_vline(xintercept = 3.40,
             linetype = 'dashed',
             color = 'grey30',
             linewidth = 1,
             lineend = 'round') + 
  geom_hline(yintercept = 0.43,
             linetype = 'dashed',
             color = 'grey30',
             linewidth = 1,
             lineend = 'round')
dev.off()


validation <- validation |> 
  mutate(legend = case_when(collagen_present == 1 & classification == 1 ~ 'True Positive',
                            collagen_present == 0 & classification == 0 ~ 'True Negative',
                            collagen_present == 0 & classification == 1 ~ 'False Positive',
                            collagen_present == 1 & classification == 0 ~ 'False Negative'))

colors = c('True Positive' = "#0D0887FF",
           'True Negative' = "#FCA636FF",
           'False Negative' = "#FCA636FF",
           'False Positive' = "#0D0887FF"
           )
fills  = c('True Positive' = "#0D0887FF", 
           'True Negative' = "#FCA636FF",
           'False Negative' = "#0D0887FF",
           'False Positive' = "#FCA636FF")


training <- training |> 
  mutate(legend = case_when(collagen_present == 1 ~ 'True Positive',
                                     collagen_present == 0 ~ 'True Negative'))
  

pdf(file  = './figures/validation.pdf', 
    width = 3.5,
    height = 3.5)
validation |> 
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
               alpha = 0.5) + 
  theme(legend.position = c(0.75, 0.8),
        legend.title = element_blank()) + 
  xlim(2.5, 4.5) + 
  ylim(0, 1.25) + 
  geom_vline(xintercept = 3.40,
             linetype = 'dashed',
             color = 'grey30',
             linewidth = 1,
             lineend = 'round') + 
  geom_hline(yintercept = 0.43,
             linetype = 'dashed',
             color = 'grey30',
             linewidth = 1,
             lineend = 'round')
dev.off()

