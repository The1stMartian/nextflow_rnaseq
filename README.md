# NextFlow RNA-Seq Pipeline 
A simple RNA-Seq pipeline written in NextFlow and for local deployment via Docker

## Pipeline
- Runs FastQC
- Maps to the human genome (GRCh38) with RefSeq annotations using STAR
- Outputs: 1) all .bam files, 2) Read counts files, and 3) FastQC output files

## Docker 
- Has Ubuntu with STAR, FastQC, and STAR genome files (GRCh38)

## Running the script
- Set up your folders like:<br>
├─ Your working folder<br>
|&nbsp;&nbsp;&nbsp;&nbsp;├─ output<br>
|&nbsp;&nbsp;&nbsp;&nbsp;├─ input<br>
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- rnaseq.nf<br>
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- fastq<br>
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- sample1_R1.fastq<br>
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- sample1_R2.fastq<br>
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- sample2_R1.fastq<br>
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|-- sample2_R2.fastq<br>

- Run Docker: docker -it -v /path/to/input:/input -v  /path/to/output:/output rnaseq
- In the docker container, cd to /input: "cd /input"
- Run the nextflow pipeline: "nextflow -log /output/myRun.log run rnaSeq.nf"
    Notes:<br> 
        - the -log command ensures that the nextflow log files are written to the out folder<br>
        - the output files will be written to the /output folder<br>

## Building the Docker container from scratch
- Prior to building the docker container:
- Download the HG38 genome files from NCBI and build the human genome using STAR. (Can take several hours.)
- Download the nextflow binary to a local directory (curl -s https://get.nextflow.io | bash)
- Modify the dockerfile to specify the path to your local folders containing the NextFlow binary and genome files: "ADD path/to/genomeFolder /genomeFiles/hg38" and "ADD path/to/NextFlowBinary /usr/bin". These commands will add NextFlow to a location on the path and place the genome in the correct location for STAR.
- Then build the docker container with "docker build -t <name> ."
