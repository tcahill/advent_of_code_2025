def beam_split_count(input)
  grid = input.lines.map(&:chars)
  
  splitters = grid.each_with_index.flat_map do |row, i|
    row.each_with_index.select do |column, j|
      column == '^'
    end.map { |c| [i, c[1]] }
  end.to_set

  beams = grid.each_with_index.flat_map do |row, i|
    row.each_with_index.select do |column, j|
      column == 'S'
    end.map { |c| [i, c[1]] }
  end.to_set

  splits = 0
  max_row = grid.length - 1
  max_column = grid[0].length - 1
  while beams.length > 0
    splits += advance_beams(beams, splitters)
    beams = beams.select do |beam|
      beam[0] >= 0 && beam[0] <= max_row && beam[1] >=0 && beam[1] <= max_column
    end.to_set
  end

  splits
end

def advance_beams(beams, splitters)
  new_beams = []
  splits = 0
  
  beams.each do |beam|
    beam[0] += 1
    if splitters.include?(beam)
      new_beams.push([beam[0], beam[1] + 1])
      beam[1] -= 1
      splits += 1
    end
  end

  beams.merge(new_beams)

  splits
end

def beam_timeline_count(input)
  grid = input.lines.map(&:chars)
  
  splitters = grid.each_with_index.flat_map do |row, i|
    row.each_with_index.select do |column, j|
      column == '^'
    end.map { |c| [i, c[1]] }
  end.to_set

  beam = grid.each_with_index.flat_map do |row, i|
    row.each_with_index.select do |column, j|
      column == 'S'
    end.map { |c| [i, c[1]] }
  end[0]

  worlds = { beam => 1 }
  max_row = grid.length - 1
  max_column = grid[0].length - 1
  world_count = 0
  while worlds.any? { |beam, _count| in_bounds?(beam, max_row, max_column) }
    next_worlds = {}
    worlds.each do |beam, count|
      possible_next_positions(beam, splitters).each do |position|
        next_worlds[position] ||= 0
        next_worlds[position] += count
      end
    end
    worlds = next_worlds
  end

  worlds.values.sum
end

def in_bounds?(beam, max_row, max_column)
  beam[0] >= 0 && beam[0] <= max_row && beam[1] >= 0 && beam[1] <= max_column
end

def possible_next_positions(beam, splitters)
  beam[0] += 1
  if splitters.include?(beam)
    [[beam[0], beam[1] - 1], [beam[0], beam[1] + 1]]
  else
    [beam]
  end
end


EXAMPLE = <<EOF
.......S.......
...............
.......^.......
...............
......^.^......
...............
.....^.^.^.....
...............
....^.^...^....
...............
...^.^...^.^...
...............
..^...^.....^..
...............
.^.^.^.^.^...^.
...............
EOF

puts beam_split_count(File.read('input7'))
puts beam_timeline_count(File.read('input7'))
