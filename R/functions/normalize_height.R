normalize_height <- function(data, 
                             position, 
                             width) {
  # find the local maximum
  divide_by <- data |>
    filter(between(wavenumber, 
                   left = position - width, 
                   right = position + width)) |> 
    pull(absorbance) |> 
    max()
  
  # normalize the data to that height
  data <- data |>
    mutate(absorbance = absorbance / divide_by)
  
  return(data)
}

