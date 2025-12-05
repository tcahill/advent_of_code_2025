def fresh_ingredients(input)
  fresh_ranges, ingredients = input.split("\n\n")
  fresh_ranges = fresh_ranges.lines.map do |r|
    start, finish = r.split('-').map(&:to_i)
    Range.new(start, finish)
  end

  ingredients.lines.map(&:to_i).count do |ingredient|
    fresh_ranges.any? do |r|
      r.include?(ingredient)
    end
  end
end

def all_fresh_ingredients(input)
  fresh_ranges, _ingredients = input.split("\n\n")
  range_bounds = fresh_ranges.lines.flat_map do |r|
    start, finish = r.split('-').map(&:to_i)
    [[start, 1], [finish, -1]]
  end.sort_by! { |r| [r[0], -r[1]] }


  total = 0
  in_range = 0
  start = 0
  finish = 0
  range_bounds.each_with_index do |bound, i|
    in_range += bound[1]
    if in_range == 1 && bound[1] == 1
      start = bound[0]
    elsif in_range == 0 && bound[1] == -1
      finish = bound[0]
      total += finish - start + 1
     end
  end
  total
end

EXAMPLE = <<EOF
3-5
10-14
16-20
12-18
12-12

1
5
8
11
17
32
EOF

puts fresh_ingredients(File.read('input5'))
puts all_fresh_ingredients(File.read('input5'))
