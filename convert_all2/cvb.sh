#!/bin/bash

MAHOUT="mahout"
WORK_DIR="`pwd`/out"
HDFS_DIR="/convert-all2"
echo "creating work directory at ${WORK_DIR}"


# generate ./out/out-seqdir with HTML conversion script
# spark/bin/spark-submit --master local[4] --class HtmlToTextConversionApp /disk3/user_work/runs/convert_all2/run.jar

hdfs dfs -mkdir /convert-all2
hdfs dfs -put ${WORK_DIR}/data /convert-all2/out-seqdir \
&& \
$MAHOUT seq2sparse \
#-i /convert-all2/out-seqdir/ \
# TODO: doesn't work with subdirectories
  -i /convert-all2/out-seqdir/ClueWeb12_00/0000tw \
  -o /convert-all2/out-seqdir-sparse-lda -ow --maxDFPercent 85 --namedVector \
&& \
$MAHOUT rowid \
  -i /convert-all2/out-seqdir-sparse-lda/tfidf-vectors \
  -o /convert-all2/out-matrix \
&& \

rm -rf /convert-all2/lda /convert-all2/lda-topics /convert-all2/lda-model \
&& \
$MAHOUT cvb \
  -i /convert-all2/out-matrix/matrix \
  -o /convert-all2/lda -k 20 -ow -x 20 \
  -dict /convert-all2/out-seqdir-sparse-lda/dictionary.file-* \
  -dt /convert-all2/lda-topics \
  -mt /convert-all2/lda-model \
&& \
$MAHOUT vectordump \
  -i /convert-all2/lda-topics/part-m-00000 \
  -o ${WORK_DIR}/vectordump \
  -vs 10 -p true \
  -d /convert-all2/out-seqdir-sparse-lda/dictionary.file-* \
  -dt sequencefile -sort /convert-all2/lda-topics/part-m-00000 \
  && \
cat ${WORK_DIR}/vectordump


