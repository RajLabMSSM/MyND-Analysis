# Katia Lopes
# Trying to answer one question of revision
# May 12, 2021

library("readxl")
library(ggplot2)
library(ggeasy)

sc_path <- "/Users/katia/OneDrive/Documentos/MountSinai/Projects/MyND_PD/MyND_PD_230s/MyND_aging/MyND_resub/"

metadata = paste0(sc_path, "Navarro_et_al_Tables_apr2021_FINAL.xlsx")
metadata = read_excel(metadata, sheet = "Table 16 Microglia DGE", col_names = TRUE)  
metadata = as.data.frame(metadata) 

head(metadata)
dim(metadata)

deg_lists = metadata[which(metadata$adj.P.Val<0.10),] # 222 at 10% OR 809 at 15%


# DE genes from Smajic et al 
# https://www.medrxiv.org/content/10.1101/2020.09.28.20202812v1 Fig 3F 

smajic_g <- c("ST6GALNAC3", 
              "DPYD",
              "TBC1D8",
              "TMEM163",
              "DIRC3",
              "SLC11A1",
              "PTPRG",
              "BCL6",
              "TPRG1",
              "SPP1",
              "ACSL1", 
              "SH3PXD2B",
              "HSPA1A",
              "GPNMB",
              "NAMPT",
              "GK",
              "CEMIP2",
              "SHOC1",
              "CADM1",
              "SRGN",
              "P4HA1",
              "CD163",
              "CPM",
              "PLXNC1",
              "HSPH1",
              "STARD13",
              "MYO1E",
              "MAFB",
              "GRAMD4")
  
smajic_g %in% deg_lists$GeneSymbol 
  
deg_lists[deg_lists$GeneSymbol %in% smajic_g ,]  

# FDR 10% = 2 genes in commom 
# Ensmnl    logFC  AveExpr        t     P.Value  adj.P.Val    z.std GeneSymbol
# 77  ENSG00000136040.9 1.297788 4.836803 3.876974 0.000334332 0.08616220 3.587135     PLXNC1
# 85 ENSG00000144724.20 1.061724 2.364397 3.887323 0.000350311 0.08664255 3.574938      PTPRG

# FDR 15% = 3 genes in commom 
# Ensmnl    logFC   AveExpr        t     P.Value  adj.P.Val    z.std GeneSymbol
# 77   ENSG00000136040.9 1.297788 4.8368028 3.876974 0.000334332 0.08616220 3.587135     PLXNC1
# 85  ENSG00000144724.20 1.061724 2.3643971 3.887323 0.000350311 0.08664255 3.574938      PTPRG
# 752 ENSG00000165181.16 1.002660 0.8526278 2.904606 0.005557226 0.14547884 2.772823      SHOC1

# Contigence table for Fisher's exact test
# a = Smajic in overlap = 2g  
# b = DGE mic 222 - 2 = 220g
# c = Smajic - overlap = 27g 
# d = Total non_DGE = 19728 - 222 = 19506g

a = 2
b = 220
c = 27
d = 19506

contigence_table = matrix(c(a, c, b, d), nrow = 2)
fisher_results = fisher.test(contigence_table, alternative = "greater") # greater means that we checking for enrichment on our dataset instead of less
fisher_results



