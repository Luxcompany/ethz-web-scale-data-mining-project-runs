# Simple word count on the cleaned dataset

## Version

https://github.com/lukaselmer/ethz-web-scale-data-mining-project/tree/8dbe8eb1f4e885cc212e0161492a6a5a7a696d05/src/remove_infrequent_words

## Usage

<param1>=<value1> <param2>=<value2> ... mahout-submit ...
Options
MIN_WORD_COUNT: number, how many times a word has to occur at least to be kept
[optional] MAX_WORD_COUNT: default: Int.MaxInt
[optional] OUTPUT: default: hdfs://dco-node121.dco.ethz.ch:54310/cw-combined-pruned
[optional] INPUT_COMBINED: default: hdfs://dco-node121.dco.ethz.ch:54310/cw-combined
[optional] INPUT_WORDCOUNT: default: hdfs://dco-node121.dco.ethz.ch:54310/cw-wordcount/wordcounts.txt


