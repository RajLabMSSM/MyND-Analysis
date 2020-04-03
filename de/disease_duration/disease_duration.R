library(data.table)
library(ggplot2)
x = read.table('Desktop/MyND/Paper_Dec_2019/differential_expression_11.04.2019/mynd_metadata_9_19_19.txt', header = T)
head(x)
x = x[!is.na(x$dd),]
rownames(x) = x$rnaseq_id
dim(x)
head(x)
x = x[c(5)]
exp = read.table('Desktop/MyND/Paper_Dec_2019/differential_expression_11.04.2019/mynd_voom_residuals.txt', header = T, check.names = F)
head(exp)
genes = read.table('Desktop/MyND/Paper_Dec_2019/differential_expression_11.04.2019/dge/rsem.mynd.design_1.txt', hea =T)
head(genes)
head(x)

texp = data.frame(t(exp), check.names = F)
tot = merge(texp, x, by = 0)
#head(tot)
dim(tot)
tot$Row.names = NULL
tot$samples = NULL

dd = data.frame(tot$dd)
rownames(dd) = rownames(tot)

res = data.frame(t((cor(tot$dd, tot, method = "kendall"))), check.names = F)
head(res)
colnames(res) = c("cor")
head(res)
res$index = c(1:nrow(res))
sig_de = genes[genes$adj.P.Val < .05,]
head(sig_de)

res$de = rownames(res) %in% rownames(sig_de)
head(res)
sig = res[res$de == TRUE,]
sig
sig$gene_id = rownames(sig)
ann = read.table('Desktop/MyND/ens.geneid.gencode.v30' ,hea = T)
head(ann)
sigt = merge(sig, ann, by = "gene_id")
sigt = sigt[order(sigt$cor),]
sigt$GeneSymbol<- factor(sigt$GeneSymbol, levels = sigt$GeneSymbol[order(sigt$cor)])
head(sigt)
p = ggplot(sigt, aes(GeneSymbol, cor, fill = cor))
p + geom_bar(stat = "identity") + theme(axis.text.x = element_text(angle = 90)) + theme(axis.text.x = element_text(size = 5))



library(ggrepel)
library(ggplot2)
#p = ggplot(sigt, aes(x=reorder(index, row), cor, color = cor, label = GeneSymbol))
#p + geom_point() + geom_label_repel() + theme_light()

res1 = genes
res1 = res1[res1$adj.P.Val > .95,]
dim(res1)
mitocor = merge(res1, mitocor, by = 'ensid')
sig_cor = merge(res, res1, by.x = 0, by.y = 'ensid')
head(sig_cor)

head(mitocor)
range(mitocor$cor)
mean(mitocor$cor)
rownames(mitocor) = mitocor$Row.names
barplot(mitocor$cor)

