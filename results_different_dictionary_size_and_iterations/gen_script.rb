#! /usr/bin/ruby

i = %w(terms-topic_p2500_run_shard00_50t_10i.txt terms-topic_p20000_run_shard00_50t_10i.txt terms-topic_p500_run_shard00_50t_10i.txt terms-topic_p500_run_shard00_50t_15i.txt terms-topic_p500_run_shard00_50t_20i.txt terms-topic_p500_run_shard00_50t_5i.txt)
i.each{|v| puts "./display_result.rb #{v}"; puts "mv html/index.html html/#{v.gsub(".txt", ".html")}"}

