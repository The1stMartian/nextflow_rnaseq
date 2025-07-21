# NextFlow RNA-Seq Pipeline 
An RNA-Seq pipeline written in NextFlow and ready for deployment in the cloud (AWS/Docker)

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
        - the -log command ensures that the nextflow log files are written to the out folder
        - the output files will be written to the /output folder

## Building the Docker container from scratch
- Build the human genome using STAR. This takes several hours.
- Download the nextflow binary file
- Modify the dockerfile:
|&nbsp;&nbsp;&nbsp;&nbsp;├- include the genome folder in the dockerfile under "ADD path/to/genome /genomeFiles/hg38"
|&nbsp;&nbsp;&nbsp;&nbsp;├- include the nextflow binary path "ADD path/to/nextflow /usr/bin"
