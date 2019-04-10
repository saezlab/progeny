.PHONY: all
all: doc #vignettes

R = R --no-save --no-restore -e

.PHONY: vignettes
# Additionally build the *.md file, and copy all files
vignettes: knit_all
	$(R) "library(knitr); library(devtools); build_vignettes()"

rmd_files=$(wildcard vignettes/*.rmd)
knit_results=$(patsubst vignettes/%.rmd,inst/doc/%.md,${rmd_files})

.PHONY: knit_all
knit_all: inst/doc ${knit_results}
	cp -r vignettes/* inst/doc/

inst/doc:
	mkdir -p $@

inst/doc/%.md: vignettes/%.rmd
	$(R) "library(knitr); knit('$<', '$@')"

.PHONY: doc
doc:
	$(R) "library(devtools); document()"

.PHONY: test
	$(R) "devtools::test()"

.PHONY: check
	$(R) "devtools::check()"

cleanall:
	${RM} -r inst/doc
	${RM} -r man
