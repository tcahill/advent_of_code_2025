DIRECTIONS = [
  [1, 0],
  [-1, 0],
  [0, 1],
  [0, -1],
].freeze

def largest_rectangle(input)
  points = input.lines.map { |line| line.split(',').map(&:to_i) }

  max_area = 0
  points.each_with_index do |a, i|
    points[i+1..].each do |b|
      max_area = [area(a, b), max_area].max
    end
  end

  max_area
end

def largest_redgreen_rectangle(input)
  red_tiles = input.lines.map { |line| line.split(',').map(&:to_i) }

  max_area = 0
  red_tiles.each_with_index do |a, i|
    red_tiles[i+1..].each do |b|
      if all_tiles?(a, b, red_tiles)
        max_area = [area(a, b), max_area].max
      end
    end
  end

  max_area
end

def all_tiles?(a, b, red_tiles)
  x_range = [a[0], b[0]].sort
  y_range = [a[1], b[1]].sort

  red_tiles.each_with_index.all? do |tile, i|
    next_tile = red_tiles[(i + 1) % red_tiles.length]

    edge_x = [tile[0], next_tile[0]].sort
    edge_y = [tile[1], next_tile[1]].sort

    edge_x[1] <= x_range[0] || edge_x[0] >= x_range[1] || edge_y[1] <= y_range[0] || edge_y[0] >= y_range[1]
  end
end

def area(a, b)
  ((b[0] - a[0]).abs + 1) * ((b[1] - a[1]).abs + 1)
end

EXAMPLE = <<EOF
7,1
11,1
11,7
9,7
9,5
2,5
2,3
7,3
EOF

puts largest_rectangle(File.read('input9'))
puts largest_redgreen_rectangle(File.read('input9'))
