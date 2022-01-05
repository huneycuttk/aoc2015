def execute(instructions, a = 0, b = 0)
  registers = { pc: 0, a: a, b: b }
  while registers[:pc] < instructions.count
    instruction, *args = instructions[registers[:pc]].split(' ')
    case(instruction)
    when "hlf"
      reg = args[0]
      registers[reg.to_sym] /= 2
      registers[:pc] += 1

    when "tpl"
      reg = args[0]
      registers[reg.to_sym] *= 3
      registers[:pc] += 1

    when "inc"
      reg = args[0]
      registers[reg.to_sym] += 1
      registers[:pc] += 1

    when "jmp"
      count = args[0].to_i
      registers[:pc] += count

    when "jie"
      reg = args[0][0]
      count = args[1].to_i
      if registers[reg.to_sym] % 2 == 0
        registers[:pc] += count
      else
        registers[:pc] += 1
      end
    when "jio"
      reg = args[0][0]
      count = args[1].to_i
      if registers[reg.to_sym] == 1
        registers[:pc] += count
      else
        registers[:pc] += 1
      end
    end
  end

  return registers
end

program = File.readlines("/Users/kph/Stuff/aoc2015/day23/input.txt").map(&:strip)
result = execute(program, 0, 0)
puts "Registers are #{result}" # 170

result = execute(program, 1, 0)
puts "Registers are #{result} with a = 1" # 247
