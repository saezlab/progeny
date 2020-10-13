#' Calculate Progeny Scores with Permutations
#'
#'This function generate a series of scatter plot with marginal distribution
#'(in the form of an arrangeGrob object), for each progeny pathway and
#'sample/contrast. Each scatter plot has progeny weights as x-axis and the gene
#'level stat used to compute progeny score as the y-axis. The marginal
#'distribution of the gene level stats is displayed on the right of the plot
#'to give visual support of the significance of each gene contributing to
#'the progeny pathway score. The green and red colors represent the positive
#'and negative contribution of genes to the progeny pathway, respectively.
#'For each gene contribution, 4 cases are possible, as the combinations of
#'the sign of the gene level stat and the sign of the gene level weight.
#'Positive weight will lead to a positive(green)/negative(red) gene contribution
#'if the gene level stat is positive/negative. Negative weight will lead to
#'a negative(red)/positive(green) gene contribution if the gene level stat
#'is positive/negative.
#'
#'@param df an n*m data frame, where n is the number of omic features (genes). 
#'m isn't really important, as long as at least one column corresponds to a 
#'sample or contrast statistic. One of the columns should correspond to the gene 
#'symbols.
#'@param weight_matrix A progeny coefficient matrix. the first column should be
#'the identifiers of the omic features, and should be coherent with 
#'the identifiers provided in df.
#'@param dfID an integer corresponding to the column number of 
#'the gene identifiers of df.
#'@param weightID an integer corresponding to the column number of the gene 
#'identifiers of the weight matrix.
#'@param statName The name of the stat used, to be displayed on the plot
#'@param verbose  Logical indicating whether we want to have the messages 
#'indicating the different computed weights. 
#'@importFrom stats ecdf
#'@import ggplot2
#'@import ggrepel
#'@import gridExtra
#'@return The function returns a list of list of arrangeGrob objects.
#'The first level list elements correspond to samples/contrasts. 
#'The second level correspond to pathways.
#'The plots can be saved in a pdf format using the saveProgenyPlots function.
#'@examples
#' # use example gene expression matrix
#' 
#' gene_expression <- read.csv(system.file("extdata", 
#' "human_input.csv", package = "progeny"))
#'
#' # getting a model matrix with 100 top significant genes and converting to df
#' weight_matrix <- getModel("Human", top=100)
#' weight_matrix <- data.frame(names = row.names(weight_matrix), 
#'   row.names = NULL, weight_matrix)
#' 
#' #use progenyScatter function
#' plots <- progenyScatter(gene_expression, weight_matrix)
#'@export
progenyScatter <- function(df,weight_matrix,dfID = 1, weightID = 1, 
    statName = "gene stats", verbose = FALSE) {
  
    weight <- color <- ID <- NULL    
    plot_list_contrasts <- list(0)
    for (i in 2:length(df[1,])) {
        plot_list_pathways <- list(0)
        for (j in 2:length(weight_matrix[1,])) {
            sub_df <- df[,c(dfID,i)]
            pathway_weights <- weight_matrix[,c(weightID,j)]
            names(sub_df) <- c("ID","stat")
            minstat <- min(sub_df$stat)
            maxstat <- max(sub_df$stat)
            
            histo <- ggplot(sub_df, aes(x = stat, fill = "blue")) + 
                geom_density() + coord_flip() + 
                scale_fill_manual(values = c("#00c5ff")) + 
                xlim(minstat, maxstat) + theme_minimal() + 
                theme(legend.position = "none", axis.text.x = element_blank(),
                axis.ticks.x = element_blank(), axis.title.y = element_blank(),
                axis.text.y = element_blank(), axis.ticks.y = element_blank(),
                panel.grid.major = element_blank(),
                panel.grid.minor = element_blank())
      
            names(pathway_weights) <- c("ID","weight")
            pathway_weights <- pathway_weights[pathway_weights$weight != 0,]
            percentile <- ecdf(sub_df$stat)
            sub_df <- merge(sub_df,pathway_weights,by = "ID")
            sub_df$color <- "3"
            sub_df[(sub_df$weight > 0 & sub_df$stat > 0),"color"] <- "1"
            sub_df[(sub_df$weight > 0 & sub_df$stat < 0),"color"] <- "2"
            sub_df[(sub_df$weight < 0 & sub_df$stat > 0),"color"] <- "2"
            sub_df[(sub_df$weight < 0 & sub_df$stat < 0),"color"] <- "1"
            sub_df[(percentile(sub_df$stat) < .95 & 
                percentile(sub_df$stat) > .05),1] <- NA
      
            if (verbose){
                message(paste("weights of ",names(weight_matrix)[j], sep = ""))
            }
          
            title <- paste("weights of ",names(weight_matrix)[j], sep = "")
      
            scatterplot <- ggplot(sub_df, aes(x = weight, y = stat, 
                color = color)) + geom_point() +
            scale_colour_manual(values = c("red","royalblue3","grey")) +
            geom_label_repel(aes(label = ID)) +
            ylim(minstat, maxstat) + theme_minimal() +
            theme(legend.position = "none") +
            geom_vline(xintercept = 0, linetype = 'dotted') +
            geom_hline(yintercept = 0, linetype = 'dotted') +
            labs(x = title, y = statName)
      
            lay <- t(as.matrix(c(1,1,1,1,2)))
            gg <- arrangeGrob(scatterplot, histo, nrow = 1, ncol = 2, 
                layout_matrix = lay)
            plot_list_pathways[[j-1]] <- gg
        }
        names(plot_list_pathways) <- names(weight_matrix[,-weightID])
        plot_list_contrasts[[i-1]] <- plot_list_pathways
    }
    return(plot_list_contrasts)
}

#'Function to save Progeny plots
#'
#'This function is designed to save the plots (in pdf format) of a nested 
#'(2 level) list of arrangeGrob objects, such as the one returned by 
#'the progenyScatter function.
#'
#'@param plots a list of list of arrangeGrob object (such as the one returned 
#'by the progenyScatter function.).The first level list elements correspond 
#'to samples/contrasts. The second level corresponds to pathways.
#'The plots can be saved in a pdf format using the saveProgenyPlots function.
#'@param contrast_names a vector of the same length as the first level of 
#'the plot list corresponding to the names of each sample/contrast
#'@param dirpath the path to the directory where the plots should be saved
#'@import ggplot2
#'@examples
#' #create plots using progneyScatter function
#' gene_expression <- read.csv(system.file("extdata", 
#' "human_input.csv", package = "progeny"))
#' 
#' # getting a weight_matrix
#' weight_matrix <- getModel("Human", top=100)
#' weight_matrix <- data.frame(names = row.names(weight_matrix), 
#'   row.names = NULL, weight_matrix) 
#' plots <- progenyScatter(gene_expression, weight_matrix)
#'
#' #create a list with contrast names
#' contrast_names <- names(gene_expression[2:ncol(gene_expression)])
#'
#' #assign a path to store your plots
#' dirpath <- "./progeny_plots/"
#' 
#' # save it
#' # saveProgenyPlots(plots, contrast_names, dirpath)
#' @return This function produces the pdf files of plots taken from the 
#' progenyScatter function
#'@export
saveProgenyPlots <- function(plots, contrast_names, dirpath) {
    
    i <- 1
    for (condition in plots) {
        dirname <- paste(dirpath,contrast_names[i], sep = "")
        dir.create(dirname, recursive = TRUE, showWarnings = FALSE)
        j <- 1
        for (pathway in condition) {
            filename <- paste(dirname,names(condition)[j],sep = "/")
            filename <- paste(filename,".pdf",sep = "")
            ggsave(filename, pathway,device = "pdf", dpi = 300)
            j <- j+1
        }
    i <- i+1
    }
}

#'Returns the Progeny Model
#'
#'This function is designed for getting a model matrix with top significant
#'genes for each pathway
#'
#'@param organism "Human" or "Mouse" taken from the main function's argument. 
#'Default to "Human"
#'@param top Desired top number of genes for each pathway according to their
#'significance(p.value). Default to 100
#'@examples #getting a model matrix according to the desired top n significant 
#'model <- getModel("Human", top=100)
#'@return This function returns model matrix according to the top n significant
#'@importFrom dplyr group_by top_n ungroup select 
#'@importFrom tidyr spread %>%
#'@export
getModel <- function(organism = "Human", top= 100) {
    
    pathway <- p.value <- weight <- NULL

    if (organism == "Human") {
        full_model <- model_human_full
    } else if (organism == "Mouse") {
        full_model <- model_mouse_full
    } else {
        stop("Wrong organism name. Please specify 'Human' or 'Mouse'.")
    }
    
    if (!(is.numeric(top)) || top < 1){
        stop("perm should be an integer value")
    }

    model <- full_model %>%
        dplyr::group_by(pathway) %>%
        dplyr::top_n(top, wt = -p.value) %>%
        dplyr::ungroup(pathway) %>%
        dplyr::select(-p.value) %>%
        tidyr::spread(pathway, weight, fill=0) %>%
        data.frame(row.names = 1, check.names = FALSE, stringsAsFactors = FALSE)
  
  return(model)
}
