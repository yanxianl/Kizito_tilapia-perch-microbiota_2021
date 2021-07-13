## Title here
### doi here

Abstract 

### Overview

Here's an overview of the file organization in this project.
```

```

### How to regenerate this repository

#### Dependencies and locations

* [Miniconda3](https://docs.conda.io/en/latest/miniconda.html) should be located in your HOME directory.
* [QIIME2 (2020.11)](https://docs.qiime2.org/2020.11/) should be installed within a Miniconda3 environment named as `qiime2-2020.11`.
  * QIIME2 library: [DEICODE (0.2.3)](https://library.qiime2.org/plugins/deicode/19/) should be installed within the qiime2 conda environment.
  * [grabseqs (0.7.0)](https://github.com/louiejtaylor/grabseqs) should be installed within the qiime2 conda environment.
* [Pandoc (2.5)](https://pandoc.org/index.html) should be located in your PATH.
* [R](https://www.r-project.org/) (4.0.5) should be located in your PATH.
* R packages (packageName_version[source]): 
  * afex_0.28-1 [CRAN]
  * ape_5.5 [CRAN]
  * biomformat_1.18.0 [Bioconductor 3.12]
  * Biostrings_2.58.0 [Bioconductor 3.12]
  * circlize_0.4.12 [CRAN]
  * ComplexHeatmap_2.6.0 [Bioconductor 3.12]
  * cowplot_1.1.1 [CRAN]
  * dada2_1.18.0 [Bioconductor 3.12]
  * DECIPHER_2.18.1 [Bioconductor 3.12]
  * decontam_1.10.0 [Bioconductor 3.12]
  * DT_0.18 [CRAN]
  * emmeans_1.6.0 [CRAN]
  * flextable_0.6.5 [CRAN]
  * ggh4x_0.1.2.1 [CRAN]
  * ggpubr_0.4.0 [CRAN]
  * ggResidpanel_0.3.0 [CRAN]
  * ggsignif_0.6.1 [CRAN] 
  * ggstatsplot_0.7.2 [CRAN]
  * ggtext_0.1.1 [CRAN]
  * gt_0.2.2 [CRAN]
  * here_1.0.1 [CRAN]
  * Hmisc_4.5-0 [CRAN]
  * knitr_1.33 [CRAN]
  * Maaslin2_1.4.0 [Bioconductor 3.12]
  * magick_2.7.1 [CRAN]
  * MicrobeR_0.3.2 [github::jbisanz/MicrobeR@9f4e593]
  * microbiome_1.12.0 [Bioconductor 3.12] 
  * mixOmics_6.14.0 [Bioconductor 3.12]
  * officer_0.3.18 [CRAN]
  * patchwork_1.1.1 [CRAN]
  * PerformanceAnalytics_2.0.4 [CRAN]
  * phangorn_2.6.3 [Bioconductor 3.12]
  * philr_1.16.0 [Bioconductor 3.12]
  * phyloseq_1.34.0 [Bioconductor 3.12] 
  * plotly_4.9.3 [CRAN]
  * plyr_1.8.6 [CRAN]
  * qiime2R_0.99.35 [github::jbisanz/qiime2R@077b08b]
  * RColorBrewer_1.1-2 [CRAN]
  * RUVSeq_1.24.0  [Bioconductor 3.12] 
  * rlang_0.4.11 [CRAN] 
  * rmarkdown_2.7 [CRAN] 
  * scales_1.1.1 [CRAN]
  * speedyseq [github::mikemc/speedyseq@8daed32]
  * sva_3.38.0 [Bioconductor 3.12]
  * tidyverse_1.3.1 [CRAN]
  * usedist_0.4.0 [CRAN]
  * vegan_2.5-7 [CRAN]
  * webshot2_0.0.0.9000 [github::rstudio/webshot2@83aad5d]
  
#### Running the analysis

All the code should be run from the project's root directory.

1.Download or clone this github repository to your local computer.
```bash
# clone the github repository
git clone https://github.com/yanxianl/Li_AqFl1-Microbiota_2021.git

# delete the following folders which produce errors when computing beta-diversity metrics
rm -rf \ 
data/intermediate/qiime2/core-metrics-results/ \ 
data/intermediate/qiime2/robust-Aitchison-pca/ \
```
2.Download raw sequence data, SILVA132 reference database and SILVA128 SEPP reference phylogeny (`code/00_setup.ipynb`).
```bash
# activate qiime2 environment
source $HOME/miniconda3/bin/activate
conda activate qiime2-2020.11

# launch jupyter notebook to run code/00_setup.ipynb interactively
jupyter notebook

# shutdown jupyter notebook after running the code by pressing Ctrl + c in the terminal
```
3.Sequence denoising by dada2.
```bash
Rscript -e "rmarkdown::render('code/01_dada2_run1.Rmd')" && Rscript -e "rmarkdown::render('code/01_dada2_run2.Rmd')"
```
4.Taxonomic assignment.
```bash
jupyter nbconvert --execute --to html code/02_qiime2_part1.ipynb
```
5.Filter the feature table to remove: 1).chloroplast/mitochondria sequences and those without a phylum-level taxonomic assignment;
2).low-prevalence features that only present in one sample; 3).contaminating features.
```bash
Rscript -e "rmarkdown::render('code/03_filtering.Rmd')"
```
6.Phylogeny and core-metrics-results.
```bash
jupyter nbconvert --execute --to html code/04_qiime2_part2.ipynb
```
7.Batch effect adjustment.
```bash
Rscript -e "rmarkdown::render('code/05_batch_correction.Rmd')"
```
8.Split core-metrics-results based on the sequencing runs.
```bash
jupyter nbconvert --execute --to html code/06_qiime2_part3.ipynb
```
9.Import qiime2 artifacts into R.
```bash
Rscript -e "rmarkdown::render('code/07_qiime2R.Rmd')"
```
10.Taxonomic analysis.
```bash
Rscript -e "rmarkdown::render('code/08_taxonomy.Rmd')"
```
11.Alpha-diversity analysis.
```bash
Rscript -e "rmarkdown::render('code/09_alpha_diversity.Rmd')"
```
12.Beta-diversity analysis.
```bash
Rscript -e "rmarkdown::render('code/10_beta_diversity.Rmd')"
```
13.Association testing between microbial clades and sample metadata.
```bash
Rscript -e "rmarkdown::render('code/11_multivariable_association.Rmd')"
```

### To-do

* Add a driver script to automate all the analysis, e.g., `make`.

### Acknowledgements


