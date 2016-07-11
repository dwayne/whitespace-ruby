module Whitespace::ISA
  class Swap < Instruction
    def execute
      a = vm.vstack.pop
      b = vm.vstack.pop

      vm.vstack.push a
      vm.vstack.push b
    end
  end
end
