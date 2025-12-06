def grand_total(input)
  args = input.lines[...-1].map do |row|
    row.split.map(&:to_i)
  end

  operations = input.lines[-1].split

  operations.each_with_index.sum do |operation, column|
    if operation == '+'
      args.reduce(0) do |total, arg_row|
        total + arg_row[column]
      end
    elsif operation == '*'
      args.reduce(1) do |total, arg_row|
        total * arg_row[column]
      end
    end
  end
end

def cephalapod_total(input)
  numbers = input.lines[...-1].map { |line| line.chars }
  number_size = input.lines[...-1].length
  args = (0...numbers[0].length).map do |column|
    (0...number_size).reduce(0) do |total, row|
      n = numbers[row][column]
      if n.ord >= 49 && n.ord <= 57
        total = total * 10
        total += n.to_i
      elsif total == 0 && row == numbers.length - 1
        total = nil
      end
      total
    end
  end

  operations = []
  input.lines[-1].chars.each_with_index do |c, i|
    if ['+', '*'].include?(c)
      operations.push([c, i])
    end
  end

  operations.sum do |operation|
    current_index = operation[1]
    total = 0
    if operation[0] == '*'
      total = 1
    end
    
    while !args[current_index].nil? do
      if operation[0] == '*'
        total = total * args[current_index]
      elsif operation[0] == '+'
        total += args[current_index]
      end

      current_index += 1
    end

    total
  end
end

EXAMPLE = <<EOF
123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +
EOF

puts grand_total(File.read('input6'))
puts cephalapod_total(File.read('input6'))
