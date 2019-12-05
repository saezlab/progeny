#' The full human linear human model underlying PROGENy
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
#' @usage get("model_human_full")
#' @source \url{http://biorxiv.org/content/early/2016/08/28/065672}
NULL

#' The full mouse linear human model underlying PROGENy
#'
#' HGNC gene symbols in rows, pathways in columns. Pathway activity inference
#' works by a matrix multiplication of gene expression with the model.
#'
#' @format The full mouse model contains 17426 genes, associated pathways,
#' p.value and p.adj value
#' @docType data
#' @keywords datasets
#' @name model_human_full
#' @usage get("model_mouse_full")
#' @source \url{http://biorxiv.org/content/early/2016/08/28/065672}
NULL

#' The test human gene expression data
#'
#' HGNC gene symbols in rows, gene expression counts in columns.
#'
#' @format The test human gene expression data contains read counts info about 
#' 152 genes in 12 conditions.
#' @docType data
#' @keywords datasets
#' @name gene_expr_human
#' @usage get("gene_expr_human")
#' @source \url{http://biorxiv.org/content/early/2016/08/28/065672}
NULL

#' The test mouse gene expression data
#'
#' HGNC gene symbols in rows, gene expression counts in columns.
#'
#' @format The test mouse gene expression data contains read counts info about 
#' 144 genes in 12 conditions.
#' @docType data
#' @keywords datasets
#' @name gene_expr_mouse
#' @usage get("gene_expr_mouse")
#' @source \url{http://biorxiv.org/content/early/2016/08/28/065672}
NULL

#' The test human result output matrix 
#'
#' Conditions in rows, pathways in columns.
#'
#' @format The test human result output matrix contains pathway score for each
#' condtioin
#' @docType data
#' @keywords datasets
#' @name result_human_expected
#' @usage get("result_human_expected")
#' @source \url{http://biorxiv.org/content/early/2016/08/28/065672}
NULL

#' The test mouse result output matrix 
#'
#' Conditions in rows, pathways in columns.
#'
#' @format The test mouse result output matrix contains pathway score for each
#' condtioin
#' @docType data
#' @keywords datasets
#' @name result_mouse_expected
#' @usage get("result_mouse_expected")
#' @source \url{http://biorxiv.org/content/early/2016/08/28/065672}
NULL

