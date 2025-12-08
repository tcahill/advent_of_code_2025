def connect_pairs(input)
  boxes = input.lines.map { |line| line.split(',').map(&:to_i) }
  distances = boxes.combination(2).map do |box1, box2|
    [squared_distance(box1, box2), [box1, box2]]
  end
  distances.sort_by! { |x| x[0] }
  connections = boxes.map { |box| [box, []] }.to_h
  (0...1000).each do |i|
    _distance, b = distances[i]
    connections[b[0]].push(b[1])
    connections[b[1]].push(b[0])
  end

  circuits = calculate_circuits(connections, boxes)
  circuits.map(&:length).sort.reverse[...3].inject(:*)
end

def connect_all_pairs(input)
  boxes = input.lines.map { |line| line.split(',').map(&:to_i) }
  distances = boxes.combination(2).map do |box1, box2|
    [squared_distance(box1, box2), [box1, box2]]
  end
  distances.sort_by! { |x| x[0] }
  connections = boxes.map { |box| [box, []] }.to_h
  (0...distances.length).each do |i|
    _distance, b = distances[i]
    connections[b[0]].push(b[1])
    connections[b[1]].push(b[0])

    circuits = calculate_circuits(connections, boxes)
    return b[0][0] * b[1][0] if circuits.length == 1
  end

  nil
end

def calculate_circuits(connections, boxes)
  box_set = boxes.to_set
  circuits = []

  until box_set.empty?
    queue = [box_set.first]
    circuits.push(Set.new([box_set.first]))
    visited = Set.new
    until queue.empty?
      box = queue.pop
      box_set.delete(box)
      neighbors = connections[box]
      neighbors.each do |neighbor|
        next if visited.include?(neighbor)
        
        circuits.last.add(neighbor)
        queue.push(neighbor)
        visited.add(neighbor)
      end
    end
  end

  circuits
end

def squared_distance(box1, box2)
  (box1[0] - box2[0])**2 + (box1[1] - box2[1])**2 + (box1[2] - box2[2])**2
end

EXAMPLE = <<EOF
162,817,812
57,618,57
906,360,560
592,479,940
352,342,300
466,668,158
542,29,236
431,825,988
739,650,466
52,470,668
216,146,977
819,987,18
117,168,530
805,96,715
346,949,466
970,615,88
941,993,340
862,61,35
984,92,344
425,690,689
EOF

puts connect_pairs(File.read('input8'))
puts connect_all_pairs(File.read('input8'))
