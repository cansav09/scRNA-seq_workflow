#!/bin/bash
# C. Savonen
# CCDL for ALSF 2018

# Purpose: running the post-processing steps for single cell RNA-seq data.
# Note that data must be in a gene matrix format for this script to run. 
# Also advised that you filter the gene matrix to a manageable size.

# Change your directory name, and desired label here. Then run the script.
dir=tab_mur_data
label=tab_mur

#-------------------------------Run normalization------------------------------#
Rscript scripts/post-processing/1-run_normalization.R \
  -d ${dir}/counts_${label}.RDS \
  -a all \
  -o ${dir}/normalized_${label} \
  -l ${label}

#------------------------------Dimension reduction-----------------------------#
Rscript scripts/post-processing/2-dim_reduction_analysis.R \
  -d ${dir}/normalized_${label} \
  -m ${dir}/filtered_metadata_${label}.tsv \
  -r pca \
  -l ${label} \
  -o pca_${label} 
  
#------------------------------Clustering analysis-----------------------------#
Rscript scripts/post-processing/3-cluster_analysis.R \
  -d pca_${label} \
  -m ${dir}/filtered_metadata.tsv \
  -l ${label} \
  -o results/pca_results_${dir} 
  