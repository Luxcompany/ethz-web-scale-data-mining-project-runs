#!/bin/bash

MIN_WORD_COUNT=500
OUT_DIR=`pwd`

MIN_WORD_COUNT="${MIN_WORD_COUNT}" OUTPUT="hdfs://dco-node121.dco.ethz.ch:54310/cw-combined-pruned-${MIN_WORD_COUNT}" /root/spark/bin/spark-submit --num-executors 20 --class RemoveInfrequentWordsApp ${OUT_DIR}/run.jar > ${OUT_DIR}/log.log 2>&1
