test_instructions = File.readlines("/Users/kph/Stuff/aoc2015/day7/test-input.txt").map(&:strip)
instructions = File.readlines("/Users/kph/Stuff/aoc2015/day7/input.txt").map(&:strip)

class CircuitEmulator
  attr_accessor :wires

  def initialize
    self.wires = Hash.new(0)
  end

  def value_for(wire)
    wires[wire].evaluate(wires)
  end

  def build(instructions)
    instructions.each do |instruction|
      lhs, rhs = instruction.split("->").map(&:strip).map { |s| s.split(' ') }
      wires[rhs.first] = if lhs.count == 1
        InputGate.new(lhs.first)
      elsif lhs.first == "NOT"
        NotGate.new(lhs.last)
      elsif lhs[1] == "AND"
        AndGate.new(lhs[0], lhs[2])
      elsif lhs[1] == "OR"
        OrGate.new(lhs[0], lhs[2])
      elsif lhs[1] == "LSHIFT"
        LeftShiftGate.new(lhs[0], lhs[2])
      elsif lhs[1] == "RSHIFT"
        RightShiftGate.new(lhs[0], lhs[2])
      end
    end
    self
  end

  class Gate
    def value_of(thing, wires)
      thing =~ /^\d+$/ ? thing.to_i : wires[thing].evaluate(wires)
    end
  end

  class SingleValueGate < Gate
    attr_accessor :operand, :result
    def initialize(operand)
      self.operand = operand
    end

    def evaluate(wires)
      self.result = operate(value_of(operand, wires)) if result.nil?
      result
    end
  end

  class InputGate < SingleValueGate
    def operate(value)
      value
    end
  end

  class NotGate < SingleValueGate
    def operate(value)
      ~value & 0xFFFF
    end
  end

  class TwoValueGate < Gate
    attr_accessor :lhs, :rhs, :result
    def initialize(lhs, rhs)
      self.lhs = lhs
      self.rhs = rhs
    end

    def evaluate(wires)
      self.result = operate(value_of(lhs, wires), value_of(rhs, wires)) if result.nil?
      result
    end
  end

  class AndGate < TwoValueGate
    def operate(one, two)
      one & two
    end
  end

  class OrGate < TwoValueGate
    def operate(one, two)
      one | two
    end
  end

  class LeftShiftGate < TwoValueGate
    def operate(one, two)
      (one << two) & 0xFFFF
    end
  end

  class RightShiftGate < TwoValueGate
    def operate(one, two)
      one >> two
    end
  end

end

test_emulator = CircuitEmulator.new.build(test_instructions)
# d: 72
# e: 507
# f: 492
# g: 114
# h: 65412
# i: 65079
# x: 123
# y: 456
values = ["d", "e", "f", "g", "h", "i", "x", "y"].map { |w| test_emulator.value_for(w) }
puts "Values are #{values}"

# part 1
emulator = CircuitEmulator.new.build(instructions)
a = emulator.value_for("a")
puts "Value for a is #{a}" # 46065

# part 2
new_emulator = CircuitEmulator.new.build(instructions)
new_emulator.wires["b"] = CircuitEmulator::InputGate.new(a.to_s)
a = new_emulator.value_for("a")
puts "New value for a is #{a}" # 46065
