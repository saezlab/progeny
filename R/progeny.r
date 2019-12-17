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
#' are non-zero if the gene-pathway pair corresponds to the top N genes
#' (100 by default) that were up-regulated upon stimulation of the pathway 
#' in a wide range of experiments. The value corresponds to the fitted z-score 
#' across experiments in our model fit. Only rows with at least one non-zero
#' coefficient were included, as the rest is not used to infer pathway
#' activity.
#'
#' @param expr   A gene expression object with HGNC symbols in rows and samples
#'               in columns
#' @param scale  Logical value indicating whether to scale the scores of each
#'               pathway to have a mean of zero and standard deviation of one
#' @param organism The model organism - human or mouse
#' @param top    Top n genes for generating the model matrix according to adjusted
#'               p-value
#' @return       A matrix with samples in columns and pathways in rows
#' @importFrom magrittr %>%
#' @importFrom dplyr group_by top_n ungroup select 
#' @importFrom tidyr spread
#' @export
#' @examples
#' # use example gene expression matrix here, this is just for illustration
#' gene_expression = get("gene_expr_human", envir = .GlobalEnv)
#'
#' # calculate pathway activities
#' pathways = progeny(gene_expression, scale=TRUE, organism="Human")
progeny = function(expr, scale=TRUE, organism="Human", top = 100, perm = 1) {
    UseMethod("progeny")
}

#' @export
progeny.ExpressionSet = function(expr, scale=TRUE, organism="Human", top = 100,
                                perm = 1) {
    progeny(Biobase::exprs(expr), scale=scale, organism=organism, top=top, perm = perm)
}

#' @export
progeny.matrix = function(expr, scale=TRUE, organism="Human", top = 100, perm = 1) {
    if (organism == "Human") {
      full_model = get("model_human_full", envir = .GlobalEnv)
    } else if (organism == "Mouse") {
      full_model = get("model_mouse_full", envir = .GlobalEnv)
    } else {
      stop("Wrong organism name. Please specify 'Human' or 'Mouse'.")
    }
  
    model = full_model %>%
      group_by(pathway) %>%
      top_n(top, wt = p.value) %>%
      ungroup(pathway) %>%
      select(-p.value) %>%
      spread(pathway, weight, fill=0) %>%
      data.frame(row.names = 1, check.names = F, stringsAsFactors = F)
  
    common_genes = intersect(rownames(expr), rownames(model))
    if (perm==1) {
      re = t(expr[common_genes,,drop=FALSE]) %*% 
        as.matrix(model[common_genes,,drop=FALSE])
    } else if (perm > 1) {
      expr = data.frame(names = row.names(expr), row.names = NULL, expr)
      model = as.matrix(data.frame(names = row.names(model), row.names = NULL, model))
      re = progeny_perm(expr, model, k = perm, 
                          z_scores = T, get_nulldist = F)
    } else {
      stop("Wrong perm parameter. Please leave 1 by default or specify another
           value for application the permutation progeny function")
    }
   
    if (scale && nrow(re) > 1) {
        rn = rownames(re)
        re = apply(re, 2, scale)
        rownames(re) = rn
    }

    re
    
}

#' @export
progeny.default = function(expr, scale=TRUE, organism="Human", top = 100, perm = 1) {
    stop("Do not know how to access the data matrix from class ", class(expr))
}
