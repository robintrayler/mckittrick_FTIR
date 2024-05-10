fit_baseline <- function(data, 
                         background_positions,
                         plot = FALSE){
  
  # build a string for parsing
  strng <- 
    background_positions %>% 
    stringr::str_glue_data("between(wavenumber, left = {low}, right = {high})")
  strng <- str_c(strng, sep =" ", collapse = "|")
  str <- strng[1]
  
  # parse the string and fit a spline to the baseline points
  baseline_function <- data %>% 
    filter(!!rlang::parse_expr(strng)) %>% 
    with(smooth.spline(
      x = wavenumber,
      y = absorbance,
      spar = 0.1)) %>% 
    with(approxfun(x, y))
  
  # subtract the spline from the data 
  data <- data %>% 
    mutate(baseline = baseline_function(wavenumber)) %>% 
    mutate(absorbance_corrected = absorbance - baseline) %>% 
    mutate(absorbance_corrected = absorbance_corrected + abs(min(absorbance_corrected)))
  
  if(plot) {
   p <- data %>% 
      ggplot(mapping = aes(x = wavenumber)) + 
      geom_line(mapping = aes(y = baseline),
                linetype = 'dashed',
                color = 1) + 
      geom_line(mapping = aes(y = absorbance),
                color = 'black') + 
      geom_line(mapping = aes(y = absorbance_corrected),
                color = 'grey') + 
      theme_classic()
   print(p)
  }

   
  
  # return it
  data <- data %>% 
    select(wavenumber, 
           absorbance = absorbance_corrected) %>% 
    return()
}
