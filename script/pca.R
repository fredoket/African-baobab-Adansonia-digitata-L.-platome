
# ------------------------------------------------------------
# 1. Load packages
# ------------------------------------------------------------

library(tidyverse)
library(ggrepel)
library(ggplot2)
library(factoextra)

# ------------------------------------------------------------
# 2. Enter the plastome dataset
# ------------------------------------------------------------

plastome <- data.frame(
  
  Species = c(
    "A. grandidieri",
    "A. madagascariensis",
    "A. perrieri",
    "A. rubrostipa",
    "A. gregorii",
    "A. suarezensis",
    "A. za",
    "A. kilima",
    "A. digitata"
  ),
  
  # Structural attributes
  LSC_bp = c(
    88983, 89153, 89024, 89263, 88836,
    89515, 89329, 88972, 88961
  ),
  
  SSC_bp = c(
    20003, 20013, 19626, 20003, 19983,
    20026, 20024, 19994, 19994
  ),
  
  IR_bp = c(
    51108, 51064, 51060, 51056, 51072,
    51080, 51096, 51106, 51106
  ),
  
  Protein_coding_bp = c(
    85116, 85028, 84792, 84792, 84994,
    84789, 84792, 84624, 84624
  ),
  
  Intron_bp = c(
    30985, 30937, 30948, 30959, 29442,
    31001, 30964, 31012, 31012
  ),
  
  # GC attributes
  Total_GC = c(
    36.86, 36.84, 36.90, 36.83, 36.88,
    36.78, 36.79, 36.88, 36.88
  ),
  
  LSC_GC = c(
    34.66, 34.60, 34.66, 34.59, 34.68,
    34.52, 34.54, 34.68, 34.68
  ),
  
  SSC_GC = c(
    31.20, 31.17, 31.31, 31.19, 31.18,
    31.12, 31.17, 31.21, 31.17
  ),
  
  IR_GC = c(
    42.92, 42.96, 42.97, 42.95, 42.95,
    42.95, 42.92, 42.92, 42.92
  ),
  
  Protein_GC = c(
    38.22, 38.24, 38.26, 38.27, 38.22,
    38.24, 38.25, 38.24, 38.25
  ),
  
  Intron_GC = c(
    39.99, 40.03, 40.03, 40.02, 40.33,
    39.98, 39.99, 39.98, 39.98
  )
)

# Check dataset
print(plastome)

# ------------------------------------------------------------
# 3. Select variables for PCA
# ------------------------------------------------------------

pca_data <- plastome %>%
  select(
    LSC_bp,
    SSC_bp,
    IR_bp,
    Protein_coding_bp,
    Intron_bp,
    Total_GC,
    LSC_GC,
    SSC_GC,
    IR_GC,
    Protein_GC,
    Intron_GC
  )

# ------------------------------------------------------------
# 4. Standardise variables and perform PCA
# ------------------------------------------------------------

pca <- prcomp(
  pca_data,
  center = TRUE,
  scale. = TRUE
)

# ------------------------------------------------------------
# 5. PCA summary
# ------------------------------------------------------------

summary(pca)

# Percentage of variance explained
variance <- pca$sdev^2 / sum(pca$sdev^2) * 100

variance_table <- data.frame(
  PC = paste0("PC", seq_along(variance)),
  Variance = variance
)

print(variance_table)

# ------------------------------------------------------------
# 6. Species scores
# ------------------------------------------------------------

species_scores <- as.data.frame(pca$x)

species_scores$Species <- plastome$Species

print(species_scores)

# ------------------------------------------------------------
# 7. Variable loadings
# ------------------------------------------------------------

loadings <- as.data.frame(pca$rotation)

loadings$Variable <- rownames(loadings)

print(loadings)

# ------------------------------------------------------------
# Combined PCA biplot: variable contributions + species scores
# ------------------------------------------------------------
