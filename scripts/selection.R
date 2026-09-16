# Load required libraries
library(ggplot2)
library(ggrepel)
library(extrafont)
library(tidyverse)


# Create the dataset
data <- data.frame(
  Gene = c("matK", "ycf1", "accD", "rpoB", "petN", "psbK", "psbM", "psaJ", 
           "atpB", "psbF", "psbE", "petG", "rps8", "rbcL", "rps2", "rpl32", 
           "psbI", "psbT", "psbH", "psaC", "ndhJ", "psbJ", "psaI", "pbf1", 
           "psbL", "ndhE", "psbZ", "rpl36", "ndhI", "ndhF", "rps3", "petD", 
           "rpoC2", "rps4", "rps16", "cemA", "rpl33", "atpA", "ndhH", "ccsA", 
           "rps19", "psbB", "rpl16", "psbA", "clpP1", "psbC", "rpoA", "rps18", 
           "rpl20", "ndhG", "rps11", "ndhK", "psaB", "rpl14", "rpl22", "pafII", 
           "petB", "psbD", "psaA", "atpH", "atpE", "petA", "rps15", "ndhC", 
           "rps14", "petL"),
  Kappa = c(3.545, 0.7642, 0.0001, 3.75543, 2.08016, 2.24539, 2.10898, 2.38422, 
            2.31986, 2.46003, 1.85525, 1.72767, 2.23774, 1.05704, 2.00301, 2.35387, 
            1.74437, 2.40122, 1.93275, 6.20869, 2.24661, 1.75426, 1.7083, 1.7135, 
            1.78678, 2.12625, 1.90614, 2.07435, 2.58006, 2.8603, 0.0001, 0.0001, 
            2.1787, 1.66532, 5.90621, 0.0001, 2.25695, 0.79444, 2.15406, 2.6319, 
            7.64777, 2.70119, 2.14372, 1.82779, 1.33205, 0.64552, 0.62753, 0.0001, 
            0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 
            0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 
            0.0001, 0.0001),
  Omega = c(0.89043, 0.88212, 0.65171, 0.61051, 0.44872, 0.44659, 0.4419, 0.43485, 
            0.43284, 0.4289, 0.42725, 0.42548, 0.42442, 0.42197, 0.41719, 0.4171, 
            0.4161, 0.41504, 0.41088, 0.40585, 0.39772, 0.38681, 0.38502, 0.38277, 
            0.38144, 0.37937, 0.37875, 0.37778, 0.37212, 0.35278, 0.33464, 0.33065, 
            0.27858, 0.25006, 0.24971, 0.14922, 0.14751, 0.1265, 0.10881, 0.05662, 
            0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 
            0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 
            0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 0.0001, 
            0.0001, 0.0001)
)


df_fu <- readr::read_csv("data/function.csv") |>
  rename("Gene" = "Genes")
  


merg <- dplyr::full_join(data,
                         df_fu,
                         by = "Gene") |>
  mutate(
    Kappa = ifelse(is.na(Kappa), 0, Kappa),
    Omega = ifelse(is.na(Omega), 0, Omega)
  ) |>
  mutate(
    Category = ifelse(is.na(Category),
                      "No selection / Zero",
                      Category)
  ) |>
  filter(`Gene Function` != "tRNA") |>
  janitor::clean_names()
  
ggplot(merg, aes(x = gene_function, y = omega)) +
  geom_boxplot(fill = "lightblue") +
  geom_hline(yintercept = 1, linetype = "dashed", color = "red") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

ggplot(merg, aes(x = gene_function, y = kappa)) +
  geom_boxplot(fill = "lightblue") +
  geom_hline(yintercept = 1, linetype = "dashed", color = "red") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


# Define categories combining both Kappa and Omega thresholds
data$Category <- ifelse(data$Kappa > 5.5, "High Ts/Tv (κ > 5.5)",
                        ifelse(data$Omega > 1, "Positive selection (ω > 1)",
                               ifelse(data$Omega == 0.0001, "No selection / Zero",
                                      ifelse(data$Omega >= 0.5, "Relaxed purifying selection",
                                             "Purifying selection"))))

# Convert to factor with desired legend order
data$Category <- factor(data$Category, levels = c(
  "High Ts/Tv (κ > 5.5)",
  "Positive selection (ω > 1)",
  "Relaxed purifying selection",
  "Purifying selection",
  "No selection / Zero"
))

# Plot
ggplot(data, aes(x = Kappa, y = Omega, color = Category)) +
  geom_point(aes(size = ifelse(data$Kappa > 5.5, 4.5, 3)), alpha = 0.85) +
  scale_size_identity() +
  geom_hline(yintercept = 1, linetype = "dotted", color = "red", linewidth = 0.1) +
  geom_hline(yintercept = 0.5, linetype = "dotted", color = "gray40", linewidth = 0.1) +
  geom_text_repel(
    aes(label = Gene),
    size = 4,
    max.overlaps = 50,
    box.padding = 0.4,
    point.padding = 0.3,
    segment.color = "grey60",
    segment.size = 0.3,
    fontface = "italic"
  ) +
  scale_color_manual(values = c(
    "High Ts/Tv (κ > 5.5)"        = "#9B2226",
    "Positive selection (ω > 1)"   = "#E63946",
    "Relaxed purifying selection"  = "#C40CBB",
    "Purifying selection"          = "black",
    "No selection / Zero"          = "blue"
  )) +
  labs(
    x = expression(bold("Transition/Transversion ratio (") * 
                     bolditalic(kappa) * bold(")")),
    y = expression(bold("Non-synonymous/Synonymous substitution ratio (") * 
                     bolditalic(omega) * bold(")")),
    color = "Category"
  ) +
  guides(color = guide_legend(override.aes = list(size = 4))) +
  theme_classic(base_size = 12) +
  theme(
    legend.position = "bottom",
    legend.title = element_text(face = "bold"),
    legend.text = element_text(size = 12),
    panel.grid.minor = element_blank(),
    axis.title = element_text(size = 12, face = "bold")
  )

# Save the plot
ggsave("kappa_omega_scatterplot.png", width = 12, height = 8, dpi = 300)