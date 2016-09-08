#' Calculate PROGENy pathway scores from gene expression
#'
#' This function uses the linear model of pathway-responsive genes underlying
#' the PROGENy method. It transforms a gene expression matrix with HGNC gene
#' symbols in rows and sample names in columns into a pathway score matrix with
#' samples and in rows and pathways in columns.
#'
#' @param expr   A gene expression object with HGNC symbols in rows and samples
#'               in columns
#' @param scale  Logical value indicating whether to scale the scores of each
#'               pathway to have a mean of zero and standard deviation of one
#' @return       A matrix with samples in columns and pathways in rows
#' @export
progeny = function(expr, scale=TRUE) {
    UseMethod("progeny")
}

#' @export
progeny.AnnotatedDataFrame = function(expr, scale=TRUE) {
    progeny(Biobase::exprs(expr), scale=scale)
}

#' @export
progeny.matrix = function(expr, scale=TRUE) {
    common_genes = intersect(rownames(expr), rownames(model))
    re = t(expr[common_genes,]) %*% model[common_genes,]

    if (scale) {
        rn = rownames(re)
        re = apply(re, 2, scale)
        rownames(re) = rn
    }

    re
}

#' @export
progeny.default = function(expr, scale=TRUE) {
    stop("Do not know how to access the data matrix from class ", class(expr))
}
