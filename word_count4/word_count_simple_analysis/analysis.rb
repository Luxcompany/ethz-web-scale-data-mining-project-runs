#! /usr/bin/ruby

# small: num_words=16
# large: num_words=150
def print_extract(offset, num_words=150)
  # very cheap workaround for corner case...
  offset = 0 if offset < num_words

  puts "-- Words #{offset + 1}-#{offset + num_words + 1}"
  puts `head -n+#{offset + num_words} word_counts.txt | tail -n#{num_words}`
  puts
end

def calc_offset(index)
  # used: 1.25, 1.5, 2, Math.E
  (2 ** index).to_i
end

index = 7

while(true) do
  offset = calc_offset(index)

  # 43740086 is the number of lines in word_counts.txt
  break if offset >= 43740086

  print_extract(offset)
  index += 1
end



