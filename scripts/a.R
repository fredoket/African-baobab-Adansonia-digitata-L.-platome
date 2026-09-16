library(patchwork)

clean_theme <- theme(
  plot.margin = margin(0, 0, 0, 0),
  axis.title = element_text(size = 12, color = "black"),
  axis.text  = element_text(size = 12, color = "black")
)

# Apply clean theme and remove legend for p19
p19 <- p19 + clean_theme + theme(legend.position = "none")
p21 <- p21 + clean_theme
p22 <- p22 + clean_theme
# p20 removed

# Layout
top_row    <- p19 + p22 + plot_layout(widths = c(7, 3))
bottom_row <- p21  # p20 removed

panel <- top_row / bottom_row +
  plot_layout(heights = c(1, 1)) +
  plot_annotation(tag_levels = "a")

panel
