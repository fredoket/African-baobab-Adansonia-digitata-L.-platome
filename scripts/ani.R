
#library(pheatmap)
library(RColorBrewer)

ani <- matrix(c(
100,99.45,99.40,99.96,99.42,99.49,99.45,99.52,99.44,
99.50,100,99.36,99.50,99.57,99.66,99.62,99.55,99.61,
99.31,99.29,100,99.32,99.29,99.30,99.28,99.39,99.29,
99.96,99.45,99.41,100,99.41,99.49,99.44,99.50,99.44,
99.42,99.57,99.37,99.41,100,99.80,99.77,99.43,99.76,
99.50,99.64,99.37,99.50,99.77,100,99.77,99.59,99.69,
99.45,99.60,99.34,99.43,99.79,99.78,100,99.52,99.79,
99.61,99.62,99.55,99.58,99.53,99.56,99.57,100,99.55,
99.52,99.68,99.36,99.50,99.74,99.76,99.79,99.62,100
), nrow=9, byrow=TRUE)

rownames(ani) <- colnames(ani) <- c(
"A.digitata",
"A.grandidieri",
"A.gregorii",
"A.kilima",
"A.madagascariensis",
"A.perrieri",
"A.rubrostipa",
"A.suarezensis",
"A.za"
)

# color scale
#cols <- colorRampPalette(rev(brewer.pal(9, "RdYlBu")))(100)

#p34 <- pheatmap(
#  ani,
#  color = cols,
#  cluster_rows = TRUE,
#  cluster_cols = TRUE,
####  border_color = NA
#)

