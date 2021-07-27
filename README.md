## Title here
### doi here

Abstract here 

### File organization

File organization in this project.
```

```

### How to regenerate this repository

#### Dependencies and locations

* [Miniconda3](https://docs.conda.io/en/latest/miniconda.html) should be located in your HOME directory.
* [QIIME2 (2021.4)](https://docs.qiime2.org/2020.11/) should be installed within a Miniconda3 environment named as `qiime2-2020.11`.
  * QIIME2 library: [DEICODE (0.2.3)](https://library.qiime2.org/plugins/deicode/19/) should be installed within the qiime2 conda environment.
  * [grabseqs (0.7.0)](https://github.com/louiejtaylor/grabseqs) should be installed within the qiime2 conda environment.
* [Pandoc (2.5)](https://pandoc.org/index.html) should be located in your PATH.
* [R](https://www.r-project.org/) (4.0.5) should be located in your PATH.
* R packages and versions: see session information at the end of each rendered rmarkdown report. 
  
#### Running the analysis

All the code should be run from the project's root directory.

1.Clone this github repository to your local computer.
```bash
# clone the github repository
git clone https://github.com/yanxianl/Li_AqFl1-Microbiota_2021.git

# delete the following folders; qiime2 throws an error if these folders exist in your destiny file location
rm -rf \ 
data/intermediate/qiime2/compare_runs \
data/intermediate/qiime2/core_metrics_results_run1/ \ 
data/intermediate/qiime2/core_metrics_results_run2/ \
data/intermediate/qiime2/core_metrics_results_tilapia \
data/intermediate/qiime2/rpca_tilapia \
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
3.Sequence denoising (DADA2) and taxonomic assignment.
```bash
jupyter nbconvert --execute --to html code/01_qiime2_part1.ipynb
```
4.Filter the feature table to remove: 1).chloroplast/mitochondria sequences and those without a phylum-level taxonomic assignment;
2).low-prevalence features that only present in one sample; 3).contaminating features.
```bash
Rscript -e "rmarkdown::render('code/02_feature_filtering.Rmd')"
```
5.Phylogeny and core-metrics-results.
```bash
jupyter nbconvert --execute --to html code/03_qiime2_part2.ipynb
```
6.Import qiime2 artifacts into R.
```bash
Rscript -e "rmarkdown::render('code/04_qiime2R.Rmd')"
```
7.Taxonomic analysis.
```bash
Rscript -e "rmarkdown::render('code/05_taxonomy.Rmd')"
```
8.Alpha-diversity analysis.
```bash
Rscript -e "rmarkdown::render('code/06_alpha_diversity.Rmd')"
```
9.Beta-diversity analysis.
```bash
Rscript -e "rmarkdown::render('code/07_beta_diversity.Rmd')"
```
10.Differential abundance testing.
```bash
Rscript -e "rmarkdown::render('code/08_differential_analysis.Rmd')"
```

### To-do

* Add a driver script to automate all the analysis, e.g., `make`.



