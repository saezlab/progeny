library(testthat)
library(progeny)
library(DESeq2)
library(dplyr)
library(tidyr)


progeny_src = function(expr, scale=TRUE, organism="Human", top = 10) {
  if (organism == "Human") {
    full_model = get("model_human_full", envir = .GlobalEnv)
  } else if (organism == "Mouse") {
    full_model = get("model_mouse_full", envir = .GlobalEnv)
  } else {
    stop("Wrong organism name. Please specify 'Human' or 'Mouse'.")
  }
  
  model = full_model %>%
    group_by(pathway) %>%
    top_n(top, wt = adj.p) %>%
    ungroup(pathway) %>%
    select(-p.value, -adj.p) %>%
    spread(pathway, weight, fill=0) %>%
    data.frame(row.names = 1, check.names = F, stringsAsFactors = F)
  
  common_genes = intersect(rownames(expr), rownames(model))
  re = t(expr[common_genes,,drop=FALSE]) %*% as.matrix(model[common_genes,,drop=FALSE])
  
  if (scale && nrow(re) > 1) {
    rn = rownames(re)
    re = apply(re, 2, scale)
    rownames(re) = rn
  }
  
  re
}

####data preparation for human####

#get human gene expression data 
test_human_ge_data = get('test_human_ge_data', envir = .GlobalEnv)
# import data to DESeq2 and variance stabilize
dset = DESeqDataSetFromMatrix(assay(test_human_ge_data),
                              colData=as.data.frame(colData(test_human_ge_data)), 
                              design=~condition)
dset = estimateSizeFactors(dset)
dset = estimateDispersions(dset)
gene_expr_human = getVarianceStabilizedData(dset)

####data preparation for mouse####

#get mouse gene expression data 
test_mouse_ge_data = get('test_mouse_ge_data', envir = .GlobalEnv)
#create matrix
dset <- DESeqDataSetFromMatrix(countData = assay(test_mouse_ge_data),
                                   colData = as.data.frame(colData(test_mouse_ge_data)),
                                   design = ~ condition)
# import data to DESeq2 and variance stabilize
dset = estimateSizeFactors(dset)
dset = estimateDispersions(dset)
gene_expr_mouse = getVarianceStabilizedData(dset)


####Obtaining pathway scores from actual function for human####
result_human_actual <- progeny_src(gene_expr_human, scale=TRUE, 
                                       organism = "Human", top = 10)

####Obtaining pathway scores from actual function for mouse####
result_mouse_actual <- progeny_src(gene_expr_mouse, scale=TRUE, 
                                       organism = "Mouse", top = 10)

###Obtaining expected result for human####
result_human_expected <- progeny(gene_expr_human, scale=TRUE, 
                                 organism = "Human", top = 10)

####Obtaining expected result for mouse####
result_mouse_expected <- progeny(gene_expr_mouse, scale=TRUE, 
                                 organism = "Mouse", top = 10)

####Testing####
test_that("Comparison of the results", {
  expect_equal(result_human_actual, result_human_expected)
  expect_equal(result_mouse_actual, result_mouse_expected)
})
