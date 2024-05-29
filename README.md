# Rapid, Effective Screening of Tar Seep Fossils for Radiocarbon and Stable Isotope Analysis

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



