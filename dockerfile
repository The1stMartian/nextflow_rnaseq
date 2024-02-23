FROM ubuntu

WORKDIR /mnt/c/test/d
RUN apt-get update
RUN apt-get -y install curl

# Install RNA STAR
RUN apt-get -y install rna-star

# Install fastqc
RUN apt-get -y install fastqc

# Install java for nextflow
RUN apt install -y openjdk-17-jdk openjdk-17-jre

# Install nextflow as a pre-compiled binary
ADD nextflow /usr/bin
RUN nextflow self-update

# Add STAR genome files
ADD /hg38 /genomeFiles/hg38

# Add vim for text editing
RUN apt-get -y install vim

# Create input/output directories
RUN mkdir /input
RUN mkdir /output
