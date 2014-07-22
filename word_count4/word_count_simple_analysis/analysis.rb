#! /usr/bin/ruby

def print_extract(offset, num_words=16)
  puts "-- Words #{offset-15}-#{offset+1}"
  puts `head -n+#{offset} word_counts.txt | tail -n#{num_words}`
  puts
end

def calc_offset(index)
  # used: 1.25, 1.5, 2, Math.E
  (2 ** index).to_i
end

index = 1

while(true) do
  offset = calc_offset(index)
  index += 1

  # 43740086 is the number of lines in word_counts.txt
  break if offset >= 43740086

  print_extract(offset)
end



