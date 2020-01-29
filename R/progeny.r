#' Calculate PROGENy pathway scores from gene expression
#'
#' This function uses the linear model of pathway-responsive genes underlying
#' the PROGENy method. It transforms a gene expression matrix with HGNC gene
#' symbols in rows and sample names in columns into a pathway score matrix with
#' samples and in rows and pathways in columns.
#'
#' The publication of the method is available at:
#' https://www.nature.com/articles/s41467-017-02391-6
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
#'               in columns. In order to run PROGENy in single-cell RNAseq data,
#'               it also accepts Seurat and SingleCellExperiment object, taking
#'               the normalized counts for the computation.   
#' @param scale  A logical value indicating whether to scale the scores of each
#'               pathway to have a mean of zero and a standard deviation of one
#' @param organism The model organism - human or mouse

#' @param top    The top n genes for generating the model matrix according to
#'               significance (p-value)
#' @param perm   A number of permutations
#' @return       A matrix with samples in columns and pathways in rows
#' @importFrom dplyr group_by top_n ungroup select 
#' @importFrom tidyr spread %>%
#' @import SingleCellExperiment
#' @import Seurat
#' @export
#' @examples
#' # use example gene expression matrix here, this is just for illustration
#' gene_expression <- as.matrix(read.csv(system.file("extdata", 
#' "human_input.csv", package = "progeny"), row.names = 1))
#'
#' # calculate pathway activities
#' pathways <- progeny(gene_expression, scale=TRUE, 
#'     organism="Human", top = 100, perm = 1)
progeny = function(expr, scale=TRUE, organism="Human", top = 100, perm = 1) {
    UseMethod("progeny")
}

#' @export
progeny.ExpressionSet = function(expr, scale=TRUE, organism="Human", top = 100,
    perm = 1) {
    progeny(Biobase::exprs(expr), scale=scale, organism=organism, top=top, 
          perm = perm)
}

#' @export
progeny.Seurat = function(expr, scale=TRUE, organism="Human", top = 100,
                          perm = 1) {
    progeny(as.matrix(expr[["RNA"]]@data), scale=scale, organism=organism, 
          top=top, perm = perm)
}

#' @export
progeny.SingleCellExperiment = 
    function(expr, scale=TRUE, organism="Human", top = 100, perm = 1) {
    progeny(as.matrix(normcounts(expr)), scale=scale, organism=organism, 
            top=top, perm = perm)
  }

#' @export
progeny.matrix = function(expr, scale=TRUE, organism="Human", top = 100, 
                          perm = 1) {
  
    full_model <- getFullModel(organism=organism)
    model <- getModel(full_model, top=top)
    common_genes <- intersect(rownames(expr), rownames(model))
    model_unique_genes <- setdiff(rownames(model), rownames(human_input))
    
    if (length(model_unique_genes) > 0) {
      Biobase::note("The next model genes are not in expr input data:", 
                    list(model_unique_genes))
      Biobase::note("A number of such genes:", length(model_unique_genes))
    }

    if (perm==1) {
      re <- t(expr[common_genes,,drop=FALSE]) %*% 
        as.matrix(model[common_genes,,drop=FALSE])
    } else if (perm > 1) {
      expr <- data.frame(names = row.names(expr), row.names = NULL, expr)
      model <- data.frame(names = row.names(model), row.names = NULL, 
                          model)
      re <- progenyPerm(expr, model, k = perm, 
                        z_scores = TRUE, get_nulldist = FALSE)
    } else {
      stop("Wrong perm parameter. Please leave 1 by default or specify another
             value for application the permutation progeny function")
    }
    
    if (scale && nrow(re) > 1) {
      rn <- rownames(re)
      re <- apply(re, 2, scale)
      rownames(re) <- rn
    }
    
    re
  
}

#' @export
progeny.default = function(expr, scale=TRUE, organism="Human", top = 100, 
                           perm = 1) {
  stop("Do not know how to access the data matrix from class ", class(expr))
}
