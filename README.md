PROGENy: Pathway RespOnsive GENes for activity inference
========================================================

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
