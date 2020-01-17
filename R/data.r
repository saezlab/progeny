#' The full human linear model underlying PROGENy
#'
#' HGNC gene symbols in rows, pathways in columns. Pathway activity inference
#' works by a matrix multiplication of gene expression with the model.
#'
#' @format The full human model contains 22479 genes, associated pathways,
#' p.value and p.adj value        
#' \describe{
#'     \item{gene}{gene names in HGNC symbols}
#'     \item{pathway}{names of PROGENy pathways}
#'     \item{weight}{z-scores for a given gene}
#'     \item{p.value}{significance of gene in pathway}
#' }
#' @keywords datasets
#' @name model_human_full
#' @examples getFullModel("Human")
#' @source \url{http://biorxiv.org/content/early/2016/08/28/065672}
NULL

#' The full mouse linear model underlying PROGENy
#'
#' HGNC gene symbols in rows, pathways in columns. Pathway activity inference
#' works by a matrix multiplication of gene expression with the model.
#'
#' @format The full mouse model contains 17426 genes, associated pathways,
#' p.value and p.adj value
#' \describe{
#'     \item{gene}{gene names in HGNC symbols}
#'     \item{pathway}{names of PROGENy pathways}
#'     \item{weight}{z-scores for a given gene}
#'     \item{p.value}{significance of gene in a pathway}
#' }
#' @keywords datasets
#' @name model_mouse_full
#' @examples getFullModel("Mouse")
#' @source \url{http://biorxiv.org/content/early/2016/08/28/065672}
NULL
