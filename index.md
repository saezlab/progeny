---
layout: default
title: Home
---

# PROGENy

## Overview
PROGENy (Pathway RespOnsive GENes) aims to infer activity of cancer-relevant signaling pathways using transcriptomics data. In comparison to conventional pathway analysis methods (Class Scoring Methods, e.g. Gene Set Enrichment Analysis or Topology Based approaches, e.g. SPIA) that use the genes of the pathway members, PROGENy calculates pathway activity based on consensus gene signatures obtained from perturbation experiments, that is, the footprint of the pathway on gene expression. 

To infer pathway activity a simple, yet effective linear regression model is trained by perturbation experiments. The perturbed pathways serve as input (-1 indicates inhibition, 1 activation, 0 otherwise) and the corresponding (z-score normalized) gene expression values as response variable. In total the training set consists of 580 public available experiments and 2652 microarrays, making it the largest study of pathway signatures to data. PROGENy has been proven to infer upstream pathway activity in context of (i) known driver mutations in primary tumors, (ii) drugs response in cell lines, and (iii) survival in cancer patients. ([Link to publication](http://www.biorxiv.org/content/early/2016/08/28/065672))

We are currently preparing an R package for Bioconductor. [Drop us a line](mailto:holland@combine.rwth-aachen.de) if you are interested.

## Web Application
We provide an easy to use [web application](https://progeny.shinyapps.io/progenyapp/) to calculate PROGENy scores from gene expression data. 

## Reference
Please use this reference to cite PROGENy:
>  Schubert, M., Klinger, B., Klünemann, M., Garnett, MJ., Blüthgen, N., Saez-Rodriguez, J. (2017). [Perturbation-response genes reveal signaling footprints in cancer gene expression](http://www.biorxiv.org/content/early/2016/08/28/065672)

```
@article{schubert2017perturbation-response,
  title={Perturbation-response genes reveal signaling footprints in cancer gene expression},
  author={Schubert, Michael and Klinger, Bertram and Klünemann, Martina and Garnett, Mathew J and Blüthgen, Nils and Saez-Rodriguez, Julio},
  journal={},
  volume={},
  number={},
  pages={},
  year={},
  publisher={}
}
```
