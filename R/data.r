#' The full human linear model underlying PROGENy
#'
#' HGNC gene symbols in rows, pathways in columns. Pathway activity inference
#' works by matrix multiplication of gene expression with the model.
#'
#' @format The full human model contains 22479 genes, associated pathways,
#' weight and the p-value.         
#' \describe{
#'     \item{gene}{gene names in HGNC symbols}
#'     \item{pathway}{names of PROGENy pathways}
#'     \item{weight}{z-scores for a given gene}
#'     \item{p.value}{significance of gene in pathway}
#' }
#' @keywords datasets
#' @name model_human_full
#' @examples get("model_human_full", envir = .GlobalEnv)
#' @source \url{https://www.nature.com/articles/s41467-017-02391-6}
NULL

#' The full mouse linear model underlying PROGENy
#'
#' MGI gene symbols in rows, pathways in columns. Pathway activity inference
#' works by matrix multiplication of gene expression with the model.
#'
#' @format The full mouse model contains 17426 genes, associated pathways,
#' weight and the p-value.         
#' \describe{
#'     \item{gene}{gene names in HGNC symbols}
#'     \item{pathway}{names of PROGENy pathways}
#'     \item{weight}{z-scores for a given gene}
#'     \item{p.value}{significance of gene in a pathway}
#' }
#' @keywords datasets
#' @name model_mouse_full
#' @examples get("model_mouse_full", envir = .GlobalEnv)
#' @source \url{https://www.ncbi.nlm.nih.gov/pubmed/31525460}
NULL

#' The RNA data used in the progeny vignette
#'
#' List with three elements: the gene counts, the experimental design and 
#' the result of limma differential analysis
#'
#' @format List with three elements: the gene counts, the experimental design and 
#' the result of limma differential analysis        
#' \describe{
#'     \item{counts}{gene counts}
#'     \item{design}{experiemental design}
#'     \item{limma_ttop}{differential analysis result using limma}
#' }
#' @keywords datasets
#' @name vignette_data
#' @examples data("vignette_data")
#' @source \url{https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE119931}
NULL
