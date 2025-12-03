def max_joltage(line, length)
  batteries = line.chars.map(&:to_i)
  sum = 0
  lower_index = 0
  (0...length).each do |i|
    subarray = batteries[lower_index...(batteries.length-length+i)]
    max_value = subarray.max
    max_index = subarray.index(max_value) + lower_index
    sum = sum * 10
    sum += max_value
    lower_index = max_index + 1
  end
  sum
end

def part1(input)
  input.lines.sum do |line|
    max_joltage(line, 2)
  end
end

def part2(input)
  input.lines.sum do |line|
    max_joltage(line, 12)
  end
end

EXAMPLE = <<EOF
987654321111111
811111111111119
234234234234278
818181911112111
EOF

puts part1(File.read('input3'))
puts part2(File.read('input3'))
