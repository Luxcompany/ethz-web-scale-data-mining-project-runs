#! /bin/bash

rm -f run.jar

cd repo
git pull

cd src/remove_infrequent_words
sbt assembly

cd ../../..
cp repo/src/remove_infrequent_words/target/scala-2.10/RemoveInfrequentWordsApp-assembly-1.0.jar run.jar

