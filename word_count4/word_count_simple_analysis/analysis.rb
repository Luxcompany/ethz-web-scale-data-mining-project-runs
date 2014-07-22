#! /usr/bin/ruby

def command(offset, num_words=16)
  puts "-- Words #{offset-15}-#{offset+1}"
  puts `head -n+#{offset} word_counts.txt | tail -n#{num_words}`
  puts
end

index = 16

while(index < 43740086) do
  command(index)
  index = index * 2
end



