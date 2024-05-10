---
title: "Rapid, Effective Screening of Tar Seep Fossils for Radiocarbon and Stable Isotope Analysis"
author:
  - ^1^Robin B. Trayler
  - ^1^Lauren Lopes
  - ^2^Patrica A. Holroyd
  - ^1^Sora L. Kim
  - ^3^John R. Southon 

mainfont: "Helvetica"
fontsize: 12pt
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
> ^2^Museum of Paleontology, University of California, Berkeley, CA
> 
> ^3^Department of Earth System Science, University of California, Irvine, Irvine, CA, USA.
>
> ^\*^Corresponding author: rtrayler@ucmerced.edu

<!-- this will complete the manuscript using pandoc -->

<!-- pandoc -s -f markdown+mark -o manuscript.pdf --pdf-engine=xelatex --filter pandoc-crossref --citeproc --number-sections manuscript.md --> 

<!-- pandoc -s -f markdown+mark -o manuscript.docx --pdf-engine=xelatex --filter pandoc-crossref --citeproc manuscript.md --reference-doc=reference.docx --> 

# Abstract {.unnumbered}

\newpage

# Introduction {#sec:introduction}

Asphalt seep *laggerstätte*, colloquially known as "tar pits", have produced remarkable fossil assemblages, giving an unparalleled look into the ecology of floras and faunas during the late Pleistocene and Holocene (see reviews of 
@stock1992 and @mcdonald2015). Tar pits form when natural tar seeps through subsurface fractures to form a viscous sticky layer on the surface. This tar tends to trap animal and plant remains, leading to large accumulations of fossils. Importantly the rapid entrapment and later impregnation of tar into the remains can preserve fossils in environments where local conditions are otherwise not amenable to long term preservation (e.g., the neotropics; @lindsey2015), and therefore act as an important source of information about these ecosystems. The remarkable morphological preservation of tar impregnated fossils comes at a cost however, for studies interested in applying geochronological (^14^C~collagen~) [@fuller2014; @okeefe2023; @fuller2015; @fox-dobbs2014] or stable isotope techniques (δ^13^C~collagen~) [@fox-dobbs2006; @fox-dobbs2007; @coltrain2004; @fuller2020] to tar pit fossils. Natural tar is 80-90% carbon by weight and is radiocarbon-dead. As a consequence, even a small amount of tar is a potent contaminant that can bias ^14^C~collagen~ and δ^13^C~collagen~ measurements, and it must be removed prior to geochemical analysis [@fuller2014; @coltrain2004; @fox-dobbs2006]. Briefly, the current best practice for extracting collagen from tar pit fossils involves repeatedly washing an aliquot of bone powder with organic solvents followed by acid digestion of the bone mineral, and finally collagen purification by ultrafiltration [@fuller2014]. Taken together, these methods require multiple days of work, large sample sizes (~150 mg) and due to variations in collagen preservation, may not yield viable collagen for further analysis. Therefore, identifying fossils with well preserved collagen *prior* to tar removal and collagen extraction can reduce unnecessary damage to fossil collections, reduce analytical costs, and improve research outcomes for geochemical studies of these fossils. 

In this study we investigate potential screening methods to identify tar pit fossils with a high likelihood of collagen preservation. We developed a training data set of fossils from two localities in California, the Rancho La Brea and McKittrick tar pits, where the collagen preservation state was known from previous studies. These data were used to test two potential screening methods, visual, non-destructive, taphonomic scoring [@behrensmeyer1978] and minimally-destructive Fourier Transform Infrared (FTIR) spectroscopy. We calculated several commonly used FTIR indices to assess diagenesis in bone as well as a new index to assess tar impregnation. Our results show that weathering stage is a poor predictor of collagen preservation in tar pit fossils, however, FTIR is a powerful tool and can be used to quickly screen fossils for further analysis.

![Workflow of model development.](./figures/workflow.pdf){#fig:workflow}

# Background {#sec:background}

## Depositional and Curatorial Context

### McKittrick 

The McKittrick tar seeps are located along the eastern edge of the Temblor Range in the Southern San Joaquin Valley of California, just outside the town of McKittrick. The stratigraphy of the locality was not well documented during these early excavations, and is poorly understood. However, the faunas appear to span from the late Pleistocene into the Holocene and the small number of radiocarbon dates for the locality support a late Pleistocene age for the majority of the fossil [@fox-dobbs2014; @france2008]. Tar seep activity at McKittrick appears to have been somewhat different than Rancho La Brea. Rather than pooling on the surface, McKittrick tar permeated surficial sediments forming a pliable "asphalt", that slowly incorporated bones. ==Statement about environment and taphonomy here?==

University of California Museum of Paleontology ==(?)== excavations at the McKittrick quarry primarily took place in the 1920s with further small collections made in the 1940s [@stock1928; @merriam1921; @schultz1938; @sternberg1985]. ==Pat can you add some details about the treatment of McKittrick fossils?==

### Rancho La Brea

==Pat can you add a similar section about the UCMP rancho la brea collections?==

## Bone Collagen Preservation and Isolation {#sec:background_collagen}

Bone is a composite material with organic and mineral component, both of which are common tissues for geochemical analysis. The mineral fraction is bioapatite [Ca~4~(PO~4~)~3~OH] with carbonate (CO~3~) substitutions in the hydroxyl and phosphate sites [@driessens1990; @elliott2002]. The organic phase is primarily collagen [@collins2002]. Collagen is relatively insoluble and can persist in bone for tens of thousands of years [@collins2002; @clementz2012]. The high collagen content of bone has made it a tissue of choice for many paleontologists and archaeologists interested in stable (δ^13^C, δ^15^N) and radioactive (^14^C) isotope analysis of fossil specimens. However, collagen preservation can vary considerably between localities depending on a variety of taphonomic factors.  

Collagen preservation in modern and fossil specimens is usually assessed using a combination of collagen yield, carbon and nitrogen content, and the atomic carbon-to-nitrogen ratio (C:N~atomic~). The amino acid profile of collagen is relatively conservative across a variety of taxonomic groups [@szpak2011]. Collagen content in fresh bone is ranges from 12 - 33% with an average of about 22% [@vanklinken1999; @collins2002; @ambrose1990]. Low collagen yield in fossil specimens can indicate degradation and loss of amino acids [@vanklinken1999], potentially also indicating changes in stable and or radioactive isotope composition. Likewise low carbon and nitrogen contents can indicate alteration [@guiry2020]. Several C:N~atomic~ thresholds have been proposed as indicative of well preserved collagen including 2.9–3.6 [@ambrose1990], 3.1–3.5 [@vanklinken1999], and a variety of of taxon specific ranges [@guiry2021]. 

## The Problem of Tar

Collagen is also susceptible to contamination from a variety of sources, including endogenous lipids, humic acids, and non-collagenous proteins [@guiry2021]. In particular, lipids and humics have high carbon, but low nitrogen, contents and lead to C:N~atomic~ higher than the accepted thresholds. Tar, is a particularly potent contaminant; it has a very high carbon content, readily impregnates bone pore space, and is pernicious and difficult to completely remove. Several methods have been developed to purify and extract collagen from tar-impregnated fossils [@coltrain2004; @fox-dobbs2006; @fuller2014; @fuller2015] that follow a similar set of steps. First bone (powder or chunks) is repeated washed with solvents (e.g., toluene, methanol, acetone) to extract the tar. Second, bone bioapatite is dissolved using either acid or chelating agents, leaving isolated collagen. While these methods differ in their specific details, in all cases the tar removal is a complex, time consuming process (~3 days, @coltrain2004; 5-6 days, @fox-dobbs2006; 2-3 days, @fuller2014). Finally, even after these steps, not all specimens will yield viable collagen. Collagen preservation can vary substantially between tar-pit deposits. Fore example, @coltrain2004 reported that 13 of 143 bones from the Rancho La Brea Tar pits failed to yield collagen (8% failure), whereas @france2008 (following the methods of @coltrain2004) reported a 78% failure rate  (22 of 28) for McKittrick tar seep fossils. Similarly, preliminary attempts at collagen extraction for this study from randomly selected fossils yielded a success rate of 28%. 
  
## Infrared Spectroscopy {#sec:background_ftir}

Attenuated Total Reflectance Fourier Transform Infrared Spectroscopy (ATR-FTIR), is a minimally destructive vibrational spectroscopic technique that characterizes the molecular functional groups of a material by irradiating it with infrared light. Since molecular structure determines which infrared wavelengths are transmitted or absorbed, ATR-FTIR can be used to attribute absorbance bands to different functional groups, and semi-quantitatively determine the chemical composition of a material [@stuart1991]. 

|  band position (cm^-1^) |    Functional Group     |
|:-----------------------:|:-----------------------:|
|           2925          | Lipid                   |
|           2854          | Lipid                   |
|           1746          | Lipid                   |
|           1650          | Amide I                 |
|           1551          | Amide II                |
|           1545          | A-Type Carbonate        |
|           1415          | B-Type Carbonate        |
|           1231          | Amide III               |
|           1020          | Phosphate               |
|            880          | Carbonate               |
|            605          | Phosphate               |

Table: Nominal FTIR band positions of several relevant chemical groups. Actual band positions may be shifted by several cm^-1^. {#tbl:bands}

Within the context of paleontological and archaeological specimens, ATR-FTIR is often used to investigate the crystal-chemical properties of bone bioapatite and collagen, with a particular focus on diagenesis and alteration during fossilization [@roche2010; @hassan1977; @sponheimer1999; @chadefaux2009]. The absorbance band-positions of the major components of bone are know; including inorganic phosphate (PO~4~) and carbonate (CO~3~) [@sponheimer1999; @fleet2009],  and organic amides and lipids [@chadefaux2009; @liden1995; @lebon2016] (@tbl:bands). Previous work has shown that FTIR is an effective tool at identifying organic preservation in archaeological contexts [@lebon2016], but to our knowledge, there have been no attempts apply the methodology to extremely contaminated tar seep fossils.

# Materials and Methods {#sec:methods}

## Sample Selection {#sec:method_selection}

We selected tar seep bone specimens from the University of California, Museum of Paleontology (UCMP) collection where isotopic analysis (δ^13^C, δ^15^N, ^14^C) of the organic collagen fraction has previously been attempted (@tbl:sample_numbers) as part of other research projects [@fox-dobbs2006; @fox-dobbs2014] ==Ask J. Southon how to cite the unpublished UCMP data==.  These specimens fall into two groups; 1) Fossils that produced viable, well preserved collagen (n = 55) and 2) fossils that failed to yield viable collagen (n = 21). We considered collagen well preserved if it passed the standard metrics for collagen preservation (see reviews of [@guiry2020; @guiry2021]) as reported by the original study authors. We collected 5-10 mg of cortical bone powder using a Dremel® tool and a 0.5 mm inverted cone carbide dental drill bit. These powders were stored in 1.5 mL micro-centrifuge vials prior to analysis. The bone powders were not chemically treated to remove tar [@fuller2014] or otherwise altered (e.g., @koch1997) prior to FTIR analysis. All specimens are from either the Rancho La Brea (n = 49) or McKittrick (n = 27) tar seep localities and cover a wide range of carnivore and herbivore taxa, and include mammals, birds, and reptiles (@tbl:all_fossils). 

|     Locality    |  Collagen  | No Collagen | Collagen Preservation % |
|:---------------:|:----------:|:-----------:|:-----------------------:|
| Rancho La Brea  |    44      |      5      |           90%           |
|   McKittrick    |    11      |      16     |           41%           |

Table: Number of specimens in the well preserved and poorly preserved groups for Rancho La Brea and McKittrick asphalt seeps. {#tbl:sample_numbers}

## FTIR Indices {#sec:methods_indices}

ATR-FTIR spectra were collected for all fossil specimens using a *Bruker Vertex 70 Far-Infrared Fourier Transform Infrared Spectrometer* from the Nuclear Magnetic Resonance Facility at the University of California, Merced. The spectra were collected from 400 to 4000 cm-1 over 32 scans at a spectral resolution of 4 cm^-1^. Each spectrum was background-corrected using several baseline points and slightly smoothed prior to index calculation using custom R scripts available in the supplementary material.

These spectra were used to calculate two FTIR indices commonly used to investigate organic content and diagenesis in fossil bone. The Water-Amide-on-Phosphate-Index (WAMPI) is the ratio of the Amide-I and ν~2~PO~4~ phosphate absorbance bands ($\frac{B_{1650}}{B_{605}}$) tracks bone collagen content and higher WAMPI values should indicate better collagen preservation [@roche2010; @trayler2023a]. The Phosphate-Crystalinity-Index (PCI) is the sum of the ν~2~PO~4~ and ν~4~PO~4~ phosphate absorbance band maxima, normalized by the depth of valley between these two peaks ($\frac{B_{605} + B_{565}}{V_{590}}$; [@sponheimer1999]). Since increases in bone crystallinity sharpen the two phosphate peaks and deepen the valley, higher PCI reflect greater diagenetic alteration of the bone mineral [@sponheimer1999].  Furthermore, higher PCI values can also reflect heat-induced changes to crystal order and structure, resulting from deliberate (cultural) or natural burning (wildfires), which is also expected to remove organic material [@thompson2009; @thompson2013]. 

We also calculated the ratio of two lipid absorbance bands [@liden1995] normalized to the ν~2~PO~4~ phosphate absorbance band ($\frac{B_{2925} + B_{2854}}{B_{605}}$). Endogenous lipids exhibit prominent absorbance bands at about 2925 cm^-1^ and 2854 cm^-1^, as does McKittrick and Rancho La Brea tar. Thus this Lipid-on-Phosphate-Index (LPI) should reflect excess tar or lipid content in bone. While the loss of endogenous lipids is variable in the fossil record [@koch1999; @collins2002], tar seep fossils are impregnated with oils which has been proposed as a "preservative" [@stock1992], suggesting that higher LPI values could correspond to better collagen preservation. 

## Taphonomy and Weathering Scores

==P. Holroyd will write this==

<!-- Need to cite @behrensmeyer1978 and @spencer2003 --> 

## Statistical Analyses {#sec:methods_statistics}

To determine the best predictors of collagen preservation, we used the weathering scores and FTIR indices from the fossils of known collagen preservation to develop a training dataset to assess which predictors are most strongly associated collagen presence or absence. We fit a logistic regression model in the form of:

$$ln(odds) = ln(\frac{p}{1-p}) = \beta\times x + \alpha$$ {#eq:logistic}

to each predictor (WAMPI, PCI, LPI, weathering score) separately, where *p* is the probability of collagen preservation (between 0 and 1), *x* is an individual predictor, and *β* and *α* are model coefficients. These logistic regression models were used to predict collagen presence for each fossil using a log-odds > 1 as a classification threshold, such that specimens where *p ≥ 0.5* were predicted to contain collagen and specimens where *p ≤ 0.5* were predicted to lack collagen. 

Model performance was assessed by calculating the sensitivity and specificity of each logistic regression model to determine the most useful predictor(s) for collagen presence. Sensitivity is defined as: 

$$sensitivity = \frac{true~positives}{true~positives + false~negatives}$$

and specificity as: 

$$specificity = \frac{true~negatives}{true~negatives + false~positives}$$

Both sensitivity and specificity vary between 0 and 1, and in general, higher values for both indicate better model performance. A perfectly performing model that predicts zero false negatives and zero false positives would therefore have both a sensitivity and specificity of 1. However, a model that *always* predicts the presence of collagen would have a high sensitivity (~ 1), and low specificity (~ 0), with the opposite being true for a model that always predicts the absence of collagen. Therefore, an ideal model is both sensitive and specific, with both values close to one. 

# Results & Discussion {#sec:results}

## Logistic Regression {#sec:results_logistic}

| Predictor |  *α*  |  *β*  | *p* value | Threshold | Sensitivity | Specificity|
|:---------:|:-----:|:-----:|:---------:|:---------:|:-----------:|:----------:|
| WAMPI     | -9.13 | 21.06 |   0.003   |   0.43    |     0.96    |   0.90     |
| PCI       | 14.00 | -4.11 |   0.003   |   3.40    |     0.92    |   0.30     |
|Weathering Score | 2.07 | -0.91 | 0.001 |  2       |     0.94    |   0.25     |
| LPI       | -0.53 |  1.53 |   0.049   |   0.34    |     1.00    |   0.05     |

Table: Summary of logistic regression results. Model coefficients (*α*, *β*) correspond to @eq:logistic. All model fits were statistically significant (*p* < 0.05). The *Threshold* column indicates the predictor value with an odds-ratio of 1. If *β* is positive then *Predictor* values higher than the *Threshold* predict collagen presence, whereas if *β* is negative, *Predictor* values lower than the *Threshold* predict collagen presence. {#tbl:logistic}

![Logistic regression results for each of the four possible predictors of collagen presence. The vertical dashed line is the predictor value with an odds-ratio of 1 which we used as the prediction threshold (see @tbl:logistic for details). Blue dots indicate samples with known collagen preservation and yellow dots indicate samples with known collagen absence. Points have been vertically-jittered slightly for clarity.](./figures/logistic.pdf){#fig:logistic}

All logistic regression model-fits were statistically significant for all predictors, however, the Water-Amide-on-Phosphate Index was the best performing predictor and is both highly sensitive and specific when predicting collagen presence and absence (@tbl:logistic). The WAMPI is calculated using the Amide-I band height which directly correlates to bone nitrogen and organic content [@lebon2016; @roche2010]. The Phosphate-Crystallinity Index and weathering scores are highly sensitive, but are only weakly specific. Both models have negative *β* coefficient, indicating increasing predictor values correspond to lower collagen preservation (@fig:testing). Weathering scores and PCI track taphonomic processes; macro scale weathering and microscopic apatite recrystallization, respectively. In other words, high degrees of weathering (high PCI, high weathering score), is somewhat predictive of collagen absence, but less weathering is not necessarily predictive of collagen presence. The proposed Lipid-on-Phosphate Index performed poorly and was not able to distinguish collagen presence or absence.

![Plot of the PCI and WAMPI indices for the training data set. These two indices have the highest combined sensitivity and specificity. The colored ellipses contain 95% of the data in each group. The vertical and horizontal dashed lines indicate the classification thresholds for the PCI and WAMPI respectively (@tbl:logistic).](./figures/training.pdf){#fig:testing}

## Validation {#sec:validation}

![Model validation results using 67 fossils with unknown collagen preservation. The rim color of each point indicate the WAMPI based prediction of presence/absence and the fill color indicates actual collagen presence/ absence. The colored ellipses  and vertical dashed lines are the same as shown in @fig:testing.](./figures/validation.pdf){#fig:validation}

To validate model performance, we collected FTIR spectra on 239 other UCMP McKittrick fossils with unknown collagen preservation. Using these data we calculated the best performing FTIR index (WAMPI) to predict collagen presence. A WAMPI threshold of 0.43 (@tbl:logistic) predicts that 75 of 239 fossils (31%) have preserved collagen, similar to the rate we observed from random selection of McKittrick fossils (28%). From these 239 fossils we selected 67 addition fossil for attempted collagen extraction; 18 were predicted to contain no collagen (WAMPI < 0.43) and 49 were predicted to have well preserved collagen (WAMPI > 0.43). Collagen was isolated at the UC Irvine Keck Carbon Cycle AMS Laboratory using the procedure of @fuller2014 for tar impregnated fossils.

Of the 67 validation fossils, 34 produced well preserved collagen (C:N~atomic~ = 3.30±0.08, mean±1S.D); 32 from the group predicted to contain collagen, and 2 from the group predicted to contain no collagen. Combined, the validation dataset had a positive predictive value of 0.65 and negative predictive value of 0.88, meaning that, when applied to new data, the WAMPI is moderately accurate and predicting collagen presence and high accurate and predicting its absence. Given that the underlying collagen preservation rate in McKittrick fossils appears to about 20-30%, a 65% chance of successfully extracting collagen is a substantial improvement.

==could use a few more sentences here==

## Limitations and Biases and Improvements

One potential bias of our modeling is the uneven distribution of fossils from Rancho La Brea and McKittrick in the training data. About 80% of training samples will well preserved collagen are from Rancho La Brea, while 76% of the samples without preserved collagen are from McKittrick which reflects the underlying preservation rate of the two localities. Given this mismatch, a limitation of our modeling is that better "tuned" to detect McKittrick fossils without collagen than those with collagen. A clear solution to this problem is to  recalculate the prediction thresholds with  more well preserved McKittrick fossils in the training dataset. Our validation data set (@sec:validation) contains FTIR spectra for 67 additional McKittrick fossils, including 34 with good collagen preservation. Including these data in future threshold calculations would likely improve model performance. 

## Implications for McKittrick Deposition

* This seems like a good section to have
* Underlying collagen preservation rate at McKittrick appears to be about 30% (different from RLB)

# Conclusions {#sec:conclusions}

# Supplementary Information {#sec:sup_info}

# Acknowledgments

We thank HyeJoo Ro and Dr. Gina Palefsky for their help with sample collection, and Dr. David Rice for his assistance with FTIR data collection. This work was supported by NSF-EAR-2138163 (RBT and SLK) and NSF-EAR-XXXXXXX (PAH). 

\pagebreak

# References {.unnumbered}
:::{#refs}
:::

\pagebreak

| UCMP Catalog Number | locality | Taxon | Collagen Preserved | Publication |
|:-------------------:|:--------:|:-----:|:------------------:|:-----------:|
| 271245 | McKittrick | Antilocapridae | no |              |
| 153245 | McKittrick | *Arctodus simus* | yes | @fox-dobbs2014 |
| 271244 | McKittrick | Artodactyla | yes |    |
| 153252 | McKittrick | *Bison* | no |              |
| 153253 | McKittrick | *Bison* | no |              |
| 153254 | McKittrick | *Bison* | no |              |
| 153256 | McKittrick | *Bison* | no |              |
| 271241 | McKittrick | *Bison* | no |              |
| 271240 | McKittrick | *Camelops* | no |              |
| 153257 | McKittrick | *Cervus* *elaphus* | yes | @fox-dobbs2014 |
| 153246 | McKittrick | *Equus conversidens* | no |              |
| 153247 | McKittrick | *Equus conversidens* | no |              |
| 153250 | McKittrick | *Equus conversidens* | no |              |
|  27118 | McKittrick | *Euceratherium* | no |              |
| 271242 | McKittrick | *Euceratherium* | yes |              |
| 271243 | McKittrick | *Euceratherium* | no |              |
| 154372 | McKittrick | *Gopherus* | yes |              |
| 154411 | McKittrick | *Gopherus* | yes |              |
| 154250 | McKittrick | *Gopherus* | no |              |
|  33120 | McKittrick | *Mammut* | no |              |
| 271246 | McKittrick | *Odocoileus* | no |              |
| 271247 | McKittrick | *Odocoileus* | no |              |
| 153241 | McKittrick | *Panthera atrox* | yes | @fox-dobbs2014 |
| 149255 | McKittrick | *Teratornis merriami* | yes | @fox-dobbs2006 |
| 149256 | McKittrick | *Teratornis merriami* | yes | @fox-dobbs2006 |
| 149257 | McKittrick | *Teratornis merriami* | yes | @fox-dobbs2006 |
| 149258 | McKittrick | *Teratornis merriami* | yes | @fox-dobbs2006 |
| 271213 | Rancho La Brea | *Aenocyon dirus*  | yes |              |
| 271214 | Rancho La Brea | *Aenocyon dirus*  | yes |              |
| 271215 | Rancho La Brea | *Aenocyon dirus*  | yes |              |
| 271216 | Rancho La Brea | *Aenocyon dirus*  | yes |              |
| 271217 | Rancho La Brea | *Aenocyon dirus*  | yes |              |
| 271219 | Rancho La Brea | *Aenocyon dirus*  | yes |              |
| 271220 | Rancho La Brea | *Aenocyon dirus*  | yes |              |
| 271221 | Rancho La Brea | *Aenocyon dirus*  | yes |              |
| 271222 | Rancho La Brea | *Aenocyon dirus*  | yes |              |
| 271223 | Rancho La Brea | *Aenocyon dirus*  | yes |              |
| 271224 | Rancho La Brea | *Aenocyon dirus*  | yes |              |
| 259518 | Rancho La Brea | *Aenocyon dirus*  | yes |              |
| 259519 | Rancho La Brea | *Aenocyon dirus*  | yes |              |
| 259520 | Rancho La Brea | *Aenocyon dirus*  | yes |              |
| 259521 | Rancho La Brea | *Aenocyon dirus*  | yes |              |
| 259522 | Rancho La Brea | *Aenocyon dirus*  | yes |              |
| 259523 | Rancho La Brea | *Aenocyon dirus*  | yes |              |
| 259524 | Rancho La Brea | *Aenocyon dirus*  | yes |              |
| 259525 | Rancho La Brea | *Aenocyon dirus*  | yes |              |
| 259491 | Rancho La Brea | *Bison*     | yes |              |
| 259492 | Rancho La Brea | *Bison*     | yes |              |
| 259493 | Rancho La Brea | *Bison*     | yes |              |
| 158263 | Rancho La Brea | *Camelops*                | yes |              |
| 158271 | Rancho La Brea | *Camelops*                | yes |              |
| 158276 | Rancho La Brea | *Camelops*                | yes |              |
| 158277 | Rancho La Brea | *Camelops*                | yes |              |
| 158279 | Rancho La Brea | *Camelops*                | yes |              |
| 158281 | Rancho La Brea | *Camelops*                | no  |              |
| 271225 | Rancho La Brea | *Camelops*                | yes |              |
| 271226 | Rancho La Brea | *Camelops*                | yes |              |
| 271227 | Rancho La Brea | *Camelops*                | yes |              |
| 271228 | Rancho La Brea | *Camelops*                | no  |              |
| 271229 | Rancho La Brea | *Camelops*                | no  |              |
| 271230 | Rancho La Brea | *Camelops*                | yes |               |
| 271231 | Rancho La Brea | *Camelops*                | yes |               |
| 271232 | Rancho La Brea | *Camelops*                | yes |               |
| 271234 | Rancho La Brea | *Camelops*                | no  |                  |
| 259507 | Rancho La Brea | *Canis latrans*           | yes |                  |
| 259508 | Rancho La Brea | *Canis latrans*           | yes |                  |
| 259509 | Rancho La Brea | *Canis latrans*           | yes |                  |
| 259515 | Rancho La Brea | *Equus*                   | yes |                  |
| 259516 | Rancho La Brea | *Equus*                   | yes |                  |
| 259517 | Rancho La Brea | *Equus*                   | no  |                  |
| 238370 | Rancho La Brea | *Equus*                   | yes |                  |
| 238371 | Rancho La Brea | *Equus*                   | yes |                  |
| 148875 | Rancho La Brea | *Gymnogyps californianus* | yes | @fox-dobbs2006 |
| 148876 | Rancho La Brea | *Gymnogyps californianus* | yes | @fox-dobbs2006 |
| 148877 | Rancho La Brea | *Gymnogyps californianus* | yes | @fox-dobbs2006 |
| 148878 | Rancho La Brea | *Gymnogyps californianus* | yes | @fox-dobbs2006 |
| 148879 | Rancho La Brea | *Gymnogyps californianus* | yes | @fox-dobbs2006 |
| 148880 | Rancho La Brea | *Gymnogyps californianus* | yes | @fox-dobbs2006 |
| 148881 | Rancho La Brea | *Gymnogyps californianus* | yes | @fox-dobbs2006 |
| 148884 | Rancho La Brea | *Gymnogyps californianus* | yes | @fox-dobbs2006 |
| 148885 | Rancho La Brea | *Gymnogyps californianus* | yes | @fox-dobbs2006 |
| 259499 | Rancho La Brea | *Smilodon fatalis*        | yes |                  |
| 259501 | Rancho La Brea | *Smilodon fatalis*        | yes |                  |
| 259500 | Rancho La Brea | *Smilodon fatalis*        | yes |                  |
| 148855 | Rancho La Brea | *Teratornis merriami*     | yes |                  |
| 148856 | Rancho La Brea | *Teratornis merriami*     | yes |                  |
| 148859 | Rancho La Brea | *Teratornis merriami*     | yes |                  |
| 148860 | Rancho La Brea | *Teratornis merriami*     | yes |                  |
| 148873 | Rancho La Brea | *Teratornis merriami*     | yes |                  |
| 148874 | Rancho La Brea | *Teratornis merriami*     | yes |                  |

Table: All specimens included in the FTIR training data set. Samples without an associate publication are unpublished data from J. Southon. {#tbl:all_fossils}