# -----------------------------------------------------------------------------
# LOAD LIBRARIES
# -----------------------------------------------------------------------------

library(dplyr)
library(tidyr)
library(ggplot2)
library(vegan)
library(viridisLite)
library(pheatmap)
library(vegan)
library(ape)

# -----------------------------------------------------------------------------
# LOAD DATA
# -----------------------------------------------------------------------------

df <- read.table("data/mash_distances_clean.tsv",
  sep = "\t",
  header = FALSE,
  stringsAsFactors = FALSE
)

colnames(df) <- c(
  "genome1",
  "genome2",
  "distance",
  "pvalue",
  "shared"
)

# -----------------------------------------------------------------------------
# CREATE DISTANCE MATRIX
# -----------------------------------------------------------------------------

matrix_df <- df %>%
  select(genome1, genome2, distance) %>%
  pivot_wider(
    names_from = genome2,
    values_from = distance
  )

# Set row names
matrix <- as.data.frame(matrix_df)
rownames(matrix) <- matrix$genome1
matrix$genome1 <- NULL

# Convert to numeric matrix
matrix <- as.matrix(matrix)

# Fill missing values with 0
matrix[is.na(matrix)] <- 0

# Ensure symmetry
matrix <- (matrix + t(matrix)) / 2

# -----------------------------------------------------------------------------
# 1. HEATMAP
# -----------------------------------------------------------------------------

png(
  "mash_heatmap.png",
  width = 3000,
  height = 2500,
  res = 300
)

pheatmap(
  matrix,
  color = viridisLite::viridis(100),
  clustering_method = "average",
  fontsize_row = 6,
  fontsize_col = 6,
  border_color = NA
)

dev.off()

cat("✔ Heatmap saved: mash_heatmap.png\n")

# -----------------------------------------------------------------------------
# 2. DENDROGRAM
# -----------------------------------------------------------------------------

dist_obj <- as.dist(matrix)

hc <- hclust(dist_obj, method = "average")

png(
  "mash_dendrogram.png",
  width = 3500,
  height = 1800,
  res = 300
)

plot(
  hc,
  cex = 0.5,
  main = "Mash Dendrogram (Average linkage)",
  xlab = "",
  sub = ""
)

dev.off()

cat("✔ Dendrogram saved: mash_dendrogram.png\n")

# -----------------------------------------------------------------------------
# 3. MDS PLOT
# -----------------------------------------------------------------------------

mds <- metaMDS(
  dist_obj,
  k = 2,
  trymax = 100
)

coords <- as.data.frame(mds$points)
coords$genome <- rownames(coords)

p <- ggplot(coords, aes(x = MDS1, y = MDS2)) +
  geom_point(size = 2) +
  geom_text(
    aes(label = genome),
    size = 2,
    vjust = -0.5
  ) +
  theme_bw() +
  ggtitle("Mash MDS Plot (Genome Diversity)")

ggsave(
  "mash_mds.png",
  p,
  width = 10,
  height = 8,
  dpi = 300
)

cat("✔ MDS plot saved: mash_mds.png\n")

cat("\nDONE: All Mash visualizations generated.\n")

