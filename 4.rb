EXAMPLE = <<EOF
..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.
EOF

DIRECTIONS = [
  [1,0],
  [-1,0],
  [0,1],
  [0,-1],
  [1, 1],
  [1, -1],
  [-1, 1],
  [-1, -1],
]

def accessible?(position, all_positions)
  DIRECTIONS.count do |direction|
    neighbor = [position[0] + direction[0], position[1] + direction[1]]
    next false if neighbor[0] < 0 || neighbor[1] < 0
    all_positions.include?(neighbor)
  end < 4
end

def accessible_rolls(input)
  roll_positions = Set.new
  input.lines.each_with_index do |line, row|
    line.chars.each_with_index do |char, column|
      if char == '@'
        roll_positions.add([row, column])
      end
    end
  end

  roll_positions.count do |position|
    accessible?(position, roll_positions)
  end
end

def accessible_rolls_2(input)
  roll_positions = Set.new
  input.lines.each_with_index do |line, row|
    line.chars.each_with_index do |char, column|
      if char == '@'
        roll_positions.add([row, column])
      end
    end
  end

  total_count = 0
  loop do
    current_count = 0
    positions_to_delete = []
    roll_positions.each do |position|
      if accessible?(position, roll_positions)
        current_count += 1
        positions_to_delete.push(position)
      end
    end

    positions_to_delete.each do |position|
      roll_positions.delete(position)
    end
    total_count += current_count

    break if current_count == 0
  end

  total_count
end

puts accessible_rolls(File.read('input4'))
puts accessible_rolls_2(File.read('input4'))
