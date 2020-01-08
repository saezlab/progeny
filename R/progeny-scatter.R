#'This function generate a series of scatter plot with marginal distribution
#'(in the form of an arrangeGrob object), for each progeny pathway and 
#'sample/contrast.Each scatter plot has progeny weights as x axis and the gene 
#'level stat used to compute progeny score as y axis. The marginal distribution
#'of the gene level stats is displayed on the right of the plot to give a visual
#'support of the significnce of each gene contributing to the progeny pathway
#'score. The colors green and red represent respectivelly positive and negative
#'contribution of genes to the progeny pathway. For each gene contribution, 
#'4 cases are possible, as the combinaisons of the sign of the gene level stat
#'and the sign of the gene level weigth.
#'Positive weight will lead to a positive(green)/negative(red) gene contribution
#'if the gene level stat is positive/negative. Negative weigth will lead to
#'a negative(red)/positive(green) gene contribution if the gene level stat is
#'positive/negative.
#'
#'@param df a n*m data frame, where n is the number of omic features (genes). 
#'m isn't really important, as long as at least one column corespond to a sample
#'or contrast statistic. One of the column should correspond to the gene symboles.
#'@param cm a progeny coeficient matrix. One of the column should be the gene symboles.
#'@param dfID an integer corresponding to the column number of the gene identifiers of df.
#'@param weightID an integer corresponding to the column number of the gene 
#'identifiers of the weight matrix.
#'@param statname The neame of the stat used, to be displayed on the plot
#'@import ggplot2 
#'@importFrom ggrepel geom_label_repel
#'@importFrom gridExtra arrangeGrob
#'@return The function returns a list of list of arrangeGrob object.
#'The first level list elements correspond to samples/contrasts. 
#'The second level correspond to pathways.
#'The plots can be saved in a pdf format using the saveProgenyPlots function.
#'@export
progenyScatter <- function(df,weight_matrix,dfID = 1, weightID = 1, statName = "gene stats")
{
  plot_list_contrasts <- list(0)
  for (i in 2:length(df[1,]))
  {
    plot_list_pathways <- list(0)
    for (j in 2:length(weight_matrix[1,]))
    {
      sub_df <- df[,c(dfID,i)]
      
      pathway_weights <- weight_matrix[,c(weightID,j)]
      names(sub_df) <- c("ID","stat")
      
      minstat <- min(sub_df$stat)
      maxstat <- max(sub_df$stat)
      histo <- ggplot(sub_df, aes(x = stat, fill = "blue")) + geom_density() +
        coord_flip() + scale_fill_manual( values = c("#00c5ff")) + 
        xlim(minstat, maxstat) + theme_minimal() + 
        theme(legend.position = "none", axis.text.x = element_blank(),
              axis.ticks.x = element_blank(), axis.title.y = element_blank(),
              axis.text.y = element_blank(), axis.ticks.y = element_blank(),
              panel.grid.major = element_blank(),
              panel.grid.minor = element_blank()
              )
      
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
      
      print(paste("weights of ",names(weight_matrix)[j], sep = ""))
      
      title <- paste("weights of ",names(weight_matrix)[j], sep = "")
      
      scatterplot <- ggplot(sub_df, aes(x = weight, y = stat, color = color)) +
        geom_point() +
        #scale_colour_manual(values = c("#15ff00","#ff0000","#c9c9c9")) +
        #green and red
        scale_colour_manual(values = c("red","royalblue3","grey")) +
        geom_label_repel(aes(label = ID)) +
        ylim(minstat, maxstat) + theme_minimal() +
        theme(legend.position = "none") +
        geom_vline(xintercept = 0, linetype = 'dotted') +
        geom_hline(yintercept = 0, linetype = 'dotted') +
        labs(x = title, y = statName)
      
      lay <- t(as.matrix(c(1,1,1,1,2)))
      gg <- arrangeGrob(scatterplot, histo, nrow = 1, ncol = 2, layout_matrix = lay)
      
      #grid.arrange(gg)
      plot_list_pathways[[j-1]] <- gg
    }
    names(plot_list_pathways) <- names(weight_matrix[,-weightID])
    plot_list_contrasts[[i-1]] <- plot_list_pathways
  }
  return(plot_list_contrasts)
}

#'\code{saveProgenyPlots}
#'
#'This function is designed to save the plots (in pdf format) of a nested (2 level) list of arrangeGrob objects, such as the one returned by the progenyScatter function.
#'
#'@param plots a list of list of arrangeGrob object (such as the one returned by the progenyScatter function.).The first level list elements correspond to samples/contrasts. The second level correspond to pathways.
#'The plots can be saved in a pdf format using the saveProgenyPlots function.
#'@param contrast_names a vector of same length as the first level of the plot list corresponding to the names of each sample/contrast
#'@param dirpath the path to the directory where the plotsshould be saved
#'@export
saveProgenyPlots <- function(plots, contrast_names, dirpath)
{
  i <- 1
  for (condition in plots)
  {
    dirname <- paste(dirpath,contrast_names[i], sep = "")
    dir.create(dirname, recursive = T, showWarnings = F)
    j <- 1
    for (pathway in condition)
    {
      filename <- paste(dirname,names(condition)[j],sep = "/")
      filename <- paste(filename,".pdf",sep = "")
      print(filename)
      ggsave(filename, pathway,device = "pdf", dpi = 300)
      j <- j+1
    }
    i <- i+1
  }
}