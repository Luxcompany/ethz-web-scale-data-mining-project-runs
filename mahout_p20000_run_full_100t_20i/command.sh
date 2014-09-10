#!/bin/bash

#Following: http://theglassicon.com/computing/machine-learning/running-lda-algorithm-mahout
# and http://www.slideshare.net/Hadoop_Summit/stella-june27-1150amroom210av2
# and http://stackoverflow.com/questions/21318459/how-to-run-mahout-cvb-on-reuters-news-on-cloudera-vm-cdh4-5-as-lda-is-not-longer
# and http://qnalist.com/questions/4878421/extracting-document-topic-inference-with-the-new-lda-cvb-algorithm
#NUM=$1
echo "Job Starting"
MAHOUT="mahout"
#HDFS_IN="/cw-combined-pruned-20000"
HDFS_IN="/runs/pru_20000_full/"
HDFS_OUT="/runs/pru_20000_full_100t_20i/"
OUT_DIR="/disk3/user_work/runs/mahout_p20000_run_full_100t_20i"

if [ "$HADOOP_HOME" != "" ] && [ "$MAHOUT_LOCAL" == "" ] ; then
  HADOOP="$HADOOP_HOME/bin/hadoop"
  if [ ! -e $HADOOP ]; then
    echo "Can't find hadoop in $HADOOP, exiting"
    exit 1
  fi
fi

#Run cvb
$MAHOUT cvb \
  -i ${HDFS_IN}/cas-out-matrix/matrix \
  -o ${HDFS_OUT}/cas-lda -dict ${HDFS_IN}/seqdir-sparse-lda/dictionary.file-* \
  -dt ${HDFS_OUT}/cas-lda-topics \
  --tempDir ${HDFS_OUT}/cas-temp/ \
  -k 100 -nut 4 -x 20 -tf 0.1 -seed 23 \
  --num_reduce_tasks 2000 \
  >> ${OUT_DIR}/log_cvb.txt 2>&1 \
  && \
#./mahout cvb -i /home/carsten/Desktop/mahout-sandbox/data/rows/matrix -o /home/carsten/Desktop/mahout-sandbox/data/topics/ -dict /home/carsten/Desktop/mahout-sandbox/data/vec/ -dt /home/carsten/Desktop/mahout-sandbox/data/docTopics/ --tempDir /home/carsten/Desktop/mahout-sandbox/data/temp/ -k 10 -nt 327680 -x 10 -tf 0.1 -seed 23
#output term distributions for each topic
$MAHOUT vectordump \
  -i ${HDFS_OUT}/cas-lda \
  -d ${HDFS_IN}/seqdir-sparse-lda/dictionary.file-* \
  -dt sequencefile \
  --vectorSize 100 -sort true \
  -o ${OUT_DIR}/terms-topic.txt \
  -p true \
  >> ${OUT_DIR}/log_vec1.txt 2>&1 \
  && \
#./mahout vectordump -i /home/carsten/Desktop/mahout-sandbox/data/topics/ -d /home/carsten/Desktop/mahout-sandbox/data/vec/dictionary.file-* -dt sequencefile --vectorSize 5 -sort true -o /home/carsten/Desktop/mahout-sandbox/data/terms-topic.txt -p true
#output topic distributions for each document
#./mahout vectordump -i /home/carsten/Desktop/mahout-sandbox/data/docTopics/ -dt sequencefile --vectorSize 5 -sort true -o /home/carsten/Desktop/mahout-sandbox/data/topics-doc.txt -p true
$MAHOUT vectordump \
  -i ${HDFS_OUT}/cas-lda-topics/ \
  -dt sequencefile \
  --vectorSize 100 -sort true \
  -o ${OUT_DIR}/topics-doc.txt \
  -p true \
  >> ${OUT_DIR}/log_vec2.txt 2>&1 \
