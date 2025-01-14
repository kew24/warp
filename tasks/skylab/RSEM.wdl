version 1.0

task RSEMExpression {
  input {
    File trans_aligned_bam
    File rsem_genome
    String output_basename
    Boolean is_paired
  
    # runtime values
    String docker = "us.gcr.io/broad-gotc-prod/rsem:1.0.0-1663016024"
    Int machine_mem_mb = 32768
    Int cpu = 4
    # use provided disk number or dynamically size on our own, with 200GiB of additional disk
    Int disk = ceil(size(trans_aligned_bam, "GiB") + size(rsem_genome, "GiB") + 200)
    Int preemptible = 5
  }
  
  meta {
    description: "This task will quantify gene expression matrix by using RSEM. The output include gene-level and isoform-level results."
  }

  parameter_meta {
    trans_aligned_bam: "input transcriptome aligned bam"
    rsem_genome: "tar'd RSEM genome"
    output_basename: "basename used for output files"
    docker: "(optional) the docker image containing the runtime environment for this task"
    machine_mem_mb: "(optional) the amount of memory (MiB) to provision for this task"
    cpu: "(optional) the number of cpus to provision for this task"
    disk: "(optional) the amount of disk space (GiB) to provision for this task"
    preemptible: "(optional) if non-zero, request a pre-emptible instance and allow for this number of preemptions before running the task on a non preemptible machine"
  }

  command {
    set -e
  
    tar --no-same-owner -xvf ${rsem_genome}
    rsem-calculate-expression \
      --bam \
      ${true="--paired-end" false="" is_paired} \
       -p ${cpu} \
      --time --seed 555 \
      --calc-pme \
      --single-cell-prior \
      ${trans_aligned_bam} \
      rsem/rsem_trans_index  \
      "${output_basename}"
  }

  runtime {
    docker: docker
    memory: "${machine_mem_mb} MiB"
    disks: "local-disk ${disk} HDD"
    cpu: cpu
    preemptible: preemptible
  }

  output {
    File rsem_gene = "${output_basename}.genes.results"
    File rsem_isoform = "${output_basename}.isoforms.results"
    File rsem_time = "${output_basename}.time"
    File rsem_cnt = "${output_basename}.stat/${output_basename}.cnt"
    File rsem_model = "${output_basename}.stat/${output_basename}.model"
    File rsem_theta = "${output_basename}.stat/${output_basename}.theta"
  }
}

