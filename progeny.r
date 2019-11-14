#' Calculate PROGENy pathway scores from gene expression
#'
#' This function uses the linear model of pathway-responsive genes underlying
#' the PROGENy method. It transforms a gene expression matrix with HGNC gene
#' symbols in rows and sample names in columns into a pathway score matrix with
#' samples and in rows and pathways in columns.
#'
#' The publication of the method is available at:
#' https://www.biorxiv.org/content/early/2016/08/28/065672
#'
#' The supplied expression object has to contain HGNC symbols in rows. This
#' will, in most cases (and how we originally used it), be either normalized
#' gene expression of a microarray experiment or log-transformed (and
#' possible variance-stabilized) counts from an RNA-seq experiment.
#'
#' The human model matrix itself consists of 14 pathways and 1301 genes 
#' and the mouse model matrix - 14 and 1376 respectively). Its coefficients
#' are non-zero if the gene-pathway pair corresponds to the top 100 genes
#' that were up-regulated upon stimulation of the pathway in a wide
#' range of experiments. The value corresponds to the fitted z-score across
#' experiments in our model fit. Only rows with at least one non-zero
#' coefficient were included, as the rest is not used to infer pathway
#' activity.
#'
#' @param expr   A gene expression object with HGNC symbols in rows and samples
#'               in columns
#' @param scale  Logical value indicating whether to scale the scores of each
#'               pathway to have a mean of zero and standard deviation of one
#' @param organism Model organism - human or mouse.
#' @return       A matrix with samples in columns and pathways in rows
#' @export
#' @examples
#' # use your gene expression matrix here, this is just for illustration
#' gene_expression = matrix(rep(1, nrow(model)),
#'     dimnames=list(rownames(model), "sample"))
#'
#' # calculate pathway activities
#' pathways = progeny(gene_expression)
progeny = function(expr, scale=TRUE, organism="Human") {
    UseMethod("progeny")
}

#' @export
progeny.ExpressionSet = function(expr, scale=TRUE, organism="Human") {
    progeny(Biobase::exprs(expr), scale=scale)
}

#' @export
progeny.matrix = function(expr, scale=TRUE, organism="Human") {
    model = if (organism=="Human") {
      get("human_model", envir = .GlobalEnv)
    } else if (organism=="Mouse") {
      get("mouse_model", envir = .GlobalEnv)
    } else {
      stop("Wrong model organism. Please specify 'Human' or 'Mouse'.")
    }
    common_genes = intersect(rownames(expr), rownames(model))
    re = t(expr[common_genes,,drop=FALSE]) %*% model[common_genes,,drop=FALSE]

    if (scale && nrow(re) > 1) {
        rn = rownames(re)
        re = apply(re, 2, scale)
        rownames(re) = rn
    }

    re
}

#' @export
progeny.default = function(expr, scale=TRUE, organism="Human") {
    stop("Do not know how to access the data matrix from class ", class(expr))
}
