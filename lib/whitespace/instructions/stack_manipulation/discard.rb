module Whitespace::ISA
  class Discard < Instruction
    def execute
      vm.vstack.pop
    end
  end
end
