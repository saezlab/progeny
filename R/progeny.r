#' Calculate PROGENy pathway scores from gene expression
#'
#' This function uses the linear model of pathway-responsive genes underlying
#' the PROGENy method. It transforms a gene expression matrix with HGNC/MGI gene
#' symbols in rows and sample names in columns into a pathway score matrix with
#' samples in rows and pathways in columns.
#'
#' The publication of the method is available at:
#' https://www.nature.com/articles/s41467-017-02391-6
#'
#' The supplied expression object has to contain HGNC/MGI symbols in rows. This
#' will, in most cases (and how we originally used it), be either normalized
#' gene expression of a microarray experiment or log-transformed (and
#' possible variance-stabilized) counts from an RNA-seq experiment.
#'
#' The human and mouse model matrices consists of 14 pathways and large set of 
#' genes with an associated p-value (p-value per gene and pathway) that accounts
#' for the importance of each gene on each pathway upon perturbation. 
#' Its coefficients are non-zero if the gene-pathway pair corresponds
#' to the top N genes (100 by default) that were up-regulated upon stimulation
#' of the pathway in a wide range of experiments. The value corresponds to the 
#' fitted z-score across experiments in our model fit. 
#' Only rows with at least one non-zero coefficient were included, as the rest 
#' is not used to infer pathway activity.
#'
#' @param expr   A gene expression object with HGNC/MGI symbols in rows and 
#'               samples in columns. In order to run PROGENy in single-cell 
#'               RNAseq data, it also accepts Seurat and SingleCellExperiment 
#'               object, taking the normalized counts for the computation.   
#' @param scale  A logical value indicating whether to scale the scores of each
#'               pathway to have a mean of zero and a standard deviation of one.
#'               It does not apply if we use permutations. 
#' @param organism The model organism - "Human" or "Mouse"

#' @param top    The top n genes for generating the model matrix according to
#'               significance (p-value)
#' @param perm   An interger detailing the number of permutations. No 
#'               permutations by default (1). When Permutations larger than 1,
#'               we compute progeny pathway scores and assesses their 
#'               significance using a gene sampling-based permutation strategy, 
#'               for a series of experimental samples/contrasts.
#' @param verbose    A logical value indicating whether to display a message  
#'                   about the number of genes used per pathway to compute 
#'                   progeny scores (i.e. number of genes present in the 
#'                   progeny model and in the expression dataset)
#' @param z_scores Only applys if the number of permutations is greater than 1. 
#'                 A logical value. TRUE: the z-scores will be returned for 
#'                 the pathway activity estimations. FALSE: the function returns 
#'                 a normalized z-score value between -1 and 1.  
#' @param get_nulldist Only applys if the number of permutations is greater 
#'                 than 1. A logical value. TRUE: the null distributions
#'                 generated to assess the signifance of the pathways scores 
#'                 is also returned. 
#' @param assay_name Only applys if the input is a Seurat object. It selects the
#'               name of the assay on which Progeny will be run. Default to: 
#'               RNA, i.e. normalized expression values.
#' @param return_assay Only applys if the input is a Seurat object. A logical 
#'               value indicating whether to return progeny results as a new 
#'               assay called Progeny in the Seurat object used as input. 
#'               Default to FALSE. 
#' @param ...    Additional arguments to be passed to the functions. 
#'               
#' @return       A matrix with samples in columns and pathways in rows. In case
#'               we run the method with permutations and the option get_nulldist
#'               to TRUE, we will get a list with two elements. The first 
#'               element is the matrix with the pathway activity as before. 
#'               The second elements is the null distributions that we generate
#'               to assess the signifance of the pathways scores. 
#' @export
#' @seealso \code{\link{progenyPerm}}
#' @examples
#' # use example gene expression matrix here, this is just for illustration
#' gene_expression <- as.matrix(read.csv(system.file("extdata", 
#' "human_input.csv", package = "progeny"), row.names = 1))
#'
#' # calculate pathway activities
#' pathways <- progeny(gene_expression, scale=TRUE, 
#'     organism="Human", top = 100, perm = 1)
progeny = function(expr, scale=TRUE, organism="Human", top = 100, perm = 1, 
    verbose = FALSE, z_scores = FALSE, get_nulldist = FALSE, assay_name = "RNA", 
    return_assay = FALSE, ...) {
    UseMethod("progeny")
}

#' @export
progeny.ExpressionSet = function(expr, scale=TRUE, organism="Human", top = 100,
    perm = 1, verbose = FALSE, z_scores = FALSE, get_nulldist = FALSE, ...) {
    
    progeny(Biobase::exprs(expr), scale=scale, organism=organism, top=top, 
        perm = perm, verbose = verbose,  z_scores = z_scores, 
        get_nulldist = get_nulldist)
}

#' @export
progeny.Seurat = function(expr, scale=TRUE, organism="Human", top = 100,
    perm = 1, verbose = FALSE, z_scores = FALSE, get_nulldist = FALSE, 
    assay_name = "RNA", return_assay = FALSE,...) {
    
    requireNamespace("Seurat")
    
    if (!is.logical(return_assay)){
        stop("return_assay should be a logical value")
    }
    
    if (scale & return_assay){
        warning("Scale and return_assay should not be both true. 
        Please use the function Seurat::ScaleData(object, assay = \"progeny\") 
        to scale PROGENy scores. Scale is set to FALSE")
        scale = FALSE
    }
    
    results <- progeny(as.matrix(expr[[assay_name]]@data), scale=scale, 
        organism=organism, top=top, perm = perm, verbose = verbose, 
        z_scores = z_scores, get_nulldist = get_nulldist, 
        assay_name = assay_name, return_assay = return_assay)
    
    if (return_assay){
        expr[['progeny']] = Seurat::CreateAssayObject(data = t(results))
        Seurat::Key(object = expr[['progeny']]) <- 'progeny_'
        return(expr)
    } else {
        return(results)
    }
    
}

#' @export
progeny.SingleCellExperiment =  function(expr, scale=FALSE, organism="Human", 
    top = 100, perm = 1, verbose = FALSE, z_scores = FALSE, 
    get_nulldist = FALSE, ...) {
    
    requireNamespace("SingleCellExperiment")

    progeny(as.matrix(SingleCellExperiment::normcounts(expr)), scale=scale, 
        organism=organism, top=top, perm = perm, verbose = verbose,  
        z_scores = z_scores, get_nulldist = get_nulldist)
}

#' @export
progeny.matrix = function(expr, scale=TRUE, organism="Human", top = 100, 
    perm = 1, verbose = FALSE,  z_scores = FALSE, get_nulldist = FALSE,...) {
  
    if (!is.logical(scale)){
        stop("scale should be a logical value")
    }
    
    if (!(is.numeric(perm)) || perm < 1){
        stop("perm should be an integer value")
    }
    
    if (!is.logical(verbose)){
        stop("verbose should be a logical value")
    }
    
    if (!is.logical(z_scores)){
        stop("z_scores should be a logical value")
    }
    
    if (!is.logical(get_nulldist)){
        stop("get_nulldist should be a logical value")
    }
    
    if (perm == 1 && (z_scores || get_nulldist)){
        if (verbose){
            message("z_scores and get_nulldist are only applicable when the
                number of permutations is larger than 1.")
        }
    }
    
    model <- getModel(organism, top=top)
    common_genes <- intersect(rownames(expr), rownames(model))

    if (verbose){
        number_genes <- apply(model, 2, function (x) {
            sum(rownames(model)[which (x != 0)] %in% unique(rownames(expr)))
        })
        message("Number of genes used per pathway to compute progeny scores:")
        message(paste(names(number_genes),": ", number_genes, " (", 
            (number_genes/top)*100,"%)",sep = "","\n"))
    }
    
    if (perm==1) {
        result <- t(expr[common_genes,,drop=FALSE]) %*% 
            as.matrix(model[common_genes,,drop=FALSE])
        
        if (scale && nrow(result) > 1) {
            rn <- rownames(result)
            result <- apply(result, 2, scale)
            rownames(result) <- rn
        }
    
    } else if (perm > 1) {
      expr <- data.frame(names = row.names(expr), row.names = NULL, expr)
      model <- data.frame(names = row.names(model), row.names = NULL, model)
      result <- progenyPerm(expr, model, k = perm, z_scores = z_scores, 
          get_nulldist = get_nulldist)
    }

    return(result)    
}

#' @export
progeny.default = function(expr, scale=TRUE, organism="Human", top = 100, 
    perm = 1, verbose = FALSE, z_scores = FALSE, get_nulldist = FALSE, ...) {
    stop("Do not know how to access the data matrix from class ", class(expr))
}
