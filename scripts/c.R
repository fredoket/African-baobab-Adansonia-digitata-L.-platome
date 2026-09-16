# Load libraries
library(ggplot2)
library(ggrepel)
library(dplyr)
library(tidyr)
library(patchwork)

# Use ds_dn as your data
# Remove genes with very small omega/kappa values for visualization clarity
ds_dn_vis <- ds_dn #%>% 
  mutate(
    omega = ifelse(omega < 1e-03, NA, omega),
    kappa = ifelse(kappa < 1e-03, NA, kappa)
  )

# -----------------------
# 1. Scatter plot Kappa vs Omega
  scatter_plot <- ggplot(ds_dn_vis, aes(x = kappa, y = omega, label = Gene)) +
    geom_point(color = "black", size = 1.8, na.rm = TRUE) +
    geom_text_repel(
      max.overlaps = 12, 
      size = 5,
      na.rm = TRUE
    ) +
    theme_classic() +
    labs(
      x = expression("Transition/Transversion (" * kappa * ")"),
      y = expression(dN/dS~"(" * omega * ")")
    ) +
    theme(
      axis.text = element_text(size = 13, colour = "black"),
      axis.title.x = element_text(size = 18, face = "bold", colour = "black"),
      axis.title.y = element_text(size = 18, face = "bold", colour = "black")
    )
  
  scatter_plot
  
  
# -----------------------
  bar_omega <- ds_dn_vis |>
    drop_na() |>
    arrange(desc(omega)) |>  # sort descending
    ggplot(aes(x = reorder(Gene, -omega), y = omega, fill = omega > 1)) +  # minus for descending
    geom_bar(stat = "identity", na.rm = TRUE) +
    scale_fill_manual(
      values = c("grey70", "red"), 
      labels = c("Purifying/Neutral", "Positive selection")
    ) +
    theme_classic() +
    labs(
      x = "Gene", 
      y = "Omega (dN/dS)", 
      fill = "Selection", 
      title = "Omega values per gene"
    ) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))  # rotate x labels for readability
  
  
  bar_omega
# -----------------------
# 3. Side-by-side barplot of Kappa and Omega
ds_dn_long <- ds_dn_vis |>
  drop_na() |> 
  pivot_longer(cols = c(kappa, omega), names_to = "Parameter", values_to = "Value")

side_bar <- ggplot(ds_dn_long, aes(x = reorder(Gene, Value), y = Value, fill = Parameter)) +
  geom_bar(stat = "identity", position = "dodge", na.rm = TRUE) +
  coord_flip() +
  scale_fill_manual(values = c("kappa" = "skyblue", "omega" = "salmon")) +
  theme_classic() +
  labs(
    x = "Gene", 
    y = "Value", 
    fill = "Parameter", 
    title = "Comparison of Kappa and Omega"
  )

# -----------------------
# Combine plots using patchwork
panel <- (bar_omega|scatter_plot ) +
  plot_layout(heights = c(1, 1)) +
  plot_annotation(tag_levels = "a")

# Display panel
panel
