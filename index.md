---
layout: default
title: Home
---

# PROGENy

## Overview
PROGENy (Pathway RespOnsive GENes) aims to infer activity of cancer-relevant signaling pathways using transcriptomics data. In comparison to conventional pathway analysis methods (Class Scoring Methods, e.g. Gene Set Enrichment Analysis or Topology Based approaches, e.g. SPIA) that use the genes of the pathway members, PROGENy calculates pathway activity based on consensus gene signatures obtained from perturbation experiments, that is, the footprint of the pathway on gene expression. 

To infer pathway activity a simple, yet effective linear regression model is trained by perturbation experiments. The perturbed pathways serve as input (-1 indicates inhibition, 1 activation, 0 otherwise) and the corresponding (z-score normalized) gene expression values as response variable. In total the training set consists of 580 public available experiments and 2652 microarrays, making it the largest study of pathway signatures to data. PROGENy has been proven to infer upstream pathway activity in context of (i) known driver mutations in primary tumors, (ii) drugs response in cell lines, and (iii) survival in cancer patients. ([Link to publication](http://rdcu.be/DTYo))

## Bioconductor package
We developed a [Bioconductor package for PROGENy](http://bioconductor.org/packages/release/bioc/html/progeny.html). If you have questions please use [this](https://github.com/saezlab/progeny/issues) platform to get in contact with other users and the developer.

## Web Application
We provide an easy to use [web application](https://progeny.shinyapps.io/progenyapp/) to calculate PROGENy scores from gene expression data.

## Reference
Please use this reference to cite PROGENy:
>  Schubert, M., Klinger, B., Klünemann, M., Sieber, A., Uhlitz, F., Sauer, S., Garnett, MJ., Blüthgen, N., Saez-Rodriguez, J. (2018). [Perturbation-response genes reveal signaling footprints in cancer gene expression](http://rdcu.be/DTYo)

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
