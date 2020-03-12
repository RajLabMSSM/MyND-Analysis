## MyND_Analysis
#### March 9th, 2020
MyND Project 

> All code is in R and depends on packages from CRAN and/ or Bioconductor.

> This includes code and plots. Exploratory analysis and intermediate processing files are too large for this repository.

**************************************
RESULT PAGES - Updated Jan 31st
**************************************

1. [MultiQC](https://rajlabmssm.github.io/MyND-Analysis/qc/multiqc_report.html): Results of multiqc on full set of samples (337) - including previously determined outliers, AD, and MCI cases


2. [Quality Control and Exploratory Analysis (QC filtered)](https://rajlabmssm.github.io/MyND-Analysis/qc/mynd_qc_output.html):
- QC Filter: Remove all samples with:
	- < than 20,000,000 Reads
	- < 20% reads mapping to coding regions
	- Duplicate Samples
	- Swapped Samples
	- Samples with comorbidities

3. [Overview of Clean Samples](https://rajlabmssm.github.io/MyND-Analysis/qc/mynd_overview_output.html): Metadata Breakdown and Basic Clinical Details

4. Variance Partition and Model Fitting:
	- [Variance Partition](https://rajlabmssm.github.io/MyND-Analysis/qc/var.part.all.html)
	- [Model Fitting](https://rajlabmssm.github.io/MyND-Analysis/qc/cov_selection.html)
		- Used limma BIC to fit multiple models

5. Correlations
	- [PCA](https://rajlabmssm.github.io/MyND-Analysis/qc/pca.corr.html)
	- [PEER](https://rajlabmssm.github.io/MyND-Analysis/qc/peer_correlation.html)

6. Differential Expression
- [MyND Differential Gene Expression](https://rajlabmssm.github.io/MyND-Analysis/de/dge/test.html)
	- [Comparisons with Other Datasets](https://rajlabmssm.github.io/MyND-Analysis/de/dge/comparisons.html)
	- [Disease Duration Correlation](https://rajlabmssm.github.io/MyND-Analysis/de/disease_duration/disease_duration.html)

7. AMP-PD Analyses
- [amp-pd qc](https://rajlabmssm.github.io/MyND-Analysis/amp-pd/amppdqc.html)
- [variance partition](https://rajlabmssm.github.io/MyND-Analysis/amp-pd/vp.html)
- [differential expression](https://rajlabmssm.github.io/MyND-Analysis/amp-pd/output.html)
-------------------------------------
-------------------------------------
**************************************
RESULT PAGES - Old Files
**************************************

[Quality Control and Exploratory Analysis (all samples)](https://rajlabmssm.github.io/MyND-Analysis/old_files/mynd.qc.html): Diverse plots for visualization including MDS, heatmaps, density, boxplots and PCA plots.

[Quality Control and Exploratory Analysis (QC filter 1)](https://rajlabmssm.github.io/MyND-Analysis/old_files/filtered.qc.html):
- QC Filter 1: Remove all samples with:
	- < than 20,000,000 Reads
	- < 20% reads mapping to coding regions
	- Duplicate Samples

[PC Correlations](https://rajlabmssm.github.io/MyND-Analysis/old_files/pca.corr.html): Correlation of Principal Components with known covariates

[Variance Partition](https://rajlabmssm.github.io/MyND-Analysis/old_files/variance.partition.html): Variance Partion Violin Plot and Canoncial Correlation Analysis


**************************************
RESULT PAGES - OLD RAPiD
**************************************

[Quality Control and Exploratory Analysis](https://rajlabmssm.github.io/MyND-Analysis/old_files/mynd.qc2.html): Diverse plots for visualization including MDS, heatmaps, density, boxplots and PCA plots.

[Variance Partition](https://rajlabmssm.github.io/MyND-Analysis/old_files/mynd.variance_partition.html): Variance Partion Violin Plot and Canoncial Correlation Analysis
