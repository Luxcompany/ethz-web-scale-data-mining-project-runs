#!/bin/bash

#Following: http://theglassicon.com/computing/machine-learning/running-lda-algorithm-mahout
# and http://www.slideshare.net/Hadoop_Summit/stella-june27-1150amroom210av2
# and http://stackoverflow.com/questions/21318459/how-to-run-mahout-cvb-on-reuters-news-on-cloudera-vm-cdh4-5-as-lda-is-not-longer
# and http://qnalist.com/questions/4878421/extracting-document-topic-inference-with-the-new-lda-cvb-algorithm
NUM=$1
echo "Job ${NUM} Starting"
MAHOUT="mahout"
HDFS_OUT="/runs/sout/${NUM}"
HDFS_AUS="/runs/lartop/${NUM}"
OUT_DIR="/disk3/user_work/runs/mahout_large_topics/${NUM}"


if [ "$HADOOP_HOME" != "" ] && [ "$MAHOUT_LOCAL" == "" ] ; then
  HADOOP="$HADOOP_HOME/bin/hadoop"
  if [ ! -e $HADOOP ]; then
    echo "Can't find hadoop in $HADOOP, exiting"
    exit 1
  fi
fi

#Make sequence files
#./mahout seqdirectory --input /home/carsten/Desktop/mahout-sandbox/data/docs/ --output /home/carsten/Desktop/mahout-sandbox/data/seq/ -c UTF-8
#hdfs dfs -mkdir ${HDFS_DIR}
#&& \
#./mahout rowid -i /home/carsten/Desktop/mahout-sandbox/data/vec/tf-vectors/ -o /home/carsten/Desktop/mahout-sandbox/data/rows/
#hdfs dfs -rm -r ${HDFS_DIR2}/cas-lda ${HDFS_DIR2}/cas-lda-topics ${HDFS_DIR2}/cas-temp \
#&& \
#Run cvb
$MAHOUT cvb \
  -i ${HDFS_OUT}/cas-out-matrix/matrix \
  -o ${HDFS_AUS}/cas-lda -dict ${HDFS_OUT}/seqdir-sparse-lda/dictionary.file-* \
  -dt ${HDFS_AUS}/cas-lda-topics \
  --tempDir ${HDFS_AUS}/cas-temp/ \
  -k 100 -nut 4 -x 10 -tf 0.1 -seed 23 \
  --num_reduce_tasks 200 \
  >> ${OUT_DIR}/log_cvb.txt 2>&1 \
  && \
#./mahout cvb -i /home/carsten/Desktop/mahout-sandbox/data/rows/matrix -o /home/carsten/Desktop/mahout-sandbox/data/topics/ -dict /home/carsten/Desktop/mahout-sandbox/data/vec/ -dt /home/carsten/Desktop/mahout-sandbox/data/docTopics/ --tempDir /home/carsten/Desktop/mahout-sandbox/data/temp/ -k 10 -nt 327680 -x 10 -tf 0.1 -seed 23
#output term distributions for each topic
$MAHOUT vectordump \
  -i ${HDFS_AUS}/cas-lda \
  -d ${HDFS_OUT}/seqdir-sparse-lda/dictionary.file-* \
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
  -i ${HDFS_AUS}/cas-lda-topics/ \
  -dt sequencefile \
  --vectorSize 10 -sort true \
  -o ${OUT_DIR}/topics-doc.txt \
  -p true \
  >> ${OUT_DIR}/log_vec2.txt 2>&1 \
