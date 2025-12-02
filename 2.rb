def invalid?(n)
  s = n.to_s
  t = s[...(s.length / 2)]
  u = s[(s.length / 2)..]
  t == u
end

def part1(input)
  ranges = input.split(',')
  invalid_count = 0
  ranges.each do |range|
    first, last = range.split('-').map(&:to_i)
    (first..last).each do |i|
      if invalid?(i)
        invalid_count += i
      end
    end
  end

  invalid_count
end

def invalid2?(n)
  s = n.to_s
  repeating_length = 1
  while repeating_length <= s.length / 2
    if s.chars.each_slice(repeating_length).uniq.size == 1
      return true
    end

    repeating_length += 1
  end

  false
end

def part2(input)
  ranges = input.split(',')
  invalid_count = 0
  ranges.each do |range|
    first, last = range.split('-').map(&:to_i)
    (first..last).each do |i|
      if invalid2?(i)
        invalid_count += i
      end
    end
  end

  invalid_count
end

EXAMPLE = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

puts part1(File.read('input2'))
puts part2(File.read('input2'))
