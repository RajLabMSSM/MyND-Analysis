## MyND_Analysis Release v1
#### July 29th, 2021
MyND Project 

> All code is in R and depends on packages from CRAN and/ or Bioconductor.

> This includes code and some plots. Exploratory analysis and intermediate processing files are too large for this repository.

**************
Analysis Pages
**************
1. PD Monocyte Analysis:
   - [Monocyte Quality Control](https://github.com/RajLabMSSM/MyND-Analysis/master/qc/mynd_qc_output.html)
   - [Variance Partition](https://github.com/RajLabMSSM/MyND-Analysis/blob/master/qc/var.part.all.html)
   - [Differential Gene Expression Result Summary](https://github.com/RajLabMSSM/MyND-Analysis/blob/master/de/dge/test.html)
   - [L-Dopa Correlation](https://github.com/RajLabMSSM/MyND-Analysis/blob/master/de/ldopa/ldopacorr.html)
   - [WGCNA Eigengene approach](https://github.com/RajLabMSSM/MyND-Analysis/blob/master/mynd_revision/eigen_approach/eigen_approach.html). Beeswarm plots for the Figures 3A and 3B.

2. Microglia dataset 36 PD vs 116 CT: 
   - [Variance Partition](https://github.com/RajLabMSSM/MyND-Analysis/blob/master/mynd_revision/microglia_analysis/01_vp.html). Cannonical correlation and violin plots from Variance Partition. 
   - [Differential expression analysis](https://github.com/RajLabMSSM/MyND-Analysis/blob/master/mynd_revision/microglia_analysis/02_deg_pdxct_dupCor_death.html). The model accounts for PMI and cause of death. Tool = Limma with Duplicate correlation to account for repeated measures. 
 
3. AMP-PD Analyses
   - [AMP-PD Qualtiy Control](https://github.com/RajLabMSSM/MyND-Analysis/blob/master/amp-pd/ampqc.html)
   - [Variance Partition](https://github.com/RajLabMSSM/MyND-Analysis/blob/master/amp-pd/vp.html)
   - [Differential Gene Expression Result Summary](https://github.com/RajLabMSSM/MyND-Analysis/blob/master/amp-pd/output.html)

4. Analysis Scripts
   - [Monocyte DGE](https://github.com/RajLabMSSM/MyND-Analysis/blob/master/scripts/monocyte_dge.R)
   - [Monocyte DTE](https://github.com/RajLabMSSM/MyND-Analysis/blob/master/scripts/monocyte_dte.R)
   - [Microglia DGE](https://github.com/RajLabMSSM/MyND-Analysis/blob/master/scripts/microglia_dge.Rmd)
   - [AMP-PD DGE](https://github.com/RajLabMSSM/MyND-Analysis/blob/master/scripts/AMP-PD_dge.R)

