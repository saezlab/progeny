## ---- eval=FALSE--------------------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  
#  BiocManager::install("progeny")
#  
#  ## To install the new version until it is submited to Bioconductor use:
#  devtools::install_github("saezlab/progeny", ref = "bioc_update")

## ---- message=FALSE-----------------------------------------------------------
library(progeny)
library(dplyr)
library(Seurat)
library(ggplot2)
library(tidyr)
library(readr)
library(pheatmap)
library(tibble)

## ---- eval=FALSE--------------------------------------------------------------
#  ## Load the PBMC dataset
#  pbmc.data <-
#      Read10X(data.dir = "../data/pbmc3k/filtered_gene_bc_matrices/hg19/")
#  ## Initialize the Seurat object with the raw (non-normalized data).
#  pbmc <-
#      CreateSeuratObject(counts = pbmc.data, project = "pbmc3k", min.cells = 3,
#      min.features = 200)

## ---- eval=TRUE , include=FALSE-----------------------------------------------
pbmc <- 
    readRDS(url("https://github.com/alberto-valdeolivas/ProgenyVignette/raw/master/SeuratObject.rds"))

## ---- message=FALSE-----------------------------------------------------------
## Identification of mithocondrial genes
pbmc[["percent.mt"]] <- PercentageFeatureSet(pbmc, pattern = "^MT-")

## Filtering cells following standard QC criteria.
pbmc <- subset(pbmc, subset = nFeature_RNA > 200 & nFeature_RNA < 2500 & 
    percent.mt < 5)

## Normalizing the data
pbmc <- NormalizeData(pbmc, normalization.method = "LogNormalize", 
    scale.factor = 10000)

pbmc <- NormalizeData(pbmc)

## Identify the 2000 most highly variable genes
pbmc <- FindVariableFeatures(pbmc, selection.method = "vst", nfeatures = 2000)

## In addition we scale the data
all.genes <- rownames(pbmc)
pbmc <- ScaleData(pbmc, features = all.genes)

## ---- message=FALSE, warning=FALSE--------------------------------------------
pbmc <- 
    RunPCA(pbmc, features = VariableFeatures(object = pbmc), verbose = FALSE)
pbmc <- FindNeighbors(pbmc, dims = 1:10, verbose = FALSE)
pbmc <- FindClusters(pbmc, resolution = 0.5, verbose = FALSE)
pbmc <- RunUMAP(pbmc, dims = 1:10,  umap.method = 'umap-learn',  
    metric='correlation')

## -----------------------------------------------------------------------------
DimPlot(pbmc, reduction = "umap")

