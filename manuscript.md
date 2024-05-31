---
title: "Rapid, Effective Screening of Tar Seep Fossils for Radiocarbon and Stable Isotope Analysis"
author:
  - ^1,\*^Robin B. Trayler
  - ^1^Lauren E. Lopes
  - ^2^Patrica A. Holroyd
  - ^1^Sora L. Kim
  - ^3^John R. Southon 

mainfont: "Helvetica"
fontsize: 10pt
geometry: margin=1.0in
bibliography: ./bibtex.bib
csl: ./quaternary-geochronology.csl
tblPrefix: Table
figPrefix: Figure
secPrefix: Section
indent: true
header-includes:
    - \usepackage{lineno}
    - \linenumbers
    - \usepackage{setspace}
    - \doublespacing
---

<!-- Affiliations -->

> ^1^Department of Life and Environmental Sciences, University of California, Merced, CA
> 
> ^2^Museum of Paleontology, University of California, Berkeley, CA, https://orcid.org/0000-0003-1292-6356
> 
> ^3^Department of Earth System Science, University of California, Irvine, Irvine, CA, USA.
>
> ^\*^Corresponding author: rtrayler@ucmerced.edu

<!-- this will complete the manuscript using pandoc -->

<!-- pandoc -s -f markdown+mark -o manuscript.pdf --pdf-engine=xelatex --filter pandoc-crossref --citeproc --number-sections manuscript.md --> 

<!-- pandoc -s -f markdown+mark -o manuscript.docx --pdf-engine=xelatex --filter pandoc-crossref --citeproc manuscript.md --reference-doc=reference.docx --> 

# Abstract {.unnumbered}

# Introduction {#sec:introduction}

Asphalt seep *lagerstätten*, colloquially known as "tar pits", have produced remarkable fossil assemblages, giving an unparalleled look into the ecology of floras and faunas during the late Pleistocene and Holocene (see reviews in @stock1992 and @mcdonald2015). Tar pits form when natural tar seeps through subsurface fractures to form a viscous sticky layer on the surface. This tar tends to trap animal and plant remains, leading to large accumulations of fossils. Importantly the rapid entrapment and later impregnation of tar into the remains can preserve fossils in environments where local conditions are otherwise not amenable to long term preservation (e.g., the neotropics; @lindsey2015), and therefore act as an important source of information about these ecosystems. The notable morphological preservation of tar impregnated fossils comes at a cost however, for studies interested in applying geochronological (^14^C~collagen~) [@fuller2014; @okeefe2023; @fuller2015; @fox-dobbs2014] or stable isotope techniques (δ^13^C~collagen~) [@fox-dobbs2006; @fox-dobbs2007; @coltrain2004; @fuller2020]. Natural tar is 80-90% carbon by weight and is radiocarbon-dead. Consequently, even a small amount of tar is a potent contaminant that can bias ^14^C~collagen~ and δ^13^C~collagen~ measurements, and it must be removed prior to geochemical analysis [@fuller2014; @coltrain2004; @fox-dobbs2006]. Briefly, the current best practice for extracting collagen from tar impregnated fossils involves repeatedly washing an aliquot of bone powder with organic solvents followed by acid digestion of the bone mineral, and finally collagen purification by ultrafiltration [@fuller2014]. Taken together, these methods require multiple days of work, large sample sizes (~150 mg) and due to variations in collagen preservation, may not yield viable collagen for further analysis. Therefore, identifying fossils with well-preserved collagen *prior* to tar removal and collagen extraction can reduce unnecessary damage to fossil collections, lower analytical costs, and improve research outcomes for geochemical studies of these fossils. 

In this study we investigate potential screening methods to identify tar impregnated fossils with a high likelihood of collagen preservation. We developed a training data set of fossils from two geographically distinct seep areas in California, Rancho La Brea in Los Angeles County and McKittrick in Kern County, where the collagen preservation state was known from previous studies. These data were used to test two potential screening methods: visual, non-destructive, taphonomic scoring [@behrensmeyer1978] and minimally-destructive Fourier Transform Infrared (FTIR) spectroscopy. We calculated several commonly used FTIR indices to assess diagenesis in bone as well as a new index to assess tar impregnation. We used this initial training data to identify the most useful predictors of collagen preservation that can be used to predict collagen preservation in other fossils. We used these predictions to select additional fossils for collagen extraction that address the limitations of our initial training data, resulting in a robust, freely available reference data set that can be used to screen tar seep fossils for further analysis. 

![Workflow of model development.](./figures/workflow.pdf){#fig:workflow}

# Background {#sec:background}

## Depositional and Curatorial Context

### McKittrick 

The McKittrick tar seeps are located along the eastern edge of the Temblor Range in the Southern San Joaquin Valley of California, just outside the town of McKittrick. Here, faulting allows oil to migrate from the underlying shale through porous sandstones of the Etchegoin and Tulare formations to form layers of asphaltum in a NW-SE trending brea belt.  The faunas appear to span from the late Pleistocene into the Holocene and the small number of radiocarbon dates for the locality support a late Pleistocene age for the majority of the fossils [@france2008; @fox-dobbs2014].

Specimens used in the current study are from collections made by University of California personnel and by Charles Sternberg for both the University of California and California Institute of Technology which primarily took place from 1921-1927 in several different pits [@merriam1921; @stock1928; @schultz1938; @sternberg1932]. As reported by @sternberg1932, fossils from McKittrick were cleaned using kerosene on site, which removed most surface tar.  Based on direct examination of the collections, plaster was also used in joining broken bones, and there is no indication that animal hide glues were used in preparation.

### Rancho La Brea

The Rancho La Brea tar seeps occur in the northern part of the Los Angeles Basin, south of the Santa Monica Mountains, in urban Los Angeles that has produced a diverse fauna spanning the late Pleistocene to Holocene (see @stock1992). The tar seeps form pools of liquid asphaltum, that act as natural traps. The fossils included in this study are from University of California excavations conducted from 1908-1912 [@merriam1911; @stoner1913] and include those with radiocarbon dates reported in @okeefe2009 and stable isotope analysis from @fox-dobbs2006.

==P. Holroyd will expand this==

## Bone Collagen Preservation and Isolation {#sec:background_collagen}

Bone is a composite material with an organic and mineral component, both of which are common tissues for geochemical analysis. The mineral fraction is bioapatite [Ca~4~(PO~4~)~3~OH] with carbonate (CO~3~) substitutions in the hydroxyl and phosphate sites [@driessens1990; @elliott2002]. The organic phase is primarily collagen [@collins2002]. Collagen is relatively insoluble and can persist in bone for tens of thousands of years [@collins2002; @clementz2012]. The high collagen content of bone has made it a tissue of choice for many paleontologists and archaeologists interested in stable (δ^13^C, δ^15^N) and radioactive (^14^C) isotope analysis of fossil specimens. However, collagen preservation can vary considerably between localities depending on a variety of taphonomic factors.  

Collagen preservation in modern and fossil specimens is usually assessed using a combination of collagen yield, carbon and nitrogen content, and the atomic carbon-to-nitrogen ratio (C:N~atomic~). The amino acid profile of collagen is relatively conservative across a variety of taxonomic groups [@szpak2011] allowing broad comparisons of these parameters. Collagen content in fresh bone ranges from 12 - 33% with an average of about 22% [@vanklinken1999; @collins2002; @ambrose1990]. Low collagen yield in fossil specimens can indicate degradation and loss of amino acids [@vanklinken1999], potentially also indicating changes in stable and or radioactive isotope composition. Likewise low carbon and nitrogen contents can indicate alteration [@guiry2020]. Several C:N~atomic~ ranges have been proposed as indicative of well preserved collagen including 2.9–3.6 [@ambrose1990], 3.1–3.5 [@vanklinken1999], and a variety of taxon specific ranges [@guiry2021]. Weathering is another potential pathway of collagen loss [@koch1999; @trueman2004; @koch1999], although it may be less pronounced in temperate climates [@fernandez-jalvo2010].

## The Problem of Tar

Collagen is also susceptible to contamination from a variety of sources, including endogenous lipids, humic acids, and non-collagenous proteins [@guiry2021]. In particular, lipids and humics have high carbon, but low nitrogen, contents and lead to C:N~atomic~ higher than the accepted ranges (e.g., > 3.6). Tar is a particularly potent contaminant; it has a very high carbon content, readily impregnates bone pore space, and is pernicious and difficult to completely remove. Several methods have been developed to purify and extract collagen from tar-impregnated fossils [@coltrain2004; @fox-dobbs2006; @fuller2014; @fuller2015] that follow a similar set of steps. First, bone (powder or chunks) is repeatedly washed with solvents (e.g., toluene, methanol, acetone) to extract the tar. Second, bone bioapatite is dissolved using either acid or chelating agents, leaving isolated collagen. While these methods differ in their specific details, in all cases the tar removal is a complex, time consuming process (~3 days, @coltrain2004; 5-6 days, @fox-dobbs2006; 2-3 days, @fuller2014). Finally, even after these steps, not all specimens will yield viable collagen. Collagen preservation can vary substantially between tar-pit deposits. For example, @coltrain2004 reported that 13 of 143 bones from Rancho La Brea failed to yield collagen (8% failure), whereas @france2008 (following the methods of @coltrain2004) reported a 78% failure rate (22 of 28) for fossils from McKittrick. Similarly, preliminary attempts at collagen extraction for this study from randomly selected McKittrick fossils yielded a success rate of 28%. 

## Infrared Spectroscopy {#sec:background_ftir}

![Representative example ATR-FTIR spectra for bone with/ without preserved collagen and McKittrick tar. Vertical dashed lines indicate band positions from @tbl:bands. Carbonate, phosphate, and amide bands are only applicable to bone spectra while the lipid bands occur in in both materials. A) full spectrum for all materials. Bottom Panel: zoomed view of the B) phosphate, C) amide/ carbonate, and D) lipid regions highlighted by colored boxes in panel A.](./figures/spectra.pdf){#fig:spectra}

Attenuated Total Reflectance Fourier Transform Infrared Spectroscopy (ATR-FTIR), is a minimally destructive vibrational spectroscopic technique that characterizes the molecular functional groups of a material by irradiating it with infrared light. Since molecular structure determines which infrared wavelengths are transmitted or absorbed, ATR-FTIR can be used to attribute absorbance bands to different functional groups, and semi-quantitatively determine the chemical composition of a material [@stuart1991]. 

Within the context of paleontological and archaeological specimens, ATR-FTIR is often used to investigate the crystal-chemical properties of bone bioapatite and collagen, with a particular focus on diagenesis and alteration during fossilization [@roche2010; @hassan1977; @sponheimer1999; @chadefaux2009]. The absorbance band-positions of the major components of bone are known; including inorganic phosphate (PO~4~) and carbonate (CO~3~) [@sponheimer1999; @fleet2009],  and organic amides and lipids [@chadefaux2009; @liden1995; @lebon2016] (@tbl:bands; @fig:spectra). Infrared spectra of tar contains multiple absorbance bands that partially, or completely overlap with amide, carbonate, and lipid band positions in collagen, (@fig:spectra) and the degree to which this overprinting may interfere with accurate identification collagen contents is unclear. Previous work has shown that FTIR is an effective tool at identifying organic preservation in archaeological contexts [@lebon2016], but to our knowledge, there have been no prior attempts to apply the methodology to tar impregnated fossils. 

|  band position (cm^-1^) |    Functional Group     |
|:-----------------------:|:-----------------------:|
|           2925          | Lipid                   |
|           2854          | Lipid                   |
|           1650          | Amide I                 |
|           1551          | Amide II                |
|           1545          | A-Type Carbonate        |
|           1415          | B-Type Carbonate        |
|           1231          | Amide III               |
|           1020          | Phosphate               |
|            880          | Carbonate               |
|            605          | Phosphate               |
|            565          | Phosphate               |

Table: Nominal FTIR band positions of several relevant chemical groups. Actual band positions may be shifted by several cm^-1^. {#tbl:bands}

# Materials and Methods {#sec:methods}

## Sample Selection {#sec:method_selection}

We selected specimens from the University of California, Museum of Paleontology (UCMP) collection where radiocarbon dating and/or isotopic analysis (δ^13^C, δ^15^N, ^14^C) of the organic collagen fraction has previously been attempted (@tbl:sample_numbers) as part of other research projects [@okeefe2009; @fox-dobbs2006; @fox-dobbs2014] ==Ask J. Southon how to cite the unpublished UCMP data==.  These specimens fall into two groups: 1) fossils that produced viable, well-preserved collagen(n = 50) and 2) fossils that failed to yield viable collagen(n = 20). We considered collagen to be well-preserved if it passed the standard metrics for collagen preservation (see reviews of @guiry2020; @guiry2021) as reported by the original study authors. We collected 5-10 mg of cortical bone powder using a handheld rotary tool and a dental drill bit. These powders were stored in 1.5 mL micro-centrifuge vials prior to analysis. Additionally, the bone powders were not chemically treated to remove tar [@fuller2014], or otherwise treated to remove carbonates or organics [@koch1997], prior to FTIR analysis. All specimens are from either Rancho La Brea (n = 48) or McKittrick (n = 22) and cover a wide range of carnivore and herbivore taxa, and include mammals, birds, and reptiles. 

|     Locality    |  Collagen  | No Collagen | Collagen Preservation % |
|:---------------:|:----------:|:-----------:|:-----------------------:|
| Rancho La Brea  |     43     |       5     |           90%           |
|   McKittrick    |      7     |      15     |           31%           |

Table: Number of specimens in the well preserved and poorly preserved groups for Rancho La Brea and McKittrick asphalt seeps. {#tbl:sample_numbers}

## FTIR Indices {#sec:methods_indices}

ATR-FTIR spectra were collected for all fossil specimens using a *Bruker Vertex 70 Far-Infrared Fourier Transform Infrared Spectrometer* from the Nuclear Magnetic Resonance Facility at the University of California, Merced. The spectra were collected from 400 to 4000 cm-1 over 32 scans at a spectral resolution of 4 cm^-1^. Each spectrum was background-corrected using several baseline points and slightly smoothed prior to index calculation using custom R scripts modified from those of @trayler2023a, available in the supplementary material.

The resulting 70 spectra were used to calculate two FTIR indices commonly used to investigate organic content and diagenesis in fossil bone. The Water-Amide-on-Phosphate-Index (WAMPI) is the ratio of the Amide-I and ν~2~PO~4~ phosphate absorbance bands ($\frac{B_{1650}}{B_{605}}$) tracks bone collagen content where higher WAMPI values should indicate more prominent amide-I bands and by proxy better collagen preservation [@roche2010; @lebon2016; @trayler2023a]. The Phosphate-Crystalinity-Index (PCI) is the sum of the ν~2~PO~4~ and ν~4~PO~4~ phosphate absorbance band maxima, normalized by the depth of valley between these two peaks ($\frac{B_{605} + B_{565}}{V_{590}}$; [@sponheimer1999]). Since increases in bone crystallinity sharpen the two phosphate peaks and deepen the valley, higher PCI reflect greater diagenetic alteration of the bone mineral [@sponheimer1999].  Furthermore, higher PCI values can also reflect heat-induced changes to crystal order and structure, resulting from deliberate (cultural) or natural burning (wildfires), which is also expected to remove organic material [@thompson2009; @thompson2013]. 

We also calculated the ratio of two lipid absorbance bands [@liden1995] normalized to the ν~2~PO~4~ phosphate absorbance band ($\frac{B_{2925} + B_{2854}}{B_{605}}$). Endogenous lipids exhibit prominent absorbance bands at about 2925 cm^-1^ and 2854 cm^-1^, as does McKittrick and Rancho La Brea asphaltum (@fig:spectra). Thus, this Lipid-on-Phosphate-Index (LPI) should reflect excess tar or lipid content in bone. While the loss of endogenous lipids is variable in the fossil record [@koch1999; @collins2002], tar seep fossils are impregnated with oils which has been proposed as a "preservative" [@stock1992], suggesting that higher LPI values could correspond to better collagen preservation.

## Taphonomy and Weathering Stages

To assess if visual assessment of weathering was a reliable indicator of collagen preservation, we scored each specimen according to the set of weathering stages established by @behrensmeyer1978 for large mammals and using images in  @behrensmeyer2012 and @fernandez-jalvo2016  as visual referents. These stages are numbered 0 to 5, with stage 0 showing no modification and stage 5 showing significant splintering, flaking, and being easily broken. If weathering is a significant factor, we would expect specimens with less collagen to have higher weathering scores. ==P. Holroyd will expand this if needed==

## Collagen Isolation and Analysis

We attempted to extract collagen from a subset of fossils to validate model performance (discussed below in @sec:validation). Collagen was isolated at the UC Irvine Keck Carbon Cycle AMS Laboratory following the procedure of @fuller2014 for tar impregnated fossils. Extracted collagen was analyzed using a  **some kind of Elemental analyzer coupled with some kind of mass spectrometer(?)**  ==check with J. Southon on exact methods==

## Statistical Methods 

### Statistical Analyses {#sec:methods_statistics}

To determine the best predictors of collagen preservation, we used the weathering scores and FTIR indices from the fossils of known collagen preservation to develop a training dataset to assess which predictors are most strongly associated with collagen presence or absence. We fit a logistic regression model in the form of:

$$ln(odds) = ln(\frac{p}{1-p}) = \beta\times x + \alpha$$ {#eq:logistic}

to each predictor (WAMPI, PCI, LPI, weathering score) separately, where *p* is the probability of collagen preservation (between 0 and 1), *x* is the value of an individual predictor with probability *p*, and *β* and *α* are regression coefficients. These logistic regression models were used to predict collagen presence for each fossil using a log-odds > 1 as a classification threshold, such that specimens where *p ≥ 0.5* were predicted to contain collagen and specimens where *p < 0.5* were predicted to lack collagen.

Model performance was assessed by calculating the sensitivity and specificity of each logistic regression model to determine the most useful predictor(s) for collagen presence. Sensitivity is defined as:

$$sensitivity = \frac{true~positives}{true~positives + false~negatives}$$

and specificity as:

$$specificity = \frac{true~negatives}{true~negatives + false~positives}$$

Both sensitivity and specificity vary between 0 and 1, and in general, higher values for both indicate better model performance. A perfectly performing model that predicts zero false negatives and zero false positives would therefore have both a sensitivity and specificity of 1. However, a model that *always* predicts the presence of collagen, regardless of preservation state, would have a high sensitivity (~ 1), and a low specificity (~ 0), with the opposite being true for a model that always predicts the absence of collagen. Therefore, an ideal model is both sensitive and specific, with both values close to one.

# Results & Discussion {#sec:results}

## Training Data

| Predictor |  *α*  |  *β*  | *p* value | Threshold | Sensitivity | Specificity|
|:---------:|:-----:|:-----:|:---------:|:---------:|:-----------:|:----------:|
| WAMPI     | -9.13 | 21.06 |   0.003   |   0.43    |     0.96    |   0.90     |
| PCI       | 13.80 | -4.05 |   0.004   |   3.40    |     0.92    |   0.30     |
|Weathering Score | 2.06 | -0.93 | 0.001|     2     |     0.94    |   0.25     |
| LPI       | -0.49 |  1.47 |   0.057   |   0.34    |     1.00    |   0.05     |

Table: Summary of training data logistic regression results. Model coefficients (*α*, *β*) correspond to @eq:logistic. The *Threshold* column indicates the predictor value with an odds-ratio of 1. If *β* is positive then *Predictor* values higher than the *Threshold* predict collagen presence, whereas if *β* is negative, *Predictor* values lower than the *Threshold* predict collagen presence. {#tbl:logistic}

![Training data logistic regression results for each of the four possible predictors of collagen presence [A) WAMPI, B) PCI, C) LPI, D) Weathering Stage]. The vertical dashed line is the predictor value with an odds-ratio of 1 which we used as the prediction threshold (see @tbl:logistic for details). Blue dots indicate samples with known collagen preservation and yellow dots indicate samples with known collagen absence. Points have been vertically-jittered slightly for visual clarity.](./figures/logistic.pdf){#fig:logistic}

The WAMPI, PCI, and weathering score logistic regression model-fits were statistically significant, and the LPI was not. The Water-Amide-on-Phosphate Index was the best performing predictor and is both highly sensitive and specific when predicting collagen presence and absence (@tbl:logistic). The WAMPI is calculated using the Amide-I band height which directly correlates to bone nitrogen and organic content [@lebon2016; @roche2010]. The Phosphate-Crystallinity Index and weathering scores are highly sensitive, but are only weakly specific. Both models have negative *β* coefficient, indicating increasing predictor values correspond to lower collagen preservation (@fig:testing). Weathering scores and PCI track taphonomic processes; macro scale weathering and microscopic apatite recrystallization, respectively. In other words, high degrees of weathering (high PCI, high weathering score), is somewhat predictive of collagen absence, but less weathering is not necessarily predictive of collagen presence. The proposed Lipid-on-Phosphate Index performed poorly and was not able to distinguish collagen presence or absence.

## Validation {#sec:validation}

To validate model performance, we collected FTIR spectra on 235 other UCMP McKittrick fossils for which collagen preservation was unknown. Using these data we calculated the best performing FTIR index (WAMPI) to predict collagen presence. A WAMPI threshold of 0.43 (@tbl:logistic) predicts that 75 of 235 fossils (31%) have preserved collagen, similar to the rate we observed from random selection of McKittrick fossils (28%). From these 235 fossils we selected 67 for attempted collagen extraction; 18 were predicted to contain no collagen (WAMPI < 0.43) and 49 were predicted to have well preserved collagen (WAMPI > 0.43).

![Plot of the PCI and WAMPI FTIR indices for the A) training and B) validation data sets. These two indices have the highest combined sensitivity and specificity. The colored ellipses on both panels contain 95% of the *training* data in each group. The horizontal dashed line indicate the initial WAMPI classification threshold of 0.43 (@tbl:logistic). A) Initial training data colored by collagen presence or absence. B) Model validation results using 67 fossils with unknown collagen preservation. The perimeter color of each point in B) indicates the WAMPI based prediction of presence/absence and the fill color indicates actual collagen presence/ absence. The colored ellipses and horizontal dashed line are the same as shown in the left panel.](./figures/training.pdf){#fig:testing}

Of the 67 fossils in the validation set, 34 produced well preserved collagen (C:N~atomic~ = 3.30±0.08, mean±1S.D); 32 from the group predicted to contain collagen, and 2 from the group predicted to contain no collagen (@fig:testing). Given that the underlying collagen preservation rate in McKittrick fossils appears to about 20-30%, a 65% chance of successfully extracting collagen is a substantial improvement. However, the validation dataset had a sensitivity of 0.94 and a specificity of 0.5. While the sensitivity of the validation data is similar to that of the training data (@tbl:logistic), the specificity is notably lower. This suggests that when applied to only McKittrick fossils, the training classification threshold (WAMPI > 0.43) has a higher false positive rate. This is likely because of imbalances in the training data set. About 80% of training samples with well preserved collagen are from Rancho La Brea, whereas 76% of the samples without preserved collagen are from McKittrick which reflects the underlying preservation rate of the two localities.

## Combined Data and Use

To address the mismatch in the training data set, we combined the training and validation data sets and recalculated the WAMPI logistic regression model (@tbl:final_logistic). The sensitivity and specificity for the combined data are both 0.87, indicating a low false positive and low false negative rate. The threshold with a greater than 50% chance of collagen preservation is slightly higher (WAMPI > 0.5) than the training data threshold. Importantly, it should be noted however that our choice of an odds-ratio of 1 (> 50% preservation probability) is somewhat arbitrary, and that other thresholds could be calculated and used depending on the needs of a particular study (@fig:combined). Rearranging @eq:logistic to solve for the threshold and using the regressions coefficient in @tbl:final_logistic gives:

$$WAMPI~threshold = \frac{ln(odds) - \alpha}{\beta} = \frac{ln(odds) + 6.94}{13.9}$$  

Which can be used to calculate classification thresholds at arbitrary probabilities. For example, a higher odds-ratio of 3 (> 75% preservation probability) gives a WAMPI threshold of 0.58 and an odds-ratio of 19 (> 95% preservation probability) gives a WAMPI threshold of 0.78 (@fig:combined). These higher odds ratios come with a corresponding higher false-negative rate however, if fossils are abundant, then this trade off may be worthwhile to ensure only the best-preserved specimens are chosen for further geochemical work.


| Predictor |  *α*  |  *β*  | *p* value | Threshold | Sensitivity | Specificity|
|:---------:|:-----:|:-----:|:---------:|:---------:|:-----------:|:----------:|
|   WAMPI   | -6.94 |  13.9 |  1×10^-8^ |   0.50    |     0.87    |    0.87    |

Table: Logistic regression result for the Water-Amide-on-Phosphate Index using the combined, training and validation datasets. {#tbl:final_logistic}

![Plot of final reference data set (training and validation data combined). A) Plot of PCI and WAMPI FTIR indices for the combined data set. The colored ellipses contain 95% of the data in each group. The horizontal dashed lines indicate the 50%, 75%, and 95% WAMPI thresholds. B) Final logistic regression model using the Water-Amide-on-Phosphate index for the combined data set. The vertical dashed lines indicate the 50%, 75%, and 95% preservation probability WAMPI thresholds.](./figures/combined_logistic.pdf){#fig:combined}

# Conclusions {#sec:conclusions}

Preparing tar seep fossils for isotope analysis (δ^13^C, δ^15^N, ^14^C) is costly, time consuming, and can be hampered by poor collagen preservation. Here we have presented methods and a reference data set for quickly identifying tar seep fossils with a high likelihood of collagen preservation. Entirely non-destructive visual taphonomic indicators and the amount of impregnating tar are moderate to poor predictors of collagen preservation. In contrast, minimally destructive FTIR analysis is highly sensitive and specific, sampling and data collection are rapid, and Fourier Transform Infrared spectrometers are available at most major research universities. TheWater-Amide-on-Phosphate index is the best predictor, and predictive threshold of > 0.5 is effective at identifying tar impregnated fossils with preserved collagen. This threshold performs well for both Rancho La Brea and McKittrick tar pit fossils and is likely broadly applicable to other tar pit fossils. The underlying data and code are freely available, such that it can be used as a screening tool for fossils from other tar pit deposits and strengthened by the inclusion of additional data. Given the increasing interest in other tar pit faunas  [e.g., @solorzano2015; @lindsey2015; @seymour2015], and the associated difficulties in  excavating and curating these specimens, minimizing large-scale destructive sampling is crucial to continues research on these faunas. 

# Supplementary Information {#sec:sup_info}

All data (infrared spectra, collagen preservation state, taxonomic details) and analysis code are available at [github.com/robintrayler/mckittrick_FTIR](https://github.com/robintrayler/mckittrick_FTIR)

# Acknowledgments

We would like to thank HyeJoo Ro and Dr. Gina Palefsky for their help with sample collection, and Dr. David Rice for his assistance with FTIR data collection, and Dr. Elizabeth Black for her advice on statistical analyses. This work was supported by NSF-EAR-2138163 (RBT and SLK) and NSF-EAR-2138164 (PAH). 

# Author Contributions

RBT, SLK, and PAH conceived the project. RBT, LEL, and PAH collected the screening data. JRS extracted performed collagen extractions. RBT, LEL, SLK, and PAH developed the statistical framework. RBT, LEL, and PAH wrote the manuscript with input from all authors. 

\pagebreak

# References {.unnumbered}
:::{#refs}
:::