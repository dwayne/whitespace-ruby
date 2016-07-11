module Whitespace::ISA
  class Dup < Instruction
    def execute
      vm.vstack.push vm.vstack.top
    end
  end
end
