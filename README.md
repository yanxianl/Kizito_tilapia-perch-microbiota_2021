## Title here
### doi here

Abstract here 

### File organization

```
root
├── code
│   ├── 00_setup.ipynb
│   ├── 01_qiime2_part1.html
│   ├── 01_qiime2_part1.ipynb
│   ├── 02_feature_filtering.html
│   ├── 02_feature_filtering.Rmd
│   ├── 03_qiime2_part2.html
│   ├── 03_qiime2_part2.ipynb
│   ├── 04_qiime2R.html
│   ├── 04_qiime2R.Rmd
│   ├── 05_taxonomy_tilapia.html
│   ├── 05_taxonomy_tilapia.Rmd
│   ├── 06_alpha_diversity_tilapia.html
│   ├── 06_alpha_diversity_tilapia.Rmd
│   ├── 07_beta_diversity_tilapia.html
│   ├── 07_beta_diversity_tilapia.Rmd
│   ├── 08_differential_analysis_tilapia.html
│   ├── 08_differential_analysis_tilapia.Rmd
│   ├── 09_taxonomy_perch.html
│   ├── 09_taxonomy_perch.Rmd
│   ├── 10_alpha_diversity_perch.html
│   ├── 10_alpha_diversity_perch.Rmd
│   ├── 11_beta_diversity_perch.html
│   ├── 11_beta_diversity_perch.Rmd
│   ├── 12_differential_analysis_perch.html
│   ├── 12_differential_analysis_perch.Rmd
│   ├── functions
│   │   ├── plot_betadisper.R
│   │   ├── plot_frequency.R
│   │   ├── plot_heatmap.R
│   │   └── plot_prevalence.R
│   └── README.md
├── data
│   ├── raw
│   │   ├── fastq
│   │   ├── qPCR
│   │   └── README.md
│   ├── reference
│   │   ├── silva_132_99_16S.fna
│   │   ├── silva_132_consensus_taxonomy_l7.txt 
│   │   ├── sepp-refs-silva-128.qza 
│   │   └── README.md
│   ├── intermediate
│   │   ├── filtering
│   │   ├── qiime2 
│   │   ├── qiime2R 
│   │   ├── permanova
│   │   └── maaslin2
│   └── metadata.tsv
├── result
│    ├── figure
│    │   ├── perch
│    │   └── tilapia
│    └── table
│        ├── perch
│        └── tilapia
├── Kizito_tilapia-perch-microbiota_2021.Rproj
├── LICENSE.md
└── README.md
```

### How to regenerate this repository

#### Dependencies and locations

* [Miniconda3](https://docs.conda.io/en/latest/miniconda.html) should be located in your HOME directory.
* [QIIME2 (2021.4)](https://docs.qiime2.org/2021.4/) should be installed within a Miniconda3 environment and named as `qiime2-2021.4`.
  * QIIME2 library: [DEICODE (0.2.3)](https://library.qiime2.org/plugins/deicode/19/) should be installed within the qiime2 conda environment.
  * [grabseqs (0.7.0)](https://github.com/louiejtaylor/grabseqs) should be installed within the qiime2 conda environment.
* [Pandoc (2.5)](https://pandoc.org/index.html) should be located in your PATH.
* [R (4.0.5)](https://www.r-project.org/) should be located in your PATH.
* R packages and versions: see session information at the end of each rmarkdown report. 
  
#### Running the analysis

All the code should be run from the project's root directory.

**1**.Clone or download this github repository to your local computer.
```bash
# clone the github repository
git clone https://github.com/yanxianl/Kizito_tilapia-perch-microbiota_2021.git

# delete the following folders
rm -rf \
  data/intermediate/qiime2/compare_runs/ \
  data/intermediate/qiime2/core_metrics_results*/ \
  data/intermediate/qiime2/rpca*/ 
```
**2**.Download raw sequence data, SILVA132 reference database and SILVA128 SEPP reference phylogeny (`code/00_setup.ipynb`).
```bash
# activate qiime2 environment
source $HOME/miniconda3/bin/activate
conda activate qiime2-2021.4

# launch jupyter notebook and run code/00_setup.ipynb interactively
jupyter notebook

# exit jupyter notebook after running the code by pressing Ctrl + c in the terminal
```
**3**.Sequence denoising (DADA2) and taxonomic assignment.
```bash
jupyter nbconvert --execute --to html code/01_qiime2_part1.ipynb
```
**4**.Filter the feature tables to remove: 1).chloroplast/mitochondria sequences and those without a phylum-level taxonomic assignment;
2).low-prevalence features that only present in one sample; 3).contaminating features.
```bash
Rscript -e "rmarkdown::render('code/02_feature_filtering.Rmd')"
```
**5**.Phylogeny and core-metrics-results.
```bash
jupyter nbconvert --execute --to html code/03_qiime2_part2.ipynb
```
**6**.Import qiime2 artifacts into R.
```bash
Rscript -e "rmarkdown::render('code/04_qiime2R.Rmd')"
```
**7**.Downstream data analysis to generate main results presented in the tilapia paper.
```bash
# taxonomic analysis
Rscript -e "rmarkdown::render('code/05_taxonomy_tilapia.Rmd')" &&
Rscript -e "rmarkdown::render('code/06_alpha_diversity_tilapia.Rmd')" &&
Rscript -e "rmarkdown::render('code/07_beta_diversity_tilapia.Rmd')" &&
Rscript -e "rmarkdown::render('code/08_differential_analysis_tilapia.Rmd')"
```
**8**.Downstream data analysis to generate main results presented in the perch paper.
```bash
# taxonomic analysis
Rscript -e "rmarkdown::render('code/09_taxonomy_perch.Rmd')" &&
Rscript -e "rmarkdown::render('code/10_alpha_diversity_perch.Rmd')" &&
Rscript -e "rmarkdown::render('code/11_beta_diversity_perch.Rmd')" &&
Rscript -e "rmarkdown::render('code/12_differential_analysis_perch.Rmd')"
```

### To-do 
* Add a driver script to automate all the analysis, e.g., `make`.
