#!/bin/bash

MIN_WORD_COUNT=10000
OUT_DIR=`pwd`

MIN_WORD_COUNT="${MIN_WORD_COUNT}" INPUT_COMBINED="hdfs://dco-node121.dco.ethz.ch:54310/cw-combined-pruned-2500" OUTPUT="hdfs://dco-node121.dco.ethz.ch:54310/cw-combined-pruned-${MIN_WORD_COUNT}" /root/spark/bin/spark-submit --class RemoveInfrequentWordsApp ${OUT_DIR}/run.jar > ${OUT_DIR}/log.log 2>&1
