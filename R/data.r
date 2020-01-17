#' The full human linear model underlying PROGENy
#'
#' HGNC gene symbols in rows, pathways in columns. Pathway activity inference
#' works by a matrix multiplication of gene expression with the model.
#'
#' @format The full human model contains 22479 genes, associated pathways,
#' p.value and p.adj value        
#'
#' @docType data
#' @keywords datasets
#' @name model_human_full
#' @source \url{http://biorxiv.org/content/early/2016/08/28/065672}
NULL

#' The full mouse linear model underlying PROGENy
#'
#' HGNC gene symbols in rows, pathways in columns. Pathway activity inference
#' works by a matrix multiplication of gene expression with the model.
#'
#' @format The full mouse model contains 17426 genes, associated pathways,
#' p.value and p.adj value
#' 
#' @docType data
#' @keywords datasets
#' @name model_mouse_full
#' @source \url{http://biorxiv.org/content/early/2016/08/28/065672}
NULL

#' The test human gene expression data
#'
#' HGNC gene symbols in rows, gene expression counts in columns.
#'
#' @format The test human gene expression data contains read counts info about 
#' 121 genes in 8 conditions.
#' 
#' @docType data
#' @keywords datasets
#' @name input_human
#' @source \url{http://biorxiv.org/content/early/2016/08/28/065672}
NULL

#' The test mouse gene expression data
#'
#' HGNC gene symbols in rows, gene expression counts in columns.
#'
#' @format The test mouse gene expression data contains read counts info about 
#' 88 genes in 8 conditions.
#' 
#' @docType data
#' @keywords datasets
#' @name input_mouse
#' @source \url{http://biorxiv.org/content/early/2016/08/28/065672}
NULL

#' The test human result output matrix produced by default progeny function
#'
#' Conditions in rows, pathways in columns.
#'
#' @format The test human result output matrix contains pathway score for each
#' condtioin
#' 
#' @docType data
#' @keywords datasets
#' @name human_def_expected
#' @source \url{http://biorxiv.org/content/early/2016/08/28/065672}
NULL

#' The test mouse result output matrix produced by default progeny function
#'
#' Conditions in rows, pathways in columns.
#'
#' @format The test mouse result output matrix contains pathway score for each
#' condtioin
#' 
#' @docType data
#' @keywords datasets
#' @name mouse_def_expected
#' @source \url{http://biorxiv.org/content/early/2016/08/28/065672}
NULL

#' The test human result output matrix produced by permutation progeny function
#'
#' Conditions in rows, pathways in columns.
#'
#' @format The test human result output matrix contains pathway score for each
#' condtioin
#' 
#' @docType data
#' @keywords datasets
#' @name human_perm_expected
#' @source \url{http://biorxiv.org/content/early/2016/08/28/065672}
NULL

#' The test mouse result output matrix produced by permutation progeny function
#'
#' Conditions in rows, pathways in columns.
#'
#' @format The test mouse result output matrix contains pathway score for each
#' condtioin
#' 
#' @docType data
#' @keywords datasets
#' @name mouse_perm_expected
#' @source \url{http://biorxiv.org/content/early/2016/08/28/065672}
NULL