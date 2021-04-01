# Katia Lopes
# April 1, 2021
# Power analysis for DE 

BiocManager::install("RNASeqPower")
library(RNASeqPower)
library(ggplot2)

# Values for the statistical parameters are traditionally set to α=.05 and power of .8 or .9. As a
# guide for depth and CV Hart et al [1] found that over a range of experiments 85%–95% of targets
# had coverage of .1 per million mapped, i.e. that a total depth of 40 million would give a coverage
# of ≥ 4 for the majority of targets. They also found an average within group CV of ≤ 0.4 for 90%
# of the genes in a range of human studies, with a lower CV of 0.1 for inbred animals. There will
# always be a few transcripts with either very low coverage or high within-group variation and for
# these sample sizes and/or depth would need to be very large. Power calculations would normally
# be targeted to the majority of targets that are better behaved.
# Microglia sample sizes

sample_size_control = 42
sample_size_cases = 13

# Show how unbalanced designs affect the power
# Loop over number of samples between balanced and unbalanced

res = list()
n_cases = 13
effect_range = seq(1.5,4,0.1) # relative expression that we wish to detect (FC)
for (n_controls in seq(10,50,5)){
  res[[as.character(n_controls)]] = rnapower(depth = 3, cv = .4, n = n_cases, n2 = n_controls, effect=effect_range, alpha = .05)
}
df <- data.frame(n_controls = names(res), matrix(unlist(res), nrow=length(res), byrow=TRUE))
colnames(df) <- c("n_controls",effect_range)
df_m <- reshape2::melt(df)

ggplot(reshape2::melt(df), aes(x = variable, y = value, color = n_controls, group = n_controls)) +
  geom_point() + geom_line() + labs(x = "Fold-change", y = "Power") + 
  theme_bw()

