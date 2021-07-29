#library(tximport)
#dir = "/hpc/users/navare04/pd-omics/data/mynd/rsem"#Make the directory to the RAPID folder
#dir1= '/Processed/RAPiD.2_0_0/rsem/'#Make a second directory fot the processed (for that just type into any sample folder and just copy that part of the path, without the sample-id folder) 
#samples = read.table('/hpc/users/navare04/pd-omics/data/mynd/analysis/rsem.tximport/all_samples/metadata_pd_batch1_batch2.txt', header = T, check.names = F)
#sample <- samples$id
#files = file.path(dir, sample, paste0(samples$id, ".genes.results"))#dir -1st path- then go to each of the samples folder, then - dir1 for the processed data/// choose '.genes.results' or 'isoform.results' (both are in the same folder)
#all(file.exists(files))
#names(files) = samples$id
#txi.rsem <- tximport(files, type = "rsem")
#head(txi.rsem$counts)
#head(txi.rsem$abundance)

library(limma)
library(edgeR)
library(data.table)

pheno = read.table("/sc/hydra/projects/pd-omics/mynd/analyses/analysis_9_19_19/differential_expression_11.04.2019/metadata_11.04.2019", header = T, row.names = 1, check.names = F)
pheno$rna_batch = as.factor(pheno$rna_batch)
pheno$season = as.factor(pheno$season)

counts = read.table("/sc/hydra/projects/pd-omics/mynd/analyses/analysis_9_19_19/differential_expression_11.04.2019/mynd.counts.txt", header = TRUE, check.names = FALSE)
identical(rownames(pheno), colnames(counts))
x <- DGEList(counts=counts, samples=pheno)
cpm = cpm(x)

pheno$status <- relevel(pheno$status, ref="Control")
#pheno$gba <- relevel(pheno$gba, ref='N')
#pheno$lrrk2 <- relevel(pheno$lrrk2, ref = 'N')

#Design: 
#design_1 <- model.matrix(~ rna_batch + PCT_USABLE_BASES + rin_value + age + mds1 + mds2 + mds3 + mds4 + gender + status, data = pheno) #traditional design we were using (198 genes) design_0
design_1 <- model.matrix(~ rna_batch + PCT_USABLE_BASES + PCT_RIBOSOMAL_BASES + rin_value + age + mds1 + mds2 + mds3 + mds4 + gender + status, data = pheno) #adding %of ribosomal bases as covariate (design1)
#design_1 <- model.matrix(~ V1 + V2 + V3 + V4 + status, data = pheno) #using the first 4 SVAs from Katia (design2)
#design_1 <- model.matrix(~ V1 + V2 + V3 + V4 + V5 + V6 + status, data = pheno)  #using 6 first SVs from Katia (design3)
#design_1 <- model.matrix(~ V1 + V2 + V3 + gender + status, data = pheno) #heatmap of Katia:  SVs capture most of variability. Gender is correlated with 5th SV (but also status). So to avoid regressing out status we tried this model design4)
#design_1 <- model.matrix(~ V1 + V2 + V3 + V4 + gender + status, data = pheno) #heatmap of Katia: 4 SVs capture most of variability. Gender is correlated with 5th SV (but also status). So to avoid regressing out status we tried this model (design5)
#design_1 <- model.matrix(~ rna_batch + PCT_USABLE_BASES + PCT_RIBOSOMAL_BASES + PCT_INTERGENIC_BASES + PCT_CODING_BASES + MEDIAN_5PRIME_BIAS + rin_value + age + mds1 + mds2 + mds3 + mds4 + gender + status, data = pheno) (design6)
#design_1 <- model.matrix(~ rna_batch + PCT_USABLE_BASES + PCT_RIBOSOMAL_BASES + TOTAL_READS + INTRONIC_BASES + PCT_INTRONIC_BASES + CODING_BASES + INTERGENIC_BASES + MEDIAN_5PRIME_BIAS + PCT_PF_READS_ALIGNED + PERCENT_DUPLICATION + rin_value + age + mds1 + mds2 + mds3 + mds4 + gender + status, data = pheno) (design7)
#design_1 <- model.matrix(~ rna_batch + PCT_USABLE_BASES + PCT_RIBOSOMAL_BASES + TOTAL_READS + PCT_INTRONIC_BASES + CODING_BASES + INTERGENIC_BASES + rin_value + age + mds1 + mds2 + mds3 + mds4 + gender + status, data = pheno) (design8)

keep.exp = rowSums(cpm > 1) >= 0.3*ncol(x) #Filtering
x = x[keep.exp,]
x = calcNormFactors(x, method = "TMM") #normalized counts with TMM

v = voom(x, design_1)
vfit <- lmFit(v, design_1)
efit <- eBayes(vfit)
topTable(efit, coef=ncol(design_1)) #table with the top DE 
summary(decideTests(efit, p.value  = "0.05")) #Summary with the number of up and down
resPD <- topTable(efit, coef=ncol(design_1), number = nrow(efit), sort.by="p")
write.table(resPD, 'rsem.mynd.mds.use.1.txt')