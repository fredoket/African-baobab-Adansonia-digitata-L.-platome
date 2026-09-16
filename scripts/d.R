ggplot(nu_gene, aes(x = reorder(Gene, pi), y = pi, fill = Location)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  scale_fill_manual(values = c("LSC" = "skyblue", "SSC" = "orange", "IR" = "green")) +
  labs(x = "Gene", y = "Nucleotide Diversity (π)", fill = "Genome Region") +
  theme_classic()

ggplot(nu_gene, aes(x = Location, y = pi, fill = Location)) +
  geom_boxplot() +
  scale_fill_manual(values = c("LSC" = "skyblue", "SSC" = "orange", "IR" = "green")) +
  labs(x = "Genome Region", y = "Nucleotide Diversity (π)") +
  theme_classic()

ggplot(nu_gene, aes(x = Gene, y = pi, color = Location)) +
  geom_point(size = 3) +
  geom_hline(yintercept = mean(nu_gene$pi), linetype = "dashed") +
  scale_color_manual(values = c("LSC" = "skyblue", "SSC" = "orange", "IR" = "green")) +
  labs(x = "Gene", y = "Nucleotide Diversity (π)", color = "Genome Region") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))

library(ggplot2)
library(ggrepel)

mean_pi <- mean(nu_gene$pi)

ggplot(nu_gene, aes(x = Gene, y = pi, color = Location)) +
  geom_point(size = 2) +
  geom_hline(yintercept = mean_pi, linetype = "dashed") +
  geom_text_repel(
    data = subset(nu_gene, pi > mean_pi),
    aes(label = Gene),
    size = 4,
    nudge_y = 0.001,      # slightly above points
    angle = 90,
    max.overlaps = Inf
  ) +
  scale_color_manual(values = c("LSC" = "black", "SSC" = "red", "IR" = "blue")) +
  labs(x = "Gene", y = "Nucleotide Diversity (π)", color = "Genome Region") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))

library(ggplot2)
library(ggrepel)

mean_pie <- mean(nu_igs$pi)

ggplot(nu_igs, aes(x = IGS, y = pi, color = Locus)) +
  geom_point(size = 2) +
  geom_hline(yintercept = mean_pie, linetype = "dashed") +
  geom_text_repel(
    data = subset(nu_igs, pi > mean_pie),
    aes(label = IGS),
    size = 4,
    nudge_y = 0.001,      # slightly above points
    angle = 90,
    max.overlaps = Inf
  ) +
  scale_color_manual(values = c("LSC" = "black", "SSC" = "red", "IR" = "blue")) +
  labs(x = "Gene", y = "Nucleotide Diversity (π)", color = "Genome Region") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))
