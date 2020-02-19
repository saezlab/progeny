---
layout: default
title: Home
---

# PROGENy
## Introduction
### Overview
PROGENy (Pathway RespOnsive GENes) is a functional analysis tool that infers activity of cancer-relevant signaling pathways (originally *EGFR*, *Hypoxia*, *JAK-STAT*, *MAPK*, *NFkB*, *PI3K*, *p53*, *TGFb*, *TNFa*, *Trail* and *VEGF*) using transcriptomics data, as described in [Schubert et al., 2019](https://doi.org/10.1038/s41467-017-02391-6). In comparison to conventional pathway analysis methods (Class Scoring Methods, e.g. Gene Set Enrichment Analysis or Topology Based approaches, e.g. SPIA) that use the genes of the pathway members, PROGENy calculates pathway activity based on consensus gene signatures obtained from perturbation experiments, that is, the footprint of the pathway on gene expression. A more detailed description of the concept of *footprint-based* analysis is available in the review [Dugourd et al., 2019](https://doi.org/10.1016/j.coisb.2019.04.002).

To infer pathway activity a simple, yet effective linear regression model is trained by perturbation experiments. The perturbed pathways serve as input (-1 indicates inhibition, 1 activation, 0 otherwise) and the corresponding (z-score normalized) gene expression values as response variable. In total the training set consists of 580 public available experiments and 2652 microarrays, making it one of the most comprehensive study of pathway signatures to date. PROGENy has been proven to infer upstream pathway activity in context of (i) known driver mutations in primary tumors, (ii) drugs response in cell lines, and (iii) survival in cancer patients.

### Update #1 - extension to mouse
Originally PROGENy was developed for the application to human data. In a benchmark study we showed that PROGENy is also applicable to mouse data, as described in [Holland et al., 2019](https://doi.org/10.1016/j.bbagrm.2019.194431). Accordingly, we developed a mouse version of DoRothEA by transforming the human genes to their mouse orthologs.

### Update #2 - expanding pathway collection
We expanded human and mouse PROGENy with the pathways *Androgen*, *Estrogen* and *WNT*.

### Update #3 - extension to single-cell RNA-seq data
Recent technological advances in single-cell RNA-seq enable the profiling of gene expression at the individual cell level. We showed that PROGENy can be applied to scRNA-seq data, as described in [Holland et al., 2020](https://doi.org/10.1186/s13059-020-1949-z).

### Bioconductor package
We developed a [Bioconductor package for PROGENy](http://bioconductor.org/packages/release/bioc/html/progeny.html). If you have questions please use [this](https://github.com/saezlab/progeny/issues) platform to get in contact with other users and the developer.

### Web Application
We provide an easy to use [web application](https://progeny.shinyapps.io/progenyapp/) to calculate PROGENy scores from gene expression data.

## Citing PROGENy
Beside the original paper there are additional publication expanding the usage of PROGENy.

* If you use PROGENy for your research please cite the original publication:
>  Schubert M, Klinger B, Klünemann M, Sieber A, Uhlitz F, Sauer S, Garnett MJ, Blüthgen N, Saez-Rodriguez J. "Perturbation-response genes reveal signaling footprints in cancer gene expression." _Nature Communications._ DOI: [10.1038/s41467-017-02391-6](https://doi.org/10.1038/s41467-017-02391-6).

* If you use either the mouse or expanded version (mouse and human) of PROGENy please cite additionally:
> Holland CH, Szalai B, Saez-Rodriguez J. "Transfer of regulatory knowledge from human to mouse for functional genomics analysis." _Biochimica et Biophysica Acta (BBA) - Gene Regulatory Mechanisms._ 2019. DOI: [10.1016/j.bbagrm.2019.194431](https://doi.org/10.1016/j.bbagrm.2019.194431).

If you apply PROGENy on single-cell RNA-seq data please cite additionally:
> Holland CH, Tanevski J, Perales-Patón J, Gleixner J, Kumar MP, Mereu E, Joughin BA, Stegle O, Lauffenburger DA, Heyn H, Szalai B, Saez-Rodriguez, J. "Robustness and applicability of transcription factor and pathway analysis tools on single-cell RNA-seq data." _Genome Biology._ 2020. DOI: [10.1186/s13059-020-1949-z](https://doi.org/10.1186/s13059-020-1949-z).
