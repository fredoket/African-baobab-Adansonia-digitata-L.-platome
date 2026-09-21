# install.packages("pheatmap")
library(pheatmap)
library(readr)
library(janitor)
library(dplyr)

codon_data <- read_csv("data/rscu_clean.csv") |>
  clean_names() |>
  mutate(codon_label = paste0(codon, "(", amino_acid, ")")) |>
  relocate(codon_label, .before = amino_acid) |>
  select(-codon, -amino_acid)


library(tidyverse)
codon_long <- codon_data %>%
  rownames_to_column("Species") %>%
  pivot_longer(
    cols = where(is.numeric),   # only pivot numeric columns
    names_to = "Codon_AA",
    values_to = "Value"
  ) |>
  arrange(desc(Value))

# Optional: order codons (important for clean visualization)
codon_long$Codon_AA <- factor(codon_long$Codon_AA, levels = colnames(codon_data))

# Plot heatmap
ggplot(codon_long, aes(x = codon_label, y = Codon_AA, fill = Value)) +
  geom_tile(color = "yellow") +
  scale_fill_gradient(low = "blue", high = "red") +
  labs(
    x = "Codon (Amino Acid)",
    y = "Species",
    fill = "Codon Usage"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
    panel.grid = element_blank()
  )



# Set Codon_AA as row names and remove unnecessary column
heatmap_mat <- codon_data |> 
  column_to_rownames("codon_label") |> 
  as.matrix()

# Transpose matrix
heatmap_mat_t <- t(heatmap_mat)


p <- pheatmap(
  heatmap_mat_t,
  scale = "none",
  color = colorRampPalette(c("#07169C", "white", "#C82909"))(100),
  breaks = seq(0, 2, length.out = 101),
  clustering_distance_rows = "euclidean",
  clustering_distance_cols = "euclidean",
  angle_col = 90,
  border_color = "white",   # clean grid lines
  fontsize_row = 11,
  fontsize_col = 11
)

p

# Save as PDF (vector format)
pdf(
  file = "RSCU_heatmap.pdf",
  width = 12,  
  height = 7
)

p <- pheatmap(
  heatmap_mat_t,
  scale = "none",
  color = colorRampPalette(c("#07169C", "white", "#C82909"))(100),
  breaks = seq(0, 2, length.out = 101),
  clustering_distance_rows = "euclidean",
  clustering_distance_cols = "euclidean",
  angle_col = 90,
  border_color = "white",
  fontsize_row = 11,
  fontsize_col = 11
)

dev.off()
