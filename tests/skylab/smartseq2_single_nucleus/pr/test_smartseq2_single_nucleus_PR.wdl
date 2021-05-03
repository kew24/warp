version 1.0

import "https://raw.githubusercontent.com/broadinstitute/warp/np_snss2_pr_test/pipelines/skylab/smartseq2_single_nucleus/SmartSeq2SingleNucleus.wdl" as target_wdl
import "https://raw.githubusercontent.com/broadinstitute/warp/np_snss2_pr_test/tests/skylab/smartseq2_single_nucleus/pr/ValidateSmartSeq2SingleNucleus.wdl" as checker_wdl


# this task will be run by the jenkins script that gets executed on our PRs.
workflow TestSmartSeq2SingleNucleusPR {
  input {
    # Validation input
    #String loom_output
    String counts
    String expected_counts_hash
   # File? target_metrics
   # String expected_metrics_hash

    # snSS2 inputs
    File genome_ref_fasta
    File tar_star_reference
    File annotations_gtf
    String stranded
    String input_id
    String output_name
    File adapter_list
    File fastq1
    File? fastq2
    Boolean paired_end
  }

  call target_wdl.SmartSeq2SingleNucleus as target_workflow {
    input:
      genome_ref_fasta = genome_ref_fasta,
      stranded = stranded,
      input_id = input_id,
      output_name = output_name,
      fastq1 = fastq1,
      fastq2 = fastq2,
      paired_end = true,
      adapter_list = adapter_list,
      annotations_gtf = annotations_gtf,
      tar_star_reference = tar_star_reference

  }

# need to compare looms, but have to wait until wdl is done?
#  call checker_wdl.ValidateSmartSeq2Plate as checker_workflow {
#    input:
#      loom_output = target_workflow.loom_output,
#      truth_loom = truth_loom
#  }

   call checker_wdl.CompareCounts as checker_workflow {
     input:
      #counts needs to come from wdl, but that isnt done yet
      counts = counts,
      expected_counts_hash = expected_counts_hash,
      # target_metrics = target_workflow.insert_size_metrics,
      # expected_metrics_hash = expected_metrics_hash
    }
}