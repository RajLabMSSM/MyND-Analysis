# Katia Lopes
# Trying to answer the reviewer 
# May 6, 2021 

library(Seurat)
library(ggplot2)
library(tidyverse)
library(kableExtra)

pd_path = "~/pd-omics/brian/PD_scRNAseq/Data/"

query <- readRDS(paste0(pd_path, "processed_seurat_obj.RDS"))
query 

p_query <- DimPlot(object = query, label = TRUE, label.size = 4, repel = TRUE) + 
  NoLegend() +
  labs(title = "MyND-PD")
p_query

## Number of cells by sample
### Table

mynd <- query
cells_sample <- mynd@meta.data$HTO 

as.data.frame(table(cells_sample), useNA = "ifany" ) %>%
  arrange(Freq) %>%
  kable(row.names = F) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive"))


as.data.frame(table(cells_sample))

              