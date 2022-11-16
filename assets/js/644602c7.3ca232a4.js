"use strict";(self.webpackChunkwebsite_2=self.webpackChunkwebsite_2||[]).push([[4182],{3905:function(e,t,n){n.d(t,{Zo:function(){return d},kt:function(){return m}});var i=n(7294);function r(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function a(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(e);t&&(i=i.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,i)}return n}function o(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?a(Object(n),!0).forEach((function(t){r(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):a(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function l(e,t){if(null==e)return{};var n,i,r=function(e,t){if(null==e)return{};var n,i,r={},a=Object.keys(e);for(i=0;i<a.length;i++)n=a[i],t.indexOf(n)>=0||(r[n]=e[n]);return r}(e,t);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);for(i=0;i<a.length;i++)n=a[i],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(r[n]=e[n])}return r}var p=i.createContext({}),s=function(e){var t=i.useContext(p),n=t;return e&&(n="function"==typeof e?e(t):o(o({},t),e)),n},d=function(e){var t=s(e.components);return i.createElement(p.Provider,{value:t},e.children)},c={inlineCode:"code",wrapper:function(e){var t=e.children;return i.createElement(i.Fragment,{},t)}},u=i.forwardRef((function(e,t){var n=e.components,r=e.mdxType,a=e.originalType,p=e.parentName,d=l(e,["components","mdxType","originalType","parentName"]),u=s(n),m=r,h=u["".concat(p,".").concat(m)]||u[m]||c[m]||a;return n?i.createElement(h,o(o({ref:t},d),{},{components:n})):i.createElement(h,o({ref:t},d))}));function m(e,t){var n=arguments,r=t&&t.mdxType;if("string"==typeof e||r){var a=n.length,o=new Array(a);o[0]=u;var l={};for(var p in t)hasOwnProperty.call(t,p)&&(l[p]=t[p]);l.originalType=e,l.mdxType="string"==typeof e?e:r,o[1]=l;for(var s=2;s<a;s++)o[s]=n[s];return i.createElement.apply(null,o)}return i.createElement.apply(null,n)}u.displayName="MDXCreateElement"},8918:function(e,t,n){n.r(t),n.d(t,{frontMatter:function(){return o},contentTitle:function(){return l},metadata:function(){return p},toc:function(){return s},default:function(){return c}});var i=n(7462),r=n(3366),a=(n(7294),n(3905)),o={sidebar_position:2},l="CEMBA_v1.1.0 Publication Methods",p={unversionedId:"Pipelines/CEMBA_MethylC_Seq_Pipeline/CEMBA.methods",id:"Pipelines/CEMBA_MethylC_Seq_Pipeline/CEMBA.methods",isDocsHomePage:!1,title:"CEMBA_v1.1.0 Publication Methods",description:"Below we provide a sample methods section for a publication. For the complete pipeline documentation, see the CEMBA README.",source:"@site/docs/Pipelines/CEMBA_MethylC_Seq_Pipeline/CEMBA.methods.md",sourceDirName:"Pipelines/CEMBA_MethylC_Seq_Pipeline",slug:"/Pipelines/CEMBA_MethylC_Seq_Pipeline/CEMBA.methods",permalink:"/warp/docs/Pipelines/CEMBA_MethylC_Seq_Pipeline/CEMBA.methods",editUrl:"https://github.com/broadinstitute/warp/edit/develop/website/docs/Pipelines/CEMBA_MethylC_Seq_Pipeline/CEMBA.methods.md",tags:[],version:"current",lastUpdatedBy:"kew24",lastUpdatedAt:1668631540,formattedLastUpdatedAt:"11/16/2022",sidebarPosition:2,frontMatter:{sidebar_position:2},sidebar:"docsSidebar",previous:{title:"CEMBA Overview",permalink:"/warp/docs/Pipelines/CEMBA_MethylC_Seq_Pipeline/README"},next:{title:"Exome Germline Single Sample Overview",permalink:"/warp/docs/Pipelines/Exome_Germline_Single_Sample_Pipeline/README"}},s=[{value:"Methods",id:"methods",children:[]}],d={toc:s};function c(e){var t=e.components,n=(0,r.Z)(e,["components"]);return(0,a.kt)("wrapper",(0,i.Z)({},d,n,{components:t,mdxType:"MDXLayout"}),(0,a.kt)("h1",{id:"cemba_v110-publication-methods"},"CEMBA_v1.1.0 Publication Methods"),(0,a.kt)("p",null,"Below we provide a sample methods section for a publication. For the complete pipeline documentation, see the ",(0,a.kt)("a",{parentName:"p",href:"/warp/docs/Pipelines/CEMBA_MethylC_Seq_Pipeline/README"},"CEMBA README"),"."),(0,a.kt)("h2",{id:"methods"},"Methods"),(0,a.kt)("p",null,"Data processing was performed with the CEMBA v1.1.0 Pipeline (RRID:SCR_021219). Sequencing reads were first trimmed to remove adaptors using Cutadapt 1.18 with the following parameters in paired-end mode: ",(0,a.kt)("inlineCode",{parentName:"p"},"-f fastq -quality-cutoff 20 -minimum-length 62 -a AGATCGGAAGAGCACACGTCTGAAC -A AGATCGGAAGAGCGTCGTGTAGGGA"),"."),(0,a.kt)("p",null,"After trimming the adapters, an unaligned BAM (uBAM) for the trimmed R1 FASTQ was created using Picard v2.18.23."),(0,a.kt)("p",null,"Cell barcodes were then extracted from the trimmed R1 FASTQ and tagged to the R1 uBAM with Single Cell Tools (sctools) v0.3.4a using a barcode whitelist as well as configurable barcode start positions and lengths."),(0,a.kt)("p",null,"Next, for multiplexed samples, the random primer index sequence and Adaptase C/T tail were further removed from the adaptor-trimmed R1 and R2 FASTQs using Cutadapt with the following parameters: ",(0,a.kt)("inlineCode",{parentName:"p"},"-f fastq -quality-cutoff 16 -quality-cutoff -16 -minimum-length 30"),"."),(0,a.kt)("p",null,"The trimmed R1 and R2 reads were then aligned to mouse (mm10) or human (hg19) genomes separately as single-end reads using Bismark v0.21.0 with the parameters ",(0,a.kt)("inlineCode",{parentName:"p"},"--bowtie2 --icpc --X 2000")," (paired-end mode) and ",(0,a.kt)("inlineCode",{parentName:"p"},"--pbat")," (activated for mapping R1 reads)."),(0,a.kt)("p",null,"After alignment, the output R1 and R2 BAMs were sorted in coordinate order and duplicates removed using the Picard MarkDuplicates REMOVE_DUPLICATE option. Samtools 1.9 was used to further filter BAMs with a minimum map quality of 30 using the parameter ",(0,a.kt)("inlineCode",{parentName:"p"},"-bhq 30"),"."),(0,a.kt)("p",null,"Methylation reports were produced for the filtered BAMs using Bismark. The barcodes from the R1 uBAM were then attached to the aligned, filtered R1 BAM with Picard. The R1 and R2 BAMs were merged with Samtools. Readnames were added to the merged BAM and a methylated VCF created using MethylationTypeCaller in GATK 4.1.2.0. The VCF was then converted to an additional ALLC file using a custom python script."),(0,a.kt)("p",null,"Samtools was then used to calculate coverage depth for sites with coverage greater than 1 and to create BAM index files. The final outputs included the barcoded aligned BAM, BAM index, a VCF with locus-specific methylation information, VCF index, ALLC file, and methylation reports."),(0,a.kt)("p",null,"An example of the pipeline and its outputs is available on ",(0,a.kt)("a",{parentName:"p",href:"https://app.terra.bio/#workspaces/brain-initiative-bcdc/Methyl-c-seq_Pipeline"},"Terra"),". Examples of genomic reference files and other inputs can be found in the pipeline\u2019s ",(0,a.kt)("a",{parentName:"p",href:"https://github.com/broadinstitute/warp/blob/develop/pipelines/cemba/cemba_methylcseq/example_inputs/CEMBA.inputs.json"},"example JSON"),"."))}c.isMDXComponent=!0}}]);