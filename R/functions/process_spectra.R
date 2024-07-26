process_spectra <- function(file_path) {
  pb$tick()
  # load custom functions -----------------------------------------------------
  source('./R/functions/fit_baseline.R')
  source('./R/functions/normalize_height.R')
  source('./R/functions/smooth_spectra.R')
  source('./R/functions/interpolate_spectra.R')
  
  # define baseline positions for apatite -------------------------------------
  background_positions <- tribble(~high, ~low,
                                  4000,  3950,
                                  2000,  1900,
                                  1225,  1220,
                                  650,   640,
                                  405,   400)
  
  # extract the file name -----------------------------------------------------
  # files must be named UCMP_identifier for this to work
  name <- (basename(file_path) |> 
             tools::file_path_sans_ext() |>  
             str_split(pattern = '_') |> 
             unlist())[2]
  
  catalog_number <- (name |> 
    str_split(pattern = '\\.') |> 
    unlist())[1]
  
  # read the dpt files in
  dat <- read_table(file = file_path, 
                    col_names = FALSE,
                    progress = FALSE,
                    col_types = cols()) |> 
    # rename the columns
    rename('wavenumber' = X1,
           'absorbance' = X2) |>
    # interpolate onto an even one wavenumber spacing
    interpolate_spectra() |> 
    # smooth using a Gaussian smoother
    smooth_spectra() |> 
    # normalize the height to the phosphate peak maximum
    normalize_height(position = 1000, width = 20) |> 
    # fit a baseline 
    fit_baseline(background_positions = background_positions, plot = TRUE) |> 
    # add the file name and catalog number
    mutate(file_name = tools::file_path_sans_ext(basename(file_path)),
           catalog_number = catalog_number)
  # return everything
  return(dat)
}
