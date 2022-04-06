# PROGENy: Pathway RespOnsive GENes for activity inference <img src="man/figures/tool_logo.png" align="right" width="120" />

<!-- badges: start -->
![GitHub](https://img.shields.io/github/license/saezlab/progeny)
<!-- badges: end -->


## Overview

PROGENy is resource that leverages a large compendium of publicly available
signaling perturbation experiments to yield a common core of pathway responsive
genes for human and mouse. These, coupled with any statistical method, can be
used to infer pathway activities from bulk or single-cell transcriptomics. 

This is an R package for storing the pathway signatures. To infer pathway
activities, please check out
[decoupleR](https://doi.org/10.1093/bioadv/vbac016), available in
[R](https://saezlab.github.io/decoupleR/) or
[python](https://github.com/saezlab/decoupler-py).

## Installation

Progeny is available in
[Bioconductor](https://www.bioconductor.org/packages/release/bioc/html/progeny.html). 
In addition, one can install the development version from the Github repository: 

```r
## To install the package from Bioconductor
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("progeny")

## To install the development version from the Github repo:
devtools::install_github("saezlab/progeny")
```

## Updates

Since the original release, we have implemented some extensions in PROGENy:

1. **Extension to mouse**:
  Originally PROGENy was developed for the application to human data. 
  In a benchmark study we showed that PROGENy is also applicable to mouse data, 
  as described in 
  [Holland et al., 2019](https://doi.org/10.1016/j.bbagrm.2019.194431). 
  Accordingly, we included new parameters to run mouse version of PROGENy by 
  transforming the human genes to their mouse orthologs.
2. **Expanding Pathway Collection**:
  We expanded human and mouse PROGENy with the pathways Androgen, Estrogen and 
  WNT.
3. **Extension to single-cell RNA-seq data**:
  We showed that PROGENy can be applied to scRNA-seq data, as described in
  [Holland et al., 2020](https://doi.org/10.1186/s13059-020-1949-z)

## Citation

> Schubert M, Klinger B, Klünemann M, Sieber A, Uhlitz F, Sauer S, Garnett MJ, 
Blüthgen N, Saez-Rodriguez J. 2018. Perturbation-response genes reveal signaling
footprints in cancer gene expression. _Nature Communications_: 
[10.1038/s41467-017-02391-6](https://doi.org/10.1038/s41467-017-02391-6)
