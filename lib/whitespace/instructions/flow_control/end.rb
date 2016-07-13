module Whitespace::ISA
  class End < Instruction
    def execute
      raise Whitespace::Halt
    end
  end
end
