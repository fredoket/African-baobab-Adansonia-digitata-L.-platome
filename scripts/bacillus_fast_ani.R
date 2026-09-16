# FastANI Heatmap Generation Script
# Simple and organized format for ANI matrix visualization

library(pheatmap)
library(RColorBrewer)

# ============================================
# STEP 1: LOAD AND PREPARE DATA
# ============================================

ani_raw <- read.table("data/fastani_output_new.txt",
                      header = FALSE,
                      sep = "\t",
                      stringsAsFactors = FALSE,
                      col.names = c("Query", "Subject", "ANI", "Aligned_length", "Query_length"))

# Clean strain names (remove .fna extension)
ani_raw$Query <- gsub("\\.fna$", "", ani_raw$Query)
ani_raw$Subject <- gsub("\\.fna$", "", ani_raw$Subject)

ani <- matrix(NA, ...)                             # Create empty
for (i in 1:nrow(ani_raw)) {                       # Fill from data
  ani[j, k] <- ani[k, j] <- ani_raw$ANI[i]        # Both directions
}
rownames(ani) <- colnames(ani) <- all_strains     # Add strain names

# ============================================
# STEP 2: CREATE ANI MATRIX
# ============================================

# Get all unique strains and sort
all_strains <- sort(unique(c(ani_raw$Query, ani_raw$Subject)))

# Initialize empty matrix
ani <- matrix(NA,
              nrow = length(all_strains),
              ncol = length(all_strains))

# Fill matrix with ANI values (both directions)
for (i in 1:nrow(ani_raw)) {
  query_idx <- match(ani_raw$Query[i], all_strains)
  subject_idx <- match(ani_raw$Subject[i], all_strains)
  ani_value <- ani_raw$ANI[i]
  
  # Fill both directions to ensure symmetry
  ani[query_idx, subject_idx] <- ani_value
  ani[subject_idx, query_idx] <- ani_value
}

# Set diagonal to 100 (self-comparison)
diag(ani) <- 100

# Add strain names to matrix
rownames(ani) <- colnames(ani) <- all_strains

# ============================================
# STEP 3: CREATE COLOR SCALE
# ============================================

# Alternative color palettes:

 cols <- colorRampPalette(rev(brewer.pal(9, "RdYlBu")))(100)
# cols <- colorRampPalette(brewer.pal(9, "RdYlGn"))(100)
#vcols <- colorRampPalette(brewer.pal(9, "YlOrRd"))(100)
 # cols <- colorRampPalette(brewer.pal(11, "Spectral"))(100)

# ============================================
# STEP 4: CREATE HEATMAP (CLUSTERED)
# ============================================

pheatmap(
  ani,
  color = viridisLite::viridis(100),
  clustering_method = "euclidean",
  fontsize_row = 6,
  fontsize_col = 6,
  border_color = NA
)

p1 <- pheatmap(
  ani,
  color = cols,
  breaks = seq(15, 100, length.out = 101),
  cluster_rows = TRUE,
  cluster_cols = TRUE,
  clustering_distance_rows = "euclidean",
  clustering_distance_cols = "euclidean",
  clustering_method = "complete",
  display_numbers = FALSE,   # CHANGED
  fontsize_row = 10,
  fontsize_col = 10,
  angle_col = 90,
  cellwidth = 15,
  cellheight = 15,
  border_color = NA,
  legend = TRUE
)
# ============================================
# STEP 5: CREATE HEATMAP (NO CLUSTERING)
# ============================================

p2 <- pheatmap(
  ani,
  color = cols,
  breaks = seq(15, 100, length.out = 101),
  cluster_rows = FALSE,
  cluster_cols = FALSE,
  display_numbers = FALSE,   # CHANGED
  fontsize_row = 10,
  fontsize_col = 10,
  angle_col = 90,
  cellwidth = 15,
  cellheight = 15,
  border_color = NA,
  legend = TRUE,
  width = 14,
  height = 12
)
# ============================================
# STEP 6: PRINT SUMMARY STATISTICS
# ============================================

cat("\n")
cat(strrep("=", 60), "\n")
cat("ANI ANALYSIS SUMMARY\n")
cat(strrep("=", 60), "\n")

# Off-diagonal values (pairwise comparisons)
off_diag <- ani[upper.tri(ani)]

cat("Matrix dimensions:", nrow(ani), "×", ncol(ani), "\n")
cat("Total strains:", length(all_strains), "\n\n")

cat("ANI Statistics (pairwise comparisons):\n")
cat("  Minimum:", sprintf("%.2f%%", min(off_diag, na.rm = TRUE)), "\n")
cat("  Maximum:", sprintf("%.2f%%", max(off_diag, na.rm = TRUE)), "\n")
cat("  Mean:   ", sprintf("%.2f%%", mean(off_diag, na.rm = TRUE)), "\n")
cat("  Median: ", sprintf("%.2f%%", median(off_diag, na.rm = TRUE)), "\n")
cat("  Std Dev:", sprintf("%.2f%%", sd(off_diag, na.rm = TRUE)), "\n\n")

cat("Strain pairs by ANI threshold:\n")
cat("  ANI ≥ 99%:", sum(off_diag >= 99, na.rm = TRUE), "pairs\n")
cat("  ANI ≥ 95%:", sum(off_diag >= 95, na.rm = TRUE), "pairs\n")
cat("  ANI ≥ 90%:", sum(off_diag >= 90, na.rm = TRUE), "pairs\n")
cat("  ANI ≥ 85%:", sum(off_diag >= 85, na.rm = TRUE), "pairs\n")
cat("  ANI ≥ 80%:", sum(off_diag >= 80, na.rm = TRUE), "pairs\n\n")

# List strains
cat("Strains analyzed:\n")
for (i in 1:length(all_strains)) {
  cat(sprintf("%2d. %s\n", i, all_strains[i]))
}

cat(strrep("=", 60), "\n")
cat("✓ Heatmaps saved as:\n")
cat("  - ANI_heatmap_clustered.pdf\n")
cat("  - ANI_heatmap_unclustered.pdf\n")
cat(strrep("=", 60), "\n")

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

t1 <- pheatmap(
  matrix,
  color = viridisLite::viridis(100),
  clustering_method = "average",
  fontsize_row = 6,
  fontsize_col = 6,
  border_color = NA
)

par(mfrow = c(1, 2))
p1
t1
par(mfrow = c(1, 1))
