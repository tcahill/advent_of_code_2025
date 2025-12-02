def part1(input)
  position = 50
  password = 0

  input.lines.each do |line|
    direction = line[0]
    rotation = line[1..].to_i
    if direction == 'L'
      position = (position - rotation) % 100
    elsif direction == 'R'
      position = (position + rotation) % 100
    end

    if position == 0
      password += 1
    end
  end

  password
end

def part2(input)
  position = 50
  password = 0

  input.lines.each do |line|
    direction = line[0]
    rotation = line[1..].to_i
    clicks = 0
    if direction == 'L'
      clicks = -1 * ((position - rotation) / 100)
    elsif direction == 'R'
      clicks = (position + rotation) / 100
    end
    
    if position == 0
      clicks += 1
    end

    password += clicks
  end

  password
end

input = File.read('./input1')
puts part1(input)
puts part2(input)
