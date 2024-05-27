# function to calculate several useful FTIR ratios
# Robin B. Trayler November 28, 2023

calculate_FTIR_ratio <- function(data) {
  # A carbonate
  B_1545 <- data %>% 
    filter(between(wavenumber, 
                   left = 1545 - 5, 
                   right = 1545 + 5)) %>%
    pull(absorbance) %>% max()
  
  # B carbonate
  B_1415 <- data %>% 
    filter(between(wavenumber, 
                   left = 1415 - 5, 
                   right = 1415 + 5)) %>%
    pull(absorbance) %>% max()
  
  # amide_1
  amide_I <- data |> 
    filter(between(wavenumber, 
                   left = 1650 - 20, 
                   right = 1650 + 20)) |> 
    pull(absorbance) |> 
    max()
  
  # phosphate
  B_605 <- data |> 
    filter(between(wavenumber, 
                   left = 605 - 10, 
                   right = 605 + 10)) |>  
    pull(absorbance) |> 
    max()
  
  # phosphate
  B_565 <- data |>  
    filter(between(wavenumber, 
                   left = 565 - 10, 
                   right = 565 + 10)) |> 
    pull(absorbance) |> 
    max()
  
  # phosphate
  B_1020 <- data  |>  
    filter(between(wavenumber, 
                   left = 1020 - 25, 
                   right = 1020 + 25)) |> 
    pull(absorbance) |>  
    max()
  
  # valley
  V_590 <- data  |>  
    filter(between(wavenumber, 
                   left = 570, 
                   right = 600)) |>  
    pull(absorbance) |>  
    min()
  
  # lipid bands
  B_2854 <- data  |>  
    filter(between(wavenumber, 
                   left = 2854 - 15, 
                   right = 2854 + 15))  |>  
    pull(absorbance) %>% max()
  
  B_2925 <- data |>  
    filter(between(wavenumber, 
                   left = 2925 - 15, 
                   right = 2925 + 15))  |>  
    pull(absorbance) |>  
    max()
  
  results <- tibble(
    WAMPI      = amide_I  / B_605,
    PCI        = (B_605 + B_565) / V_590, 
    LPI        = (B_2854 + B_2925) / B_605,
    catalog_number = unique(data$catalog_number))
  return(results)
}