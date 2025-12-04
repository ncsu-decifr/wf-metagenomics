process runNanoCLUST {
    label "wfmetagenomics"
    tag "${meta.alias}"
    cpus 4
    memory "8 GB"
    container "docker://genomicsiter/nanoclust:latest"

    publishDir "${params.out_dir}/nanoclust", mode: 'copy'

    input:
        tuple val(meta), path(reads_fastq)

    output:
        tuple val(meta),
            path("${meta.alias}.nanoclust.consensus.fasta"),
            emit: nanoclust_fasta

    script:
    """
    mkdir nanoclust_out

    nanoclust \
        --in ${reads_fastq} \
        --out nanoclust_out \
        --threads ${task.cpus}

    cp nanoclust_out/consensus.fasta \
       ${meta.alias}.nanoclust.consensus.fasta
    """
}