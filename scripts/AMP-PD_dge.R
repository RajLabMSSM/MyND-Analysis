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

pheno = read.csv("/sc/orga/projects/pd-omics/data/amp-pd/evan/amp-pd_metadata.csv", header = T, row.names = 1, check.names = F)

counts = read.table("/sc/orga/projects/pd-omics/data/amp-pd/evan/amp-pd_baseline_counts.txt", header = TRUE, check.names = FALSE)
identical(rownames(pheno), colnames(counts))
counts = counts[rownames(pheno)]
x <- DGEList(counts=counts, samples=pheno)
cpm = cpm(x)

pheno$status <- relevel(pheno$status, ref="Control")
#pheno$gba <- relevel(pheno$gba, ref='N')
#pheno$lrrk2 <- relevel(pheno$lrrk2, ref = 'N')

#Design: 
#design_1 <- model.matrix(~ PCT_USABLE_BASES + PCT_INTERGENIC_BASES + Plate + Box + RIN_Value + age_at_baseline + sex + status, data = pheno) #adding %of ribosomal bases as covariate (design1)
#design_2 <- model.matrix(~ PCT_USABLE_BASES + PCT_INTERGENIC_BASES + race + ethnicity + Plate + Box + RIN_Value + age_at_baseline + sex + status, data = pheno)
design_3 <- model.matrix(~ PCT_USABLE_BASES + PCT_INTERGENIC_BASES + race + ethnicity + Box  + RIN_Value + age_at_baseline + sex + Normalization_Volume__30ng_ul_ + status, data = pheno)


keep.exp = rowSums(cpm > 1) >= 0.3*ncol(x) #Filtering
x = x[keep.exp,]
x = calcNormFactors(x, method = "TMM") #normalized counts with TMM

v = voom(x, design_3)
vfit <- lmFit(v, design_3)
efit <- eBayes(vfit)
topTable(efit, coef=ncol(design_3)) #table with the top DE 
summary(decideTests(efit, p.value  = "0.05")) #Summary with the number of up and down
resPD <- topTable(efit, coef=ncol(design_3), number = nrow(efit), sort.by="p")
SE <- sqrt(efit$s2.post) * efit$stdev.unscaled
write.table(resPD, 'TESTrsem.amppd.design3.txt')
write.table(SE, 'standard.error.amp.txt')
