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
[bioRxiv](http://biorxiv.org/content/early/2016/07/25/065672)
([pdf](http://biorxiv.org/content/early/2016/07/25/065672.full.pdf)).

```
@article {Schubert-PRGs,
	author = {Schubert, Michael and Klinger, Bertram and Kl{\"u}nemann, Martina and 
              Garnett, Mathew J and Bl{\"u}thgen, Nils and Saez-Rodriguez, Julio},
	title = {Perturbation-response genes reveal signaling footprints in cancer gene expression},
	year = {2016},
	doi = {10.1101/065672},
	publisher = {Cold Spring Harbor Labs Journals},
	URL = {http://biorxiv.org/content/early/2016/08/28/065672},
	eprint = {http://biorxiv.org/content/early/2016/08/28/065672.full.pdf},
	journal = {bioRxiv}
}
```
