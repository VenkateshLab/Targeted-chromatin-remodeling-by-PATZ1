#!/bin/bash

# Check if Docker is installed
if ! command -v docker &> /dev/null
then
    echo "Docker is not installed. Please install Docker before running this script."
    exit 1
fi

#reference genome of mm10 can be downloaded from "https://www.10xgenomics.com/support/software/cell-ranger-arc/downloads"
# Default parameters
REFERENCE_GENOME="Reference_genome/refdata-cellranger-arc-mm10-2020-A-2.0.0/"
FASTQ_DIR="Fastq_files"
LOCAL_MEM=200
LOCAL_CORES=20
IMAGE_NAME="jsschrepping/cellranger-atac:jss_v0.1"

# Function to run Cell Ranger ATAC
run_cellranger() {
    SAMPLE_ID=$1
    echo "Running Cell Ranger ATAC for sample: $SAMPLE_ID"

    docker run --rm -it -v "$PWD":/data $IMAGE_NAME \
        cellranger-atac count \
        --id="$SAMPLE_ID" \
        --reference="$REFERENCE_GENOME" \
        --fastqs="$FASTQ_DIR/$SAMPLE_ID/" \
        --sample="$SAMPLE_ID" \
        --localmem=$LOCAL_MEM \
        --localcores=$LOCAL_CORES

    echo "Processing for $SAMPLE_ID completed!"
}

# Check for sample arguments
if [ $# -eq 0 ]; then
    echo "Usage: $0 sample1 [sample2 sample3 ...]"
    exit 1
fi

# Run for each sample provided
for SAMPLE in "$@"
do
    run_cellranger "$SAMPLE"
done

echo "All samples have been processed."