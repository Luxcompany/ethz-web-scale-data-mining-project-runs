#!/bin/bash

RUN="2"
OUT_DIR="/disk3/user_work/runs/remove_infrequent_words${RUN}"

OUTPUT="hdfs://dco-node121.dco.ethz.ch:54310/cw-combined-pruned-500" MIN_WORD_COUNT=500 /root/spark/bin/spark-submit --class RemoveInfrequentWordsApp ${OUT_DIR}/run.jar >> ${OUT_DIR}/log.log 2>&1


