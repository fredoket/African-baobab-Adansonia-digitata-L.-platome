# Comprehensive Characterisation of the *Adansonia digitata* Plastome

This repository contains the data, R scripts and R Markdown workflow used for the comprehensive characterisation of the chloroplast genome (plastome) of the African baobab, *Adansonia digitata* L.

The study examines plastome structure, gene content, sequence variation, codon usage, RNA editing, repetitive sequences, comparative plastome features and molecular evolution within *Adansonia*. Comparative analyses also place *A. digitata* in a broader Malvaceae phylogenetic context.

## Project overview

The plastome of *A. digitata* was assembled and annotated from Illumina sequencing data. The resulting circular plastome was characterised with respect to its quadripartite structure, gene content, nucleotide composition, intron organisation and other structural features.

Comparative analyses were conducted using plastomes representing nine *Adansonia* taxa:

* *Adansonia digitata*
* *Adansonia grandidieri*
* *Adansonia gregorii*
* *Adansonia kilima*
* *Adansonia madagascariensis*
* *Adansonia perrieri*
* *Adansonia rubrostipa*
* *Adansonia suarezensis*
* *Adansonia za*

The analyses include plastome-wide comparisons, sequence similarity, phylogenetic reconstruction, codon usage, RNA editing, simple sequence repeats, long sequence repeats and analyses of molecular evolution.

## Main analyses

### Plastome assembly and annotation

The *A. digitata* plastome was assembled from Illumina paired-end reads and characterised based on:

* Plastome size and quadripartite structure
* Large single-copy (LSC) region
* Small single-copy (SSC) region
* Inverted repeat (IR) regions
* Gene content and organisation
* Gene start codons
* Intron-containing genes
* GC composition
* IR boundary structure

The assembled plastome is deposited in GenBank under accession **PZ369780**.

### Comparative *Adansonia* plastome analysis

Nine *Adansonia* plastomes were compared to assess:

* Genome size variation
* GC content
* Gene organisation
* Inverted repeat boundaries
* *ycf1* and *ndhF* boundary variation
* Gene and intergenic region organisation
* Sequence similarity among taxa
* Structural conservation across the genus

### Phylogenetic analysis

Phylogenetic relationships were reconstructed using plastid sequences from *Adansonia* and a broader Malvaceae dataset.

The repository contains files associated with:

* Maximum likelihood analysis
* Bayesian inference
* Phylogenetic trees
* Tree visualisation
* Comparative phylogenetic analysis

### Codon usage

Codon usage was examined using relative synonymous codon usage (RSCU) values. The analysis evaluates synonymous codon preferences across protein-coding genes and examines the distribution of preferred codons according to their nucleotide composition.

### RNA editing

Putative RNA editing sites were characterised across protein-coding genes. The analysis evaluates:

* Number of predicted editing sites
* Distribution among protein-coding genes
* C→U and other nucleotide changes
* Gene-level distribution of editing sites

### Simple sequence repeats

Plastome simple sequence repeats (SSRs) were identified and classified according to their genomic location, with loci assigned to:

* Genes
* Introns
* Intergenic spacer regions

### Long sequence repeats

Long sequence repeats were assessed outside the inverted repeat region to examine repetitive sequence organisation while avoiding inflation of repeat counts caused by the duplicated IR regions.

### Molecular evolution

Patterns of molecular evolution were examined using codon-based analyses. The repository contains results from multiple codon substitution models, including:

* M0
* M1a
* M2a
* M7
* M8

These analyses were used to investigate variation in selective constraints among protein-coding genes.

### Sequence comparison

Pairwise sequence comparisons were performed among selected *Adansonia* plastomes. BLAST-based comparisons and average nucleotide identity analyses were used to assess sequence similarity and differentiation among taxa.

## Repository structure

```text
African-baobab-Adansonia-digitata-L.-platome/
│
├── A_digitata_CP_genome.Rmd
├── .gitignore
│
├── data/
│   ├── Codon usage data
│   ├── RNA editing data
│   ├── Molecular evolution results
│   ├── Phylogenetic data
│   ├── Plastome comparison data
│   └── Other analysis files
│
├── data_1/
│   ├── Adansonia GenBank files
│   ├── Phylogenetic tree
│   └── BLAST results
│
├── data_2/
│   ├── Pairwise BLAST results
│   └── BLAST comparison files
│
└── script/
    ├── ani.R
    ├── pca.R
    └── rscu_script.R
```

## Workflow

The principal analytical workflow is implemented in the R Markdown document:

```text
A_digitata_CP_genome.Rmd
```

The supporting R scripts are located in:

```text
script/
```

The workflow covers data processing, comparative analysis, statistical analysis and visualisation.

## Software and R packages

The analyses were conducted in R using packages such as:

* `tidyverse`
* `ggplot2`
* `ggrepel`
* `patchwork`
* `ggbreak`
* `ggdendro`
* `factoextra`
* `ggplotify`
* `gridExtra`
* `genoPlotR`
* `ape`
* `ade4`
* `pheatmap`
* `RColorBrewer`
* `phytools`
* `ggbeeswarm`
* `viridis`

The complete package loading workflow is provided in `A_digitata_CP_genome.Rmd`.

## Data availability

The repository contains the analysis data and intermediate files required to reproduce the analyses presented in the associated study, subject to the availability of the original sequence data and external reference datasets.

The *A. digitata* plastome sequence is available through GenBank under accession **PZ369780**.

## Reproducibility

To reproduce the R-based analyses:

1. Clone or download this repository.
2. Open `A_digitata_CP_genome.Rmd` in RStudio.
3. Install the required R packages if they are not already available.
4. Ensure the repository directory is set as the working directory.
5. Run the R Markdown workflow.

The analysis scripts in `script/` provide additional standalone workflows for selected analyses.

## Citation

If you use the data, scripts or results from this repository, please cite the associated publication:

> Oketch Fredrick Onyango et al. Comprehensive characterisation of the African baobab (*Adansonia digitata* L.) plastome reveals conserved structural features and heterogeneous patterns of molecular evolution.

The full citation will be updated following publication.

## Author

**Oketch Fredrick Onyango**

Molecular Biology and Environmental Genomics

Kenya

## Repository

GitHub:
https://github.com/fredoket/African-baobab-Adansonia-digitata-L.-platome.git
