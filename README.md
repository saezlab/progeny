<img src="man/figures/tool_logo.png" align="left" height="100">

# PROGENy: Pathway RespOnsive GENes for activity inference  

<!-- badges: start -->
![GitHub](https://img.shields.io/github/license/saezlab/progeny)
<!-- badges: end -->


## Overview

Aberrant cell signaling is known to cause cancer and many other diseases, as
well as a focus of treatment. A common approach is to infer its activity on the
level of pathways using gene expression. However, mapping gene expression to
pathway components disregards the effect of post-translational modifications,
and downstream signatures represent very specific experimental conditions. Here
we present PROGENy, a method that overcomes both limitations by leveraging a
large compendium of publicly available perturbation experiments to yield a
common core of Pathway RespOnsive GENes. Unlike existing methods, PROGENy can
(i) recover the effect of known driver mutations, (ii) provide or improve
strong markers for drug indications, and (iii) distinguish between oncogenic
and tumor suppressor pathways for patient survival. Collectively, these results
show that PROGENy more accurately infers pathway activity from gene expression
than other methods.

This is an R package for using the method described in
[Nature Communications](https://www.nature.com/articles/s41467-017-02391-6).

```
@article{Schubert2018,
  doi = {10.1038/s41467-017-02391-6},
  url = {https://doi.org/10.1038/s41467-017-02391-6},
  year  = {2018},
  month = {jan},
  publisher = {Springer Nature},
  volume = {9},
  number = {1},
  author = {Michael Schubert and Bertram Klinger and Martina Kl\"{u}nemann and Anja Sieber and Florian Uhlitz and Sascha Sauer and Mathew J. Garnett and Nils Bl\"{u}thgen and Julio Saez-Rodriguez},
  title = {Perturbation-response genes reveal signaling footprints in cancer gene expression},
  journal = {Nature Communications}
}
```

## Installation

Progeny is available in [Bioconductor](https://www.bioconductor.org/packages/release/bioc/html/progeny.html). In addition, one can install the development version from the Github
repository: 

```r
## To install the package from Bioconductor
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("progeny")

## To install the development version from the Github repo:
devtools::install_github("saezlab/progeny")
```
## Installation

For a detailed tutorial of how to use progeny in the context of of RNAseq data analysis, check out our [Transcriptutorial](https://github.com/saezlab/transcriptutorial)

## Updates

Since the original release, we have implemented some extensions in PROGENy:

### Update #1 - Extension to mouse

Originally PROGENy was developed for the application to human data. 
In a benchmark study we showed that PROGENy is also applicable to mouse data, 
as described in 
[Holland et al., 2019](https://doi.org/10.1016/j.bbagrm.2019.194431). 
Accordingly, we included new parameters to run mouse version of PROGENy by 
transforming the human genes to their mouse orthologs.

### Update #2 - Expanding Pathway Collection

We expanded human and mouse PROGENy with the pathways Androgen, Estrogen and 
WNT.

### Update #3 - Extension to single-cell RNA-seq data

Recent technological advances in single-cell RNA-seq enable the profiling of 
gene expression at the individual cell level. We showed that PROGENy can be 
applied to scRNA-seq data, as described in [Holland et al., 2020](https://doi.org/10.1186/s13059-020-1949-z)

## Citing PROGENy

Besides the original paper, there are two additional publication 
describing expansions of PROGENy usage.

- If you use PROGENy for your research please cite the original publication:

> Schubert M, Klinger B, Klünemann M, Sieber A, Uhlitz F, Sauer S, Garnett MJ, Blüthgen N, Saez-Rodriguez J. “Perturbation-response genes reveal signaling footprints in cancer gene expression.” _Nature Communications_: [10.1038/s41467-017-02391-6](https://doi.org/10.1038/s41467-017-02391-6)

- If you use for mouse or you use the expanded version containing 14 pathways, 
please cite additionally:

> Holland CH, Szalai B, Saez-Rodriguez J. "Transfer of regulatory knowledge from human to mouse for functional genomics analysis." _Biochimica et Biophysica Acta (BBA) - Gene Regulatory Mechanisms._ 2019. DOI: [10.1016/j.bbagrm.2019.194431](https://doi.org/10.1016/j.bbagrm.2019.194431).

- If you apply PROGENy on single-cell RNA-seq data please cite additionally:

> Holland CH, Tanevski J, Perales-Patón J, Gleixner J, Kumar MP, Mereu E, Joughin BA, Stegle O, Lauffenburger DA, Heyn H, Szalai B, Saez-Rodriguez, J. "Robustness and applicability of transcription factor and pathway analysis tools on single-cell RNA-seq data." _Genome Biology._ 2020. DOI: [10.1186/s13059-020-1949-z](https://doi.org/10.1186/s13059-020-1949-z).
