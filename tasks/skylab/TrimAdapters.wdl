version 1.0

task TrimAdapters {

  input {
    Array[String] fastq1_input_files
    Array[String] fastq2_input_files
    File adapter_list

    #runtime values
    String docker = "quay.io/humancellatlas/snss2-trim-adapters:0.1.0"
    Int machine_mem_mb = 8250
    Int cpu = 1
    Int disk = 100
    #ceil(size(fastq1, "Gi") * 2) + 10
    Int preemptible = 3
  }

  meta {
    description: "Trims adapters from FASTQ files."
  }

  parameter_meta {
    docker: "(optional) the docker image containing the runtime environment for this task"
    machine_mem_mb: "(optional) the amount of memory (MiB) to provision for this task"
    cpu: "(optional) the number of cpus to provision for this task"
    disk: "(optional) the amount of disk space (GiB) to provision for this task"
    preemptible: "(optional) if non-zero, request a pre-emptible instance and allow for this number of preemptions before running the task on a non preemptible machine"
  }

  command {
    set -e

    fastq1_files=~{sep=' ' fastq1_input_files}
    fastq2_files=~{sep=' ' fastq2_input_files}

    for (( i=0; i<${#fastq1_input_files[@]}; ++i));
      do
        fastq1=${fastq1_files[$i]}
        fastq2=${fastq2_files[$i]}

        fastq-mcf \
           -C 200000 ~{adapter_list} \
           ~{fastq1} \
           ~{fastq2} \
           -o "${fastq1_files[$i]}.trimmed.fastq.gz" \
           -o "${fastq2_files[$i]}.trimmed.fastq.gz"
      done;
  }

  runtime {
    docker: docker
    memory: "${machine_mem_mb} MiB"
    disks: "local-disk ${disk} HDD"
    cpu: cpu
    preemptible: preemptible
  }

  output {
    Array[File] trimmed_fastq1_files = "~{fastq1_input_files}.trimmed.fastq.gz"
    Array[File] trimmed_fastq2_files = "~{fastq2_input_files}.trimmed.fastq.gz"
  }
}
