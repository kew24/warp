version 1.0

task SmartSeq2LoomOutput {
  input {
    #runtime values
    String docker = "quay.io/humancellatlas/secondary-analysis-loom-output:0.0.6-1"
    # the gene count file "<input_id>_rsem.genes.results" in the task results folder call-RSEMExpression
    File rsem_gene_results
    # file named "<input_id>_QCs.csv" in the folder  "call-GroupQCOutputs/glob-*" of the the SS2  output
    Array[File] smartseq_qc_files
    # name of the sample
    String input_id
    String? input_name
    String? input_id_metadata_field
    String? input_name_metadata_field

    String pipeline_version
    Int preemptible = 3
    Int disk = 200
    Int machine_mem_mb = 18
    Int cpu = 4
  }

  meta {
    description: "This  task will converts some of the outputs of Smart Seq 2 pipeline into a loom file"
  }

  parameter_meta {
    preemptible: "(optional) if non-zero, request a pre-emptible instance and allow for this number of preemptions before running the task on a non preemptible machine"
  }

  command {
    set -euo pipefail

    python3 /tools/create_loom_ss2.py \
       --qc_files ~{sep=' ' smartseq_qc_files} \
       --rsem_genes_results  ~{rsem_gene_results} \
       --output_loom_path  "~{input_id}.loom" \
       --input_id ~{input_id} \
       ~{"--input_name '" + input_name + "'"} \
       ~{"--input_id_metadata_field " + input_id_metadata_field} \
       ~{"--input_name_metadata_field " + input_name_metadata_field} \
       --pipeline_version ~{pipeline_version}
  }

  runtime {
    docker: docker
    cpu: cpu  # note that only 1 thread is supported by pseudobam
    memory: "~{machine_mem_mb} GiB"
    disks: "local-disk ~{disk} HDD"
    preemptible: preemptible
  }

  output {
    File loom_output = "~{input_id}.loom"
  }
}


task OptimusLoomGeneration {

  input {
    #runtime values
    String docker = "quay.io/humancellatlas/secondary-analysis-loom-output:0.0.6-1"
    # name of the sample
    String input_id
    # user provided id
    String? input_name
    String? input_id_metadata_field
    String? input_name_metadata_field
    # gene annotation file in GTF format
    File annotation_file
    # the file "merged-cell-metrics.csv.gz" that contains the cellwise metrics
    File cell_metrics
    # the file "merged-gene-metrics.csv.gz" that contains the  genwise metrics
    File gene_metrics
    # file (.npz)  that contains the count matrix
    File sparse_count_matrix
    # file (.npy) that contains the array of cell barcodes
    File cell_id
    # file (.npy) that contains the array of gene names
    File gene_id
    # emptydrops output metadata
    File empty_drops_result
    String counting_mode = "sc_rna"

    String pipeline_version

    Int preemptible = 3
    Int disk = 200
    Int machine_mem_mb = 18
    Int cpu = 4
  }

  meta {
    description: "This task will converts some of the outputs of Optimus pipeline into a loom file"
  }

  parameter_meta {
    preemptible: "(optional) if non-zero, request a pre-emptible instance and allow for this number of preemptions before running the task on a non preemptible machine"
  }

  command {
    set -euo pipefail

    if [ "~{counting_mode}" == "sc_rna" ]; then
        EXPRESSION_DATA_TYPE_PARAM="exonic" 
        ADD_EMPTYDROPS_DATA="yes"
    else
        EXPRESSION_DATA_TYPE_PARAM="whole_transcript"
        ADD_EMPTYDROPS_DATA="no" 
    fi

    python3 /tools/create_loom_optimus.py \
       --empty_drops_file ~{empty_drops_result} \
       --add_emptydrops_data $ADD_EMPTYDROPS_DATA \
       --annotation_file ~{annotation_file} \
       --cell_metrics ~{cell_metrics} \
       --gene_metrics ~{gene_metrics} \
       --cell_id ~{cell_id} \
       --gene_id  ~{gene_id} \
       --output_path_for_loom "~{input_id}.loom" \
       --input_id ~{input_id} \
       ~{"--input_name " + input_name} \
       ~{"--input_id_metadata_field " + input_id_metadata_field} \
       ~{"--input_name_metadata_field " + input_name_metadata_field} \
       --count_matrix ~{sparse_count_matrix} \
       --expression_data_type $EXPRESSION_DATA_TYPE_PARAM \
       --pipeline_version ~{pipeline_version}
  }

  runtime {
    docker: docker
    cpu: cpu  # note that only 1 thread is supported by pseudobam
    memory: "~{machine_mem_mb} GiB"
    disks: "local-disk ~{disk} HDD"
    preemptible: preemptible
  }

  output {
    File loom_output = "~{input_id}.loom"
  }
}


task AggregateSmartSeq2Loom {
    input {
        Array[File] loom_input
        String batch_id
        String? batch_name
        String? project_id
        String? project_name
        String? library
        String? species
        String? organ
        String pipeline_version
        String docker = "quay.io/humancellatlas/secondary-analysis-loom-output:0.0.6-1"
        Int disk = 200
        Int machine_mem_mb = 4
        Int cpu = 1
    }

    meta {
      description: "aggregate the loom output"
    }

    command {
      set -e
      
      # Merge the loom files
      python3 /tools/ss2_loom_merge.py \
      --input-loom-files ~{sep=' ' loom_input} \
      --output-loom-file "~{batch_id}.loom" \
      --batch_id ~{batch_id} \
      ~{"--batch_name " + batch_name} \
      ~{"--project_id " + project_id} \
      ~{"--project_name " + project_name} \
      ~{"--library " + library} \
      ~{"--species " + species} \
      ~{"--organ " + organ} \
      --pipeline_version ~{pipeline_version}


    }

    output {
        File loom_output_file = "~{batch_id}.loom"
    }

    runtime {
      docker: docker
      cpu: cpu
      memory: "~{machine_mem_mb} GiB"
      disks: "local-disk ~{disk} HDD"
      preemptible: 3
      maxRetries: 1
    }
}


task SingleNucleusSmartSeq2LoomOutput {
  input {
    #runtime values
    String docker = "quay.io/humancellatlas/secondary-analysis-loom-output:0.0.7"

    Array[File] alignment_summary_metrics
    Array[File] dedup_metrics
    Array[File] gc_bias_summary_metrics

      # introns counts
    Array[File] introns_counts
    # exons counts
    Array[File] exons_counts
    # annotation file 
    File annotation_introns_added_gtf
    # name of the sample
    Array[String] input_ids
    Array[String?] input_names
    Array[String?] input_id_metadata_field
    Array[String?] input_name_metadata_field

    String pipeline_version
    Int preemptible = 3
    Int disk = 200
    Int machine_mem_mb = 8
    Int cpu = 4
  }

  meta {
    description: "This task will convert output from the SmartSeq2SingleNucleus pipeline into a loom file. Contrary to the SmartSeq2 single cell where there is only RSEM counts, here we have intronic and exonic counts per gene name"
  }

  parameter_meta {
    preemptible: "(optional) if non-zero, request a pre-emptible instance and allow for this number of preemptions before running the task on a non preemptible machine"
  }

  command <<<
    set -euo pipefail

    introns_counts_files=~{sep=' ' introns_counts}
    exons_counts_files=~{sep=' ' exons_counts}
    n_files=${#introns_counts_files[@]}
    output_prefix=~{sep=' ' input_ids}
    input_names_list=~{sep=' 'input_names}
    input_id_metadata_field_list=~{sep=' 'input_id_metadata_field}
    input_name_metadata_field_list=~{sep=' 'input_name_metadata_field}

    for (( i=0; i<$n_files; ++i));
      do
        # creates a table with gene_id, gene_name, intron and exon counts
        echo "Running create_snss2_counts_csv."
        python /tools/create_snss2_counts_csv.py \
          --in-gtf ~{annotation_introns_added_gtf} \
          --intron-counts $introns_counts_files[$i] \
          --exon-counts $exons_counts[$i]  \
          -o "$output_prefix[$i].exon_intron_counts.tsv"
        echo "Success create_snss2_counts_csv."

        # groups the QC file into one file
        echo "Running GroupQCs"
        GroupQCs -f alignment_summary_metrics dedup_metrics gc_bias_summary_metrics \
            -t Picard -o "$output_prefix[$i].Picard_group"
        echo "Success GroupQCs"

        # create the loom file
        echo "Running create_loom_snss2."
        python3 /tools/create_loom_snss2.py \
            --qc_files "$output_prefix[$i].Picard_group.csv" \
            --count_results  "$output_prefix[$i].exon_intron_counts.tsv" \
            --output_loom_path "$output_prefix[$i].loom" \
            --input_id $output_prefix[$i] \
            ~{"--input_name " + "$input_names_list[$i]"} \
            ~{"--input_id_metadata_field " + "$input_id_metadata_field_list[$i]"} \
            ~{"--input_name_metadata_field " + "$input_name_metadata_field_list[$i]"} \
            --pipeline_version ~{pipeline_version}
        echo "Success create_loom_snss2"
      done;
  >>>

  runtime {
    docker: docker
    cpu: cpu 
    memory: "~{machine_mem_mb} GiB"
    disks: "local-disk ~{disk} HDD"
    preemptible: preemptible
  }

  output {
    Array[File] loom_output = "~{input_ids}.loom"
    Array[File] exon_intron_counts = "~{input_ids}.exon_intron_counts.tsv"
  }
}


