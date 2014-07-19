#!/bin/bash

#Following: http://theglassicon.com/computing/machine-learning/running-lda-algorithm-mahout
# and http://www.slideshare.net/Hadoop_Summit/stella-june27-1150amroom210av2
# and http://stackoverflow.com/questions/21318459/how-to-run-mahout-cvb-on-reuters-news-on-cloudera-vm-cdh4-5-as-lda-is-not-longer
# and http://qnalist.com/questions/4878421/extracting-document-topic-inference-with-the-new-lda-cvb-algorithm
RUN="11"
MAHOUT="mahout"
HDFS_DIR="/runs/r${RUN}"
WORK_DIR="`pwd`/out"
OUT_DIR="/disk3/user_work/runs/mahout_r${RUN}"

#Run cvb
# For now: disable perplexity calculation
#  -tf 0.1 \
$MAHOUT cvb \
  -i /cw-out-matrix/matrix \
  -o ${HDFS_DIR}/topics \
  -dict /cw-seqdir-sparse-lda/dictionary.file-* \
  -dt ${HDFS_DIR}/doc-topics \
  --tempDir ${HDFS_DIR}/cas-temp/ \
  -k 10 \
  -nt 327680000 \
  -x 1 \
  -seed 42 \
  --num_reduce_tasks 256 \
  -Dmapred.reduce.tasks=256 \
  >> ${OUT_DIR}/log.log 2>&1 \
  && \
#./mahout cvb -i /home/carsten/Desktop/mahout-sandbox/data/rows/matrix -o /home/carsten/Desktop/mahout-sandbox/data/topics/ -dict /home/carsten/Desktop/mahout-sandbox/data/vec/ -dt /home/carsten/Desktop/mahout-sandbox/data/docTopics/ --tempDir /home/carsten/Desktop/mahout-sandbox/data/temp/ -k 10 -nt 327680 -x 10 -tf 0.1 -seed 23
#output term distributions for each topic
$MAHOUT vectordump \
  -i ${HDFS_DIR}/topics \
  -d /cw-seqdir-sparse-lda/dictionary.file-* \
  -dt ${OUT_DIR}/sequencefile \
  --vectorSize 10 \
  -sort true \
  -o ${OUT_DIR}/terms-topic.txt \
  -p true \
  >> ${OUT_DIR}/log.log 2>&1 \
  && \
#./mahout vectordump -i /home/carsten/Desktop/mahout-sandbox/data/topics/ -d /home/carsten/Desktop/mahout-sandbox/data/vec/dictionary.file-* -dt sequencefile --vectorSize 5 -sort true -o /home/carsten/Desktop/mahout-sandbox/data/terms-topic.txt -p true
#output topic distributions for each document
#./mahout vectordump -i /home/carsten/Desktop/mahout-sandbox/data/docTopics/ -dt sequencefile --vectorSize 5 -sort true -o /home/carsten/Desktop/mahout-sandbox/data/topics-doc.txt -p true
$MAHOUT vectordump \
  -i ${HDFS_DIR}/doc-topics/ \
  -dt ${OUT_DIR}/sequencefile \
  --vectorSize 10 \
  -sort true \
  -o ${OUT_DIR}/topics-doc.txt \
  -p true \
  >> ${OUT_DIR}/log.log 2>&1


