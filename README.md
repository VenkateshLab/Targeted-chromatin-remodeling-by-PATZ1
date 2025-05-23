# **Required Tools and Libraries**

## **1. Tools**

### **Quality Control and Pre-processing**
- **`FastQC`**: For assessing the quality of raw sequencing data
- **`FastP`**: For trimming low-quality sequences and adapter removal

### **Pipeline Automation**
- **`Snakemake`**: For pipeline automation, especially used in `Tobias.sh` for ATAC-seq analysis

### **ATAC-seq Analysis**
- **`TOBIAS`**: A toolkit for analyzing ATAC-seq data and footprinting

### **Hi-C Analysis**
- **`Homer`**: For Hi-C analysis and 3D chromatin structure processing
- **`Bowtie`**: Used for aligning Hi-C data to the `mm10` reference genome

### **Single-cell Analysis**
- **`ArchR`**: Used for analyzing SnATAC-seq data (chromatin accessibility analysis)
- **`Seurat`**: Used for analyzing snRNA-seq data
- **`Cell Ranger`**: For processing snRNA-seq and snATAC-seq data

---

## **2. R Libraries**

**_Ensure the following R libraries are installed to run the R scripts:_**

| Library | Purpose |
|---------|---------|
| **`ArchR`** | For processing and visualizing SnATAC-seq data |
| **`ggplot2`** | For generating plots and visualizations |
| **`dplyr`** | For data manipulation |
| **`Seurat`** | For analyzing single-cell RNA-seq data |
| **`Tidyverse`** | For general data wrangling and visualization |
| **`RColorBrewer`** | For color palettes in plots |

### **Installation Command**
```r
# Install required R packages
install.packages(c("ggplot2", "dplyr", "tidyverse", "RColorBrewer"))

# Install Bioconductor packages
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install(c("ArchR", "Seurat"))
```

---

## **3. Required Reference Genome**

### **`mm10` Reference Genome**
- **Purpose**: The `mm10` (Mouse Genome) reference genome is used for alignment and mapping chromatin accessibility
- **Download Sources**:
  - [**UCSC Genome Browser**](https://genome.ucsc.edu/)
  - [**Ensembl**](https://www.ensembl.org/)

### **Download Instructions**
```bash
# Example download command for mm10 genome
wget http://hgdownload.cse.ucsc.edu/goldenPath/mm10/bigZips/mm10.fa.gz
gunzip mm10.fa.gz
```

---

## **Installation Notes**

> **⚠️ Important**: Make sure all dependencies are properly installed before running the analysis pipeline.

> **💡 Tip**: Consider using a conda environment to manage package versions and avoid conflicts.

### **Setting up Conda Environment**
```bash
# Create a new conda environment
conda create -n chromatin_analysis python=3.8
conda activate chromatin_analysis

# Install required tools
conda install -c bioconda fastqc fastp snakemake bowtie homer
conda install -c conda-forge r-base

# Alternative: Install TOBIAS separately if not available in conda
pip install tobias

# Install Cell Ranger (requires manual download from 10x Genomics)
# Download from: https://support.10xgenomics.com/single-cell-gene-expression/software/downloads/latest
```

### **Additional Tool Installation Commands**

```bash
# Install FastQC
sudo apt-get install fastqc  # Ubuntu/Debian
# or
conda install -c bioconda fastqc

# Install FastP
conda install -c bioconda fastp
# or
git clone https://github.com/OpenGene/fastp.git
cd fastp
make

# Install TOBIAS
pip install tobias
# or
conda install -c bioconda tobias

# Install Homer
wget http://homer.ucsd.edu/homer/configureHomer.pl
perl configureHomer.pl -install
perl configureHomer.pl -install mm10

# Install Bowtie
conda install -c bioconda bowtie
# or
sudo apt-get install bowtie

# Install Snakemake
conda install -c bioconda snakemake
# or
pip install snakemake
```

### **R Environment Setup**
```r
# Check R version (should be >= 4.0.0)
R.version.string

# Install all required packages at once
required_packages <- c(
  "ggplot2", 
  "dplyr", 
  "tidyverse", 
  "RColorBrewer"
)

# Install from CRAN
install.packages(required_packages)

# Install Bioconductor packages
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install(c("ArchR", "Seurat"))

# Verify installations
lapply(c(required_packages, "ArchR", "Seurat"), library, character.only = TRUE)
```

---

## **System Requirements**

### **Minimum Hardware Requirements**
- **RAM**: 32 GB (120 GB recommended for large datasets)
- **Storage**: 5 TB free disk space
- **CPU**: Multi-core processor (16+ cores recommended)

### **Software Requirements**
- **Operating System**: Linux (Ubuntu 18.04+ or CentOS 7+) or macOS
- **Python**: 3.7 - 3.9
- **R**: 4.0.0 or higher
- **Java**: 8 or higher (required for some tools)

---

## **Quick Start Guide**

### **1. Environment Setup**
```bash
# Clone your repository
git clone <your-repository-url>
cd <your-repository-name>

# Set up conda environment
conda env create -f environment.yml  # if you have an environment file
# or
conda create -n chromatin_analysis python=3.8
conda activate chromatin_analysis
```

### **2. Install Dependencies**
```bash
# Install all conda packages
conda install -c bioconda -c conda-forge fastqc fastp snakemake bowtie homer r-base

# Install Python packages
pip install tobias

# Install R packages (run in R console)
source("install_r_packages.R")
```

### **3. Download Reference Genome**
```bash
# Create reference directory
mkdir -p reference/mm10
cd reference/mm10

# Download mm10 genome
wget http://hgdownload.cse.ucsc.edu/goldenPath/mm10/bigZips/mm10.fa.gz
gunzip mm10.fa.gz

# Index genome for Bowtie
bowtie-build mm10.fa mm10
```

### **4. Test Installation**
```bash
# Test tools
fastqc --version
fastp --version
snakemake --version
tobias --version
bowtie --version

# Test R packages
Rscript -e "library(ArchR); library(Seurat); library(ggplot2); cat('All R packages loaded successfully\n')"
```

---

## **Troubleshooting**

### **Common Issues**

1. **TOBIAS installation fails**
   ```bash
   # Try installing dependencies first
   pip install numpy scipy matplotlib seaborn pysam
   pip install tobias
   ```

2. **ArchR installation fails**
   ```r
   # Install system dependencies on Ubuntu
   sudo apt-get install libxml2-dev libcurl4-openssl-dev libssl-dev
   # Then install ArchR
   BiocManager::install("ArchR")
   ```

3. **Memory issues**
   - Increase available RAM or use cluster computing
   - Process smaller chunks of data
   - Use disk-based processing options where available

---

## **Contact & Support**

For questions or issues with the pipeline, please:
1. Check the individual tool documentation
2. Search existing issues in this repository
3. Create a new issue with detailed error messages and system information

### **Useful Links**
- [FastQC Documentation](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
- [TOBIAS Documentation](https://github.com/loosolab/TOBIAS)
- [ArchR Documentation](https://www.archrproject.com/)
- [Seurat Documentation](https://satijalab.org/seurat/)
- [Homer](http://homer.ucsd.edu/homer/download.html)

---

## **Citation**

If you use this pipeline in your research, please cite the relevant tools and packages used in your analysis.
