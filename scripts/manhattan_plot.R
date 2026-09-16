# ==========================================================
  # Manhattan Plots for PAML Codon Models
  # ==========================================================
# This script creates Manhattan plots for:
# - Likelihood values (lnL_M0, lnL_M1a, lnL_M2a, lnL_M7, lnL_M8)
# - LRT statistics (LRT_M1a_M2a, LRT_M7_M8)
# - P-values (p_M1a_M2a, p_M7_M8)
# ==========================================================

library(ggplot2)
library(dplyr)
library(gridExtra)
library(tidyverse)
library(ggrepel)
library(patchwork)
library(pheatmap)
library(RColorBrewer)

# ----------------------------------------------------------
# LOAD DATA
# ----------------------------------------------------------
data <- readr::read_csv("data/all_models_merged.csv")


# Extract lnL by model
lnL_wide <- data %>%
  select(gene, model, lnL) %>%
  filter(model %in% c("M0","M1a","M2a","M7","M8")) %>%
  pivot_wider(names_from = model, values_from = lnL, names_prefix = "lnL_")

lrt <- lnL_wide %>%
  mutate(
    # M1a vs M2a: df = 2
    LRT_M1a_M2a = 2 * (lnL_M2a - lnL_M1a),
    p_M1a_M2a   = pchisq(LRT_M1a_M2a, df = 2, lower.tail = FALSE),
    sig_M1a_M2a = p_M1a_M2a < 0.05,
    # M7 vs M8: df = 2
    LRT_M7_M8   = 2 * (lnL_M8 - lnL_M7),
    p_M7_M8     = pchisq(LRT_M7_M8, df = 2, lower.tail = FALSE),
    sig_M7_M8   = p_M7_M8 < 0.05,
    # Both significant = strong evidence
    pos_sel_both = sig_M1a_M2a & sig_M7_M8
  ) |>
  pivot_longer(
    cols = c(lnL_M0, lnL_M1a, lnL_M2a, lnL_M7, lnL_M8),
    names_to = "model",
    values_to = "lnL"
  ) %>%
  pivot_longer(
    cols = c(LRT_M1a_M2a, LRT_M7_M8, p_M7_M8),
    names_to = "stat_test",
    values_to = "stat_value"
  ) |>
  mutate(
    model_test = case_when(
      model == "lnL_M0"  ~ "M0",
      model == "lnL_M1a" ~ "M1a",
      model == "lnL_M2a" ~ "M2a",
      model == "lnL_M7"  ~ "M7",
      model == "lnL_M8"  ~ "M8",
      TRUE ~ model   # keeps LRT and p-value rows unchanged
    )
  ) |>
  select(model_test, everything())


df2 <- lrt %>%
  filter(stat_test %in% c("p_M1a_M2a", "p_M7_M8")) %>%
  rename(p_value = stat_value)%>%
  mutate(gene_id = as.numeric(as.factor(gene))) %>%
  mutate(logP = -log10(p_value)) |>
  mutate(
    sig_group = case_when(
      logP > 1 ~ gene,        # each significant gene gets its own label
      TRUE ~ "Non-significant"
    )
  )

sig_genes <- unique(df2$ model_test[df2$logP > 1])

cols <- c("brown", setNames(rainbow(length(sig_genes)), sig_genes))

library(ggrepel)

ggplot(df2, aes(x = gene_id, y = logP, color = sig_genes)) +
  geom_point(size = 2, alpha = 0.8) +
  geom_hline(yintercept = 1, linetype = "dashed") +
  
  
  facet_wrap(~ model_test, scales = "free_x", strip.position = "bottom", nrow = 1) +
  scale_color_manual(values = cols) +
  
  theme_classic() +
  theme(
    legend.position = "none",   # 🚨 removes legend
    strip.placement = "bottom",
    strip.background = element_blank(),
    strip.text = element_text(size = 11, face = "bold")
  )+
  xlab("Substitution models")

