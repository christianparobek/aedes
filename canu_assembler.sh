## Started 3 Nov 2017
## Christian P.
## De novo assembly of Aedes Sequel long reads
## Using Canu



##########################
## CONVERT BAM TO FASTQ ##
##########################

samtools bam2fq seq/m54089_171012_022541.subreads.bam > seq/m54089_171012_022541.subreads.fq


##########################
######## RUN CANU ########
##########################

canu -p take_one -d assemblies/2018-01-11_take_one useGrid=false genomesize=1400M corMaxEvidenceErate=0.15 -pacbio-raw seq/m54089_171012_022541.subreads.fq merylThreads=2 merylMemory=10 batThreads=2 batMemory=10 cnsThreads=2 cnsMemory=10 ovsMethod=sequential

## The ovsMethod=sequential is needed on my local machine



## It doesnt really work when I use these:

gridOptions="bsub -n 6 -R 'span[hosts=1]'"
maxThreads=6

## So try getting a dedicated node and run just this:

useGrid=false


bsub -n 12 -R "span[hosts=1]" canu -p take_three -d assemblies/2018-01-10_take_three useGrid=false genomesize=1400M corMaxEvidenceErate=0.15 -pacbio-raw seq/m54089_171012_022541.subreads.fq maxThreads=12 maxMemory=40

## Setting maxThreads and maxMemory doesn't seem to be working, so try setting it explicitly, below. The ovsMethod=sequential is necessary for running it on my laptop. May or may not be necessary on the cluster. Won't be necessary on the cluster if I can get parallel jobs going.

canu -p take_two -d assemblies/2018-01-11_take_two useGrid=false genomesize=1400M corMaxEvidenceErate=0.15 -pacbio-raw seq/m54089_171012_022541.subreads.fq merylThreads=2 merylMemory=10 batThreads=2 batMemory=10 cnsThreads=2 cnsMemory=10 ovsMethod=sequential

## OK so one problem with the above is that my interactive nodes die after a certain amount of time. They just poop out. Not sure if this is related to the job I'm runnin or if they just kick you out after a certain amount of time. That would be silly. So try the above, just bsubbing it
bsub -n 2 -M 10 -R 'span[hosts=1]' canu -p take_three -d assemblies/2018-01-11_take_three useGrid=false genomesize=1400M corMaxEvidenceErate=0.15 -pacbio-raw seq/m54089_171012_022541.subreads.fq merylThreads=2 merylMemory=10 batThreads=2 batMemory=10 cnsThreads=2 cnsMemory=10 ovsMethod=sequential

## This seems to be working for now... but it was killed because some processes requested up to 32GB of memory... so going to ask the cluster for 32GB and up the memory to 32 for these three explicit ones.

bsub -n 2 -M 32 -R 'span[hosts=1]' canu -p take_four -d assemblies/2018-01-11_take_four useGrid=false genomesize=1400M corMaxEvidenceErate=0.15 -pacbio-raw seq/m54089_171012_022541.subreads.fq merylThreads=2 merylMemory=32 batThreads=2 batMemory=32 cnsThreads=2 cnsMemory=32 ovsMethod=sequential

## OK let's try to speed things up a bit. First, up the number of allowed threads and memory
bsub -n 8 -M 45 -R 'span[hosts=1]' canu -p take01 -d assemblies/2018-01-12_take01 useGrid=false genomesize=1400M corMaxEvidenceErate=0.15 -pacbio-raw seq/m54089_171012_022541.subreads.fq merylThreads=8 merylMemory=45 batThreads=8 batMemory=45 cnsThreads=8 cnsMemory=45 ovsMethod=sequential

bsub -n 4 -M 32 -R 'span[hosts=1]' canu -p take02 -d assemblies/2018-01-12_take02 useGrid=false genomesize=1400M corMaxEvidenceErate=0.15 -pacbio-raw seq/m54089_171012_022541.subreads.fq merylThreads=4 merylMemory=32 batThreads=4 batMemory=32 cnsThreads=4 cnsMemory=32 ovsMethod=sequential

## OK let's try to speed things up a bit. First, up the number of allowed threads and memory
bsub -n 8 -M 45 -R 'span[hosts=1]' canu -p take03 -d assemblies/2018-01-12_take03 useGrid=false genomesize=1400M corMaxEvidenceErate=0.15 -pacbio-raw seq/m54089_171012_022541.subreads.fq merylThreads=8 merylMemory=45 batThreads=8 batMemory=45 cnsThreads=8 cnsMemory=45 ovsMethod=parallel gridOptionsJobName=a1

## All those timed out :( Submitted them to whatever the default queue was. Now submitting to fortnight from now on.

bsub -n 4 -M 32 -q week -R 'span[hosts=1]' canu -p take01 -d assemblies/2018-01-13_take01 useGrid=false genomesize=1400M corMaxEvidenceErate=0.15 -pacbio-raw seq/m54089_171012_022541.subreads.fq merylThreads=4 merylMemory=32 batThreads=4 batMemory=32 cnsThreads=4 cnsMemory=32 ovsMethod=sequential gridOptionsJobName=a3

bsub -n 8 -M 32 -q week -R 'span[hosts=1]' canu -p take02 -d assemblies/2018-01-13_take02 useGrid=false genomesize=1400M corMaxEvidenceErate=0.15 -pacbio-raw seq/m54089_171012_022541.subreads.fq merylThreads=8 merylMemory=32 batThreads=8 batMemory=32 cnsThreads=8 cnsMemory=32 ovsMethod=sequential gridOptionsJobName=a4

bsub -n 8 -M 45 -q week -R 'span[hosts=1]' canu -p take03 -d assemblies/2018-01-13_take03 useGrid=false genomesize=1400M corMaxEvidenceErate=0.15 -pacbio-raw seq/m54089_171012_022541.subreads.fq merylThreads=8 merylMemory=45 batThreads=8 batMemory=45 cnsThreads=8 cnsMemory=45 ovsMethod=sequential gridOptionsJobName=a5

bsub -n 8 -M 45 -q week -R 'span[hosts=1]' canu -p take04 -d assemblies/2018-01-13_take04 useGrid=false genomesize=1400M corMaxEvidenceErate=0.15 -pacbio-raw seq/m54089_171012_022541.subreads.fq merylThreads=8 merylMemory=45 batThreads=8 batMemory=45 cnsThreads=8 cnsMemory=45 ovsMethod=parallel gridOptionsJobName=a6

## Those are still running, but I'd like to start playing with the grid
bsub -n 8 -M 45 -q week -R 'span[hosts=1]' canu -p a7 -d assemblies/2018-01-14_a7 useGrid=true gridOptions="bsub -n 8 -M 45 -q week -R 'span[hosts=1]'" genomesize=1400M corMaxEvidenceErate=0.15 -pacbio-raw seq/m54089_171012_022541.subreads.fq merylThreads=8 merylMemory=45 batThreads=8 batMemory=45 cnsThreads=8 cnsMemory=45 ovsMethod=parallel gridOptionsJobName=a7 

bsub -n 4 -M 32 -q week -R 'span[hosts=1]' canu -p a8 -d assemblies/2018-01-14_a8 useGrid=true gridOptions="bsub -n 4 -M 32 -q week -R 'span[hosts=1]'" genomesize=1400M corMaxEvidenceErate=0.15 -pacbio-raw seq/m54089_171012_022541.subreads.fq merylThreads=4 merylMemory=32 batThreads=4 batMemory=32 cnsThreads=4 cnsMemory=32 ovsMethod=parallel gridOptionsJobName=a8 useGrid=remote
## So the two above failed, possibly because it shot off a job before prior jobs could run. Maybe asking for just -n 2 would be better? Re-running the latter with useGrid=remote, which might ask me to submit each lsf job manually; impractical, but could let me better understand it.

# We'll I'm just going to run this again and see where it fails... can maybe learn something from
bsub -n 4 -M 32 -q week -R 'span[hosts=1]' canu -p a9 -d assemblies/2018-01-14_a9 useGrid=true gridOptions="bsub -n 4 -M 32 -q week -R 'span[hosts=1]'" genomesize=1400M corMaxEvidenceErate=0.15 -pacbio-raw seq/m54089_171012_022541.subreads.fq merylThreads=4 merylMemory=32 batThreads=4 batMemory=32 cnsThreads=4 cnsMemory=32 ovsMethod=parallel gridOptionsJobName=a9

# Maybe bsubbing a bsub is a problem... duh
bsub -n 4 -M 32 -q week -R 'span[hosts=1]' canu -p a10 -d assemblies/2018-01-15_a10 useGrid=true gridOptions="-n 4 -M 32 -q week -R 'span[hosts=1]'" genomesize=1400M corMaxEvidenceErate=0.15 -pacbio-raw seq/m54089_171012_022541.subreads.fq merylThreads=4 merylMemory=32 batThreads=4 batMemory=32 cnsThreads=4 cnsMemory=32 ovsMethod=parallel gridOptionsJobName=a10

# OK so all my jobs finished up from before - the 8-core and the 4-core jobs took approx the same amount of time. So go ahead and try assembling all 5 data points with a 4-core.
bsub -n 4 -M 32 -q week -R 'span[hosts=1]' canu -p a11 -d assemblies/2018-01-15_a11 useGrid=true gridOptions="-n 4 -M 32 -q week -R 'span[hosts=1]'" genomesize=1400M corMaxEvidenceErate=0.15 -pacbio-raw seq/*.subreads.fq merylThreads=4 merylMemory=32 batThreads=4 batMemory=32 cnsThreads=4 cnsMemory=32 ovsMethod=parallel gridOptionsJobName=a11

bsub samtools bam2fq m54089_180102_152045.subreads.bam > m54089_180102_152045.subreads.fq
bsub samtools bam2fq m54089_180103_013037.subreads.bam > m54089_180103_013037.subreads.fq
bsub samtools bam2fq m54089_180103_114029.subreads.bam > m54089_180103_114029.subreads.fq
bsub samtools bam2fq m54089_180103_215010.subreads.bam > m54089_180103_215010.subreads.fq

# Why did my a11 job flame out? Did I accidentally kill one of its controller processes?
bsub -n 4 -M 32 -q week -R 'span[hosts=1]' canu -p a12 -d assemblies/2018-01-16_a12 useGrid=true gridOptions="-n 4 -M 32 -q week -R 'span[hosts=1]'" genomesize=1400M corMaxEvidenceErate=0.15 -pacbio-raw seq/*.subreads.fq merylThreads=4 merylMemory=32 batThreads=4 batMemory=32 cnsThreads=4 cnsMemory=32 ovsMethod=parallel gridOptionsJobName=a12

# a12 failed with "canu failed with 'failed to generate mer counts.  Made 2 attempts, jobs still failed'." Try resubmitting with more memory
bsub -n 8 -M 64 -q week -R 'span[hosts=1]' canu -p a13 -d assemblies/2018-01-16_a13 useGrid=true gridOptions="-n 8 -M 64 -q week -R 'span[hosts=1]'" genomesize=1400M corMaxEvidenceErate=0.15 -pacbio-raw seq/*.subreads.fq merylThreads=8 merylMemory=64 batThreads=8 batMemory=64 cnsThreads=8 cnsMemory=64 ovsMethod=parallel gridOptionsJobName=a13

# Also, since memory is an an issue, and requesting lots of 8-core jobs is going to be difficult, go ahead and submit a 16-core, 126GB job; not under grid control
bsub -n 16 -M 125 -q week -R 'span[hosts=1]' canu -p a14 -d assemblies/2018-01-16_a14 useGrid=false genomesize=1400M corMaxEvidenceErate=0.15 -pacbio-raw seq/*.subreads.fq merylThreads=16 merylMemory=125 batThreads=16 batMemory=125 cnsThreads=16 cnsMemory=125 ovsMethod=sequential gridOptionsJobName=a14



bsub -n 8 -M 64 -q week -R 'span[hosts=1]' canu -p a13 -d assemblies/2018-01-16_a13 useGrid=true gridOptions="-n 8 -M 64 -q week -R 'span[hosts=1]'" genomesize=1400M corMaxEvidenceErate=0.15 -pacbio-raw seq/*.subreads.fq merylThreads=8 merylMemory=64 batThreads=8 batMemory=64 cnsThreads=8 cnsMemory=64 ovsMethod=parallel gridOptionsJobName=a13


canu -correct -p a15 -d a15 genomeSize=1400M -pacbio-raw  seq/*.subreads.fq java="/proj/ideel/apps/brew/bin/java"


canu -assemble -p a15_erate_0.039 -d assemblies/a15_erate_0.039 genomeSize=1400M correctedErrorRate=0.039 -pacbio-corrected assemblies/2018-01-16_a13/a13.trimmedReads.fastq

canu -assemble \
  -p ecoli -d ecoli-erate-0.075 \
  genomeSize=4.8m \
  correctedErrorRate=0.075 \
  -pacbio-corrected ecoli/ecoli.trimmedReads.fasta.gz


## Going to try re-running my a13 job from the beginning with canu on Longleaf (sbatch)
## Submitted from head node
## However, this is kind of generic as I've stripped all the specifics out of the a13 job
sbatch --mem-per-cpu=8g --cpus-per-task=1 --time=24:00:00 -J "a15" --mail-type=END --mail-user=cmp@unc.edu --wrap="canu -p a15 -d assemblies/2018-03-11_a15  genomesize=1400M -pacbio-raw seq/*.subreads.fq gridOptionsJobName=a15"

## Adding in command to email me whenever a job finishes
sbatch --mem-per-cpu=8g --cpus-per-task=1 --time=24:00:00 -J "a16" --mail-type=END --mail-user=cmp@unc.edu --wrap="canu -p a16 -d assemblies/2018-03-12_a16  genomesize=1400M -pacbio-raw seq/*.subreads.fq gridOptionsJobName=a16 gridOptions='--mail-user=cmp@unc.edu'"

## Run this one on a compute node initially, see what happens
## Whoops forgot to add the mail-type flag
canu -p a17 -d assemblies/2018-03-12_a17 genomesize=1400M -pacbio-raw seq/*.subreads.fq gridOptionsJobName=a17 gridOptions='--mail-user=cmp@unc.edu'

## So add that below
canu -p a18 -d assemblies/2018-03-12_a18 genomesize=1400M -pacbio-raw seq/*.subreads.fq gridOptionsJobName=a18 gridOptions='--mail-type=END --mail-user=cmp@unc.edu'

## Also start working on a13 adaptation for Longleaf
## Not passing any requests for CPUs or Mem to gridOptions, per their recommendation
## Removed this: corMaxEvidenceErate=0.15 
## Also only using one run (i.e. replaced seq/*.subreads.fq)
canu -p a19 -d assemblies/2018-03-12_a19 useGrid=true gridOptions='--mail-type=END --mail-user=cmp@unc.edu' genomesize=1400M -pacbio-raw seq/m54089_171012_022541.subreads.fq merylThreads=8 merylMemory=64 batThreads=8 batMemory=64 cnsThreads=8 cnsMemory=64 ovsMethod=parallel gridOptionsJobName=a19

canu -p a20 -d assemblies/2018-03-14_a20 useGrid=true genomesize=1400M -pacbio-raw seq/m54089_171012_022541.subreads.fq merylThreads=8 merylMemory=64 batThreads=8 batMemory=64 cnsThreads=8 cnsMemory=64 ovsMethod=parallel gridOptionsJobName=a20

###################################################
#################### POLISHING ####################
###################################################

## Index the new canu-produced reference genome
samtools faidx polishing/2017-11-14_take_one_polishing/take_one.contigs.fasta

## The next steps will have to be run on Longleaf
## Get an interactive node using this:
srun --x11=first --pty /bin/bash

sbatch -t 10080 -n 24 --mail-type=BEGIN,END --mail-user=cmp@unc.edu --wrap="pbalign --nproc 24 --tmpDir polishing/2017-11-14_take_one_polishing/temp_files/ --algorithmOptions='--bestn 1' seq/m54089_171012_022541.subreads.bam polishing/2017-11-14_take_one_polishing/take_one.contigs.fasta polishing/2017-11-14_take_one_polishing/take_one.aligned_subreads.bam"

sbatch -t 10080 -n 2 --mail-type=BEGIN,END --mail-user=cmp@unc.edu --wrap="variantCaller -j2 --algorithm=arrow polishing/2017-11-14_take_one_polishing/take_one.aligned_subreads.bam --reference polishing/2017-11-14_take_one_polishing/take_one.contigs.fasta -o polishing/2017-11-14_take_one_polishing/variants.gff -o polishing/2017-11-14_take_one_polishing/consensus.fasta -o polishing/2017-11-14_take_one_polishing/consensus.fastq"

