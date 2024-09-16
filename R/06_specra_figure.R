# load required packages ------------------------------------------------------
library(tidyverse)
library(ggridges)
library(cowplot)
source('./R/functions/normalize_height.R')
source('./R/plot_settings.R')

# load the data ---------------------------------------------------------------
data <- read_csv('./results/processed_spectra.csv') |> 
  # pick two samples, one with high WAMPI and one with low
  filter(catalog_number %in% c('259499', '153250')) |> 
  # fix the catalog numbers
  mutate(catalog_number = factor(catalog_number)) |>
  # rescale for plotting
  mutate(absorbance = absorbance * 2) |>
  # rename and rank
  mutate(collagen_present = case_when(catalog_number == '259499' ~ 'collagen preserved',
                                      catalog_number == '153250' ~ 'no collagen')) |> 
  mutate(rank = case_when(catalog_number == '259499' ~ 3,
                          catalog_number == '153250' ~ 2))

# load the McKittrick tar spectrum
tar <- read_csv(file = './results/processed_tar.csv') |> 
  mutate(collagen_present = 'McKittrick tar') |> 
  mutate(rank = 1)

# organize 
data <- data |> 
  full_join(tar) |> 
  mutate(collagen_present = factor(collagen_present, 
                                   levels = c('collagen preserved',
                                                  'no collagen',
                                                  'McKittrick tar')))

# define band positions and annotations ---------------------------------------
# lines to draw
annotations <- tribble(~label,          ~wavenumber, ~bottom, ~top,
                       'amide~I',        1650,          2,    4.5,
                       'amide~II',       1551,          2,    4.3,
                       'A~CO[3]',        1545,          2,    3.9,
                       'B~CO[3]',        1415,          2,    3.9,
                       'amide~III',      1231,          2,    3.5,
                       'PO[4]',          1020,          2,      4,
                       'CO[3]',           870,          2,    3.4,
                       'PO[4]',           565,          2,    4.0,
                       'PO[4]',           605,          2,    4.0,
                       'lipid',          2854,          1,    3.4,
                       'lipid',          2925,          1,    3.4)
# labels ----------------------------------------------------------------------
labels <- tribble(~label,          ~wavenumber, ~label_pos,
                  'amide~I',        1650,          4.6,
                  'amide~II',       1551,          4.0,
                  'A~CO[3]',        1545,          4.4,
                  'B~CO[3]',        1415,          4.2,
                  'amide~III',      1231,          3.6,
                  'PO[4]',          1020,          4.1,
                  'CO[3]',           870,          3.5,
                  'PO[4]',           585,          4.1,
                  'lipids',          2890,         3.6)

# plot the full spectrum ------------------------------------------------------
colors <- c(`McKittrick tar` = 'black', 
             `no collagen` = "#FCA636FF",
             `collagen preserved` = "#0D0887FF")

full_plot <- data |> 
  ggplot(mapping = aes(x = wavenumber,
                       y = rank,
                       height = absorbance,
                       fill = collagen_present,
                       color = collagen_present)) + 
  geom_density_ridges(stat = "identity",
                      show.legend = TRUE, 
                      scale = 1,
                      panel_scaling = FALSE) + 
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    legend.title = element_blank(),
    legend.position = c(0.85, 0.8),
    plot.background = element_rect(color = 'white')) + 
  xlab(expression('wavenumber'~('cm'^-1))) +
  ylab('absorbance') + 
  scale_fill_manual(values = alpha(colors, 0.5),
                    guide = "legend") + 
  scale_color_manual(values = colors,
                     guide = "legend") + 
  geom_segment(data = annotations,
               mapping = aes(x = wavenumber,
                             xend = wavenumber,
                             y = bottom,
                             yend = top), 
               inherit.aes = FALSE,
               linetype = 'dashed',
               lineend = 'round',
               alpha = 0.75) + 
  geom_text(data = labels, 
            mapping = aes(x = wavenumber,
                          y = label_pos,
                          label = label),
            parse = TRUE,
            inherit.aes = FALSE,
            size = 10 / ggplot2::.pt) + 
  annotate("rect", xmin = 2750, xmax = 3000, ymin = 1, ymax = 3.5,
           alpha = 0,
           size = 0.75,
           color = "#E41A1C") + 
  annotate("rect", xmin = 1200, xmax = 1800, ymin = 1, ymax = 3.5,
           alpha = 0,
           size = 0.75,
           color = "#80B1D3") + 
  annotate("rect", xmin = 400, xmax = 700, ymin = 1, ymax = 3.5,
           alpha = 0,
           size = 0.75,
           color = "#4DAF4A")

# seperate and plot lipid bands -----------------------------------------------

lipids <- data |>
  group_by(file_name) |> 
  normalize_height(position = 1000, width = 5) |> 
  ungroup()

tmp <- list()
u <- unique(data$file_name)
for(i in seq_along(u)) { 
  tmp[[i]] <- data |> 
    filter(file_name == u[i]) |> 
    normalize_height(position = 2925, width = 5)
}

lipids <- tmp |> reduce(rbind)

lipid_plot <- lipids |>
  filter(wavenumber > 2750 & wavenumber < 3000) |>
  ggplot(mapping = aes(x = wavenumber,
                       y = rank,
                       height = absorbance,
                       fill = collagen_present,
                       color = collagen_present)) +
  geom_density_ridges(stat = "identity",
                      show.legend = FALSE,
                      scale = 1,
                      panel_scaling = TRUE) +
  xlim(2800, 3000) +
  ylim(1, 4.5) +
  scale_color_manual(values = colors) +
  scale_fill_manual(values = alpha(colors, 0.5)) +
  geom_segment(data = annotations |> filter(label == 'lipid'),
               mapping = aes(x = wavenumber,
                             xend = wavenumber,
                             y = bottom,
                             yend = 4.2),
               inherit.aes = FALSE,
               linetype = 'dashed',
               lineend = 'round',
               size = 0.75,
               alpha = 0.75) +
  geom_text(data = labels,
            mapping = aes(x = wavenumber,
                          y = 4.3,
                          label = label),
            parse = TRUE,
            inherit.aes = FALSE,
            size = 10 / ggplot2::.pt) +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        panel.border = element_rect(color = "#E41A1C",
                                    fill = NA),
        axis.ticks = element_line(color = "#E41A1C"),
        plot.background = element_rect(color = 'white')) +
  ylab('absorbance') + 
  xlab(expression('wavenumber'~('cm'^-1)))


# seperate and plot phosphate bands -------------------------------------------
tmp <- list()
u <- unique(data$file_name)
for(i in seq_along(u)) { 
  tmp[[i]] <- data |> 
    filter(file_name == u[i]) |> 
    normalize_height(position = 605, width = 5)
}

amide <- tmp |> reduce(rbind)

phosphate_plot <- amide |> 
  filter(wavenumber > 400 & wavenumber < 700) |> 
  ggplot(mapping = aes(x = wavenumber,
                       y = rank,
                       height = absorbance,
                       fill = collagen_present,
                       color = collagen_present)) + 
  geom_density_ridges(stat = "identity",
                      show.legend = FALSE, 
                      # fill = NA,
                      scale = 1,
                      panel_scaling = FALSE) + 
  xlim(400, 700) +
  ylim(1, 5) +
  scale_color_manual(values = colors) + 
  scale_fill_manual(values = alpha(colors, 0.5)) + 
  geom_segment(data = annotations,
               mapping = aes(x = wavenumber,
                             xend = wavenumber,
                             y = bottom,
                             yend = top), 
               inherit.aes = FALSE,
               linetype = 'dashed',
               lineend = 'round',
               size = 0.75,
               alpha = 0.75) + 
  geom_text(data = labels, 
            mapping = aes(x = wavenumber,
                          y = label_pos,
                          label = label),
            parse = TRUE,
            inherit.aes = FALSE,
            size = 10 / ggplot2::.pt) + 
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        panel.border = element_rect(color = "#4DAF4A",
                                    size = 1,
                                    fill = NA),
        axis.ticks = element_line(color = "#4DAF4A"),
        plot.background = element_rect(color = 'white')) + 
  ylab('absorbance') + 
  xlab(expression('wavenumber'~('cm'^-1)))

# seperate and plot amide bands -----------------------------------------------
tmp <- list()
u <- unique(data$file_name)
for(i in seq_along(u)) { 
  tmp[[i]] <- data |> 
    filter(file_name == u[i]) |> 
    normalize_height(position = 1450, width = 5)
}

amide <- tmp |> reduce(rbind)

amide_plot <- amide |> 
  filter(wavenumber > 1200 & wavenumber < 1800) |> 
  ggplot(mapping = aes(x = wavenumber,
                       y = rank,
                       height = absorbance,
                       fill = collagen_present,
                       color = collagen_present)) + 
  geom_density_ridges(stat = "identity",
                      show.legend = FALSE, 
                      # fill = NA,
                      scale = 1,
                      panel_scaling = FALSE) + 
  xlim(1150, 1800) +
  ylim(1, 5) +
  scale_color_manual(values = colors) + 
  scale_fill_manual(values = alpha(colors, 0.5)) + 
  geom_segment(data = annotations,
               mapping = aes(x = wavenumber,
                             xend = wavenumber,
                             y = bottom,
                             yend = top), 
               inherit.aes = FALSE,
               linetype = 'dashed',
               lineend = 'round',
               size = 0.75,
               alpha = 0.75) + 
  geom_text(data = labels, 
            mapping = aes(x = wavenumber,
                          y = label_pos,
                          label = label),
            parse = TRUE,
            inherit.aes = FALSE,
            size = 10 / ggplot2::.pt) + 
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        panel.border = element_rect(color = "#80B1D3",
                                    fill = NA),
        axis.ticks = element_line(color = "#80B1D3"),
        plot.background = element_rect(color = 'white')) + 
  ylab('absorbance') + 
  xlab(expression('wavenumber'~('cm'^-1)))


full_plot <- plot_grid(full_plot, 
                       labels = 'A', 
                       label_x = 0.05, 
                       label_y = 0.95)

bottom <- plot_grid(phosphate_plot, amide_plot, lipid_plot, nrow = 1,
                    labels = c('B','C', 'D'),
                    label_x = c(0.15, 0.15, 0.15),
                    label_y = c(0.95, 0.95, 0.95))

pdf('./figures/spectra.pdf',
    width = 7.5, 
    height = 6.5)
plot_grid(full_plot, 
          bottom,
          nrow = 2,
          rel_heights = c(1,1))
dev.off()
