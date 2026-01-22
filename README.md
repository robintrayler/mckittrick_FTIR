# Rapid, Effective Screening of Tar Seep Fossils for Radiocarbon and Stable Isotope Analysis

![](badge.svg)

## Citation
This repository contains the data and code for [Rapid, effective screening of tar seep fossils for radiocarbon and stable isotope analysis](https://www.sciencedirect.com/science/article/pii/S1871101424001353)(DOI:10.1016/j.quageo.2024.101631). 

## File Structure 

```
.
├── data
    └── spectra           # FTIR spectra for all fossils
    └── tar_spectra       # FTIR spectra for McKittrick tar
    └── metadata          # metadata for all specimens in spectra
                            # split into training, testing, and validation files
├── R                     # R scripts to be run in numerical order 0 - 7
    └── functions         # data processing functions 
├── results               # output directory for results files
├── figures               # output directory for pdf figures
├── manuscript.md         # pandoc markdown formatted manuscript
├── reviewer_comments.md  # pandoc markdown formatted responce to reviwers
└── README.md
```

## Manuscript

This manuscript is written in [`Pandoc`](https://pandoc.org) flavored markdown. Follow the instructions [here](https://pandoc.org/installing.html) to install `pandoc`. The manuscript also relies on the [`pandoc-crossref`](https://github.com/lierdakil/pandoc-crossref) filter to handle figure, table, and section numbering. 

The manuscript file, `manuscript.md` can be compiled into a nicely formatted PDF by running the following pandoc command.

```bash
pandoc -s manuscript.md -o manuscript.pdf --pdf-engine=xelatex --filter pandoc-crossref --citeproc --number-sections
```

## Continued Use

The code assumes the FTIR spectra files are text files named with a museum prefix followed by a `catalog_number` separated by an underscore (i.e., `UCMP_123456.txt`). The files should be tab delineated files with two columns and no headers. The first column is the wavenumber and the second column is the absorbance. If your files are in a different format they should still work but you will need to modify `./R/functions/process_spectra.R`.

The script `07_continued_use.R` contains example code that can be used to process new FTIR spectra files and calculate the various FTIR indices used in the manuscript. New FTIR spectra files should be placed in a the `./data/new_spectra/` directory. A metadata file named `new_metadata.csv` should be placed in `./data/metadata/`. This file can contain any relevant metadata as long as it follows a similar format to the files used in the manuscript. It does not need to contain all the same column headers but it **must** contain the `catalog_number` column that is used to link the metadata to the spectrum files. `The 07_continued_use.R` will read in all the files in this directory, apply appropriate data processing and output two results files to `./results/`. `processed_new_spectra.csv` contains the FTIR spectra, baseline corrected and smoothed FTIR spectra. `new_ftir_ratios.csv` contains FTIR ratio's for the new FTIR spectra files. 

