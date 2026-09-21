# Comprehensive Characterisation of the *Adansonia digitata* Plastome

Data, R scripts, and R Markdown workflow for the comprehensive characterisation of the chloroplast genome (plastome) of the African baobab, *Adansonia digitata* L.

The study examines plastome structure, gene content, sequence variation, codon usage, RNA editing, repetitive sequences, comparative plastome features, and molecular evolution within *Adansonia*, placing *A. digitata* in a broader Malvaceae phylogenetic context.

## Table of contents

- [Project overview](#project-overview)
- [Main analyses](#main-analyses)
- [Repository structure](#repository-structure)
- [Workflow](#workflow)
- [Requirements](#requirements)
- [Reproducibility](#reproducibility)
- [Data availability](#data-availability)
- [Citation](#citation)
- [Acknowledgments](#acknowledgments)
- [Author & contact](#author--contact)
- [License](#license)

## Project overview

The *A. digitata* plastome was assembled and annotated from Illumina sequencing data and deposited in GenBank under accession **[PZ369780](https://www.ncbi.nlm.nih.gov/nuccore/PZ369780)**. The resulting circular plastome was characterised for its quadripartite structure, gene content, nucleotide composition, intron organisation, and other structural features.

Comparative analyses were conducted across nine *Adansonia* taxa:

- *Adansonia digitata*
- *Adansonia grandidieri*
- *Adansonia gregorii*
- *Adansonia kilima*
- *Adansonia madagascariensis*
- *Adansonia perrieri*
- *Adansonia rubrostipa*
- *Adansonia suarezensis*
- *Adansonia za*

## Main analyses

**Plastome assembly and annotation** — plastome size and quadripartite structure; LSC, SSC, and IR regions; gene content and organisation; start codons; intron-containing genes; GC composition; IR boundary structure.

**Comparative *Adansonia* plastome analysis** — genome size and GC content variation; gene organisation; IR boundaries; *ycf1* and *ndhF* boundary variation; sequence similarity and structural conservation across the genus.

**Phylogenetic analysis** — maximum likelihood and Bayesian inference using plastid sequences from *Adansonia* and a broader Malvaceae dataset, including tree visualisation and comparative phylogenetics.

**Codon usage** — relative synonymous codon usage (RSCU) across protein-coding genes, including distribution of preferred codons by nucleotide composition.

**RNA editing** — predicted editing sites across protein-coding genes, including counts, gene-level distribution, and C→U and other nucleotide changes.

**Simple sequence repeats (SSRs)** — identified and classified by genomic location (genes, introns, intergenic spacers).

**Long sequence repeats** — assessed outside the inverted repeat region to avoid inflating repeat counts from IR duplication.

**Molecular evolution** — codon-based selection analysis using models M0, M1a, M2a, M7, and M8 to examine variation in selective constraint among protein-coding genes.

**Sequence comparison** — pairwise BLAST-based comparisons and average nucleotide identity (ANI) among selected *Adansonia* plastomes.

## Repository structure

```text
African-baobab-Adansonia-digitata-L.-platome/
│
├── A_digitata_CP_genome.Rmd      # Main analysis workflow
├── .gitignore
│
├── data/                         # Codon usage, RNA editing, molecular
│                                  # evolution, phylogenetic, and
│                                  # plastome comparison data
│
├── data_1/                       # Adansonia GenBank files,
│                                  # phylogenetic tree, BLAST results
│
├── data_2/                       # Pairwise BLAST comparison files
│
└── script/
    ├── ani.R
    ├── pca.R
    └── rscu_script.R
```

## Workflow

The primary analytical workflow is implemented in `A_digitata_CP_genome.Rmd`, covering data processing, comparative analysis, statistics, and visualisation. Standalone scripts for selected analyses are in `script/`.

## Requirements

- R (≥ 4.0)
- RStudio (recommended)
- R packages: `tidyverse`, `ggplot2`, `ggrepel`, `patchwork`, `ggbreak`, `ggdendro`, `factoextra`, `ggplotify`, `gridExtra`, `genoPlotR`, `ape`, `ade4`, `pheatmap`, `RColorBrewer`, `phytools`, `ggbeeswarm`, `viridis`

Install packages with:

```r
install.packages(c("tidyverse", "ggplot2", "ggrepel", "patchwork", "ggbreak",
                    "ggdendro", "factoextra", "ggplotify", "gridExtra",
                    "ape", "ade4", "pheatmap", "RColorBrewer",
                    "phytools", "ggbeeswarm", "viridis"))

# genoPlotR may require Bioconductor:
# if (!require("BiocManager")) install.packages("BiocManager")
# BiocManager::install("genoPlotR")
```

## Reproducibility

1. Clone this repository.
2. Open `A_digitata_CP_genome.Rmd` in RStudio.
3. Install required packages (see above) if not already available.
4. Set the repository directory as the working directory.
5. Run the R Markdown workflow.

## Data availability

The *A. digitata* plastome sequence is available through GenBank under accession **PZ369780**. This repository provides the intermediate data files and scripts needed to reproduce the analyses, subject to availability of the original sequence data and external reference datasets.

## Citation

If you use the data, scripts, or results from this repository, please cite:

```bibtex
@article{onyango_baobab_plastome,
  author  = {Onyango, Oketch Fredrick and others},
  title   = {Comprehensive characterisation of the African baobab
             ({Adansonia digitata} L.) plastome reveals conserved
             structural features and heterogeneous patterns of
             molecular evolution},
  note    = {Manuscript in preparation; citation to be updated upon publication}
}
```

## Acknowledgments

This work was conducted as part of the Baobab GCRF Genome Project. Thanks to collaborators and institutions who supported field sampling, sequencing, and analysis.

## Author & contact

**Oketch Fredrick Onyango**
Molecular Biology and Environmental Genomics · Kenya

- Email: [fredoket@gmail.com](mailto:fredoket@gmail.com)
- GitHub: [@fredoket](https://github.com/fredoket)

Questions or issues — please [open a GitHub issue](https://github.com/fredoket/African-baobab-Adansonia-digitata-L.-platome/issues) or reach out by email.

## License

This project is licensed under the MIT License — see the `LICENSE` file for details. *(Replace with your actual license choice if different.)*
