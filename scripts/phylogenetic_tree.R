#===========================================================
# Comparing two phylogenetic trees
#===========================================================

library(ape)
library(phytools)
library(stringr)


ml_46 <- read.tree("data/ml_46.txt")
bi_46 <- read.tree("data/bi_46.txt")


# Plot side by side

par(mfrow = c(1, 2),
    mar = c(2, 2, 4, 2))

plotTree(ml_46,
         direction = "rightwards",
         ftype = "i",
         lwd = 1,
         fsize = 0.7)

title("a")

plotTree(bi_46,
         direction = "leftwards",
         ftype = "i",
         lwd = 1,
         fsize = 0.7)

title("b")


pdf("ML_BI_tree.pdf",
    width = 14,
    height = 12)

# Plot side by side
par(mfrow = c(1, 2),
    mar = c(2, 2, 4, 2))

plotTree(ml_46,
         direction = "rightwards",
         ftype = "i",
         lwd = 1,
         align.tip.label = TRUE,
         use.edge.length = FALSE,
         fsize = 1)

title("a")

plotTree(bi_46,
         direction = "leftwards",
         ftype = "i",
         lwd = 1,
         align.tip.label = TRUE,
         use.edge.length = FALSE,
         fsize = 1)

title("b")

# Save the PDF
dev.off()


