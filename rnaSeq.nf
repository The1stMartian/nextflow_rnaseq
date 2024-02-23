params.memory = 10G
params.fastqFolder = "/input/fastq/*{_R1,_R2}.fastq"
params.genome = "/genomeFiles/hg38"
params.out = "/output/"
params.FQC_out_fldr = "/output/fastqc"
params.threads = 6
params.temp = "./temp"
fqs = Channel.fromFilePairs(params.fastqFolder)

process fastqc {

    debug true

    input: 
    val fq
    val outputFolder
	
    script:
    """
    mkdir -p ${outputFolder}
    fastqc --noextract -o ${outputFolder} ${fq[1][0]} ${fq[1][1]}
    """

}

process MAP {
    input: 
    val fq
    val gnmPath
    val out
    val threads
    val temp

    output:
    stdout

    script:
    """
    STAR --genomeDir ${gnmPath} --runThreadN ${threads} --readFilesIn ${fq[1][0]} ${fq[1][1]} --outSAMtype BAM SortedByCoordinate  --outTmpDir ${temp} --quantMode GeneCounts  --outFileNamePrefix ${out}${fq[0]} 
    """
    }

workflow {
    fqs.view(x -> print("Processing sample: ${x[0]}"))
    fastqc(fqs, params.FQC_out_fldr)
    MAP(fqs, params.genome, params.out, params.threads, params.temp)
    }