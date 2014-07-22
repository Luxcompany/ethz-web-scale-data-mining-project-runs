#!/bin/bash

#Following: http://theglassicon.com/computing/machine-learning/running-lda-algorithm-mahout
# and http://www.slideshare.net/Hadoop_Summit/stella-june27-1150amroom210av2
# and http://stackoverflow.com/questions/21318459/how-to-run-mahout-cvb-on-reuters-news-on-cloudera-vm-cdh4-5-as-lda-is-not-longer
# and http://qnalist.com/questions/4878421/extracting-document-topic-inference-with-the-new-lda-cvb-algorithm
RUN="3"
HDFS_DIR="/runs/r${RUN}"
WORK_DIR="`pwd`"
OUT_DIR="/disk3/user_work/runs/word_count${RUN}"

/root/spark/bin/spark-submit --class WordCountApp ${OUT_DIR}/run.jar >> ${OUT_DIR}/log.log 2>&1


